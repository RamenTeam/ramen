import { NiboshiService } from './niboshi.service';
import {
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Logger } from '@nestjs/common';
import { Server, Socket } from 'socket.io';
import * as _ from 'lodash';

const CLIENT_ID_EVENT = 'client-id-event';
const MATCHMAKING_EVENT = 'matchmaking-event';

const timer = (ms) => new Promise((res) => setTimeout(res, ms));

@WebSocketGateway({ transports: ['websocket'] })
export class NiboshiGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private logger: Logger = new Logger('AppGateway');

  constructor(private readonly service: NiboshiService) {}

  afterInit({ server }: { server: Server }) {
    this.logger.log(`Init socket server ${server?.path?.()}`);
  }

  async handleConnection(client: Socket, ...args: any[]) {
    console.log(`Client connected: ${client.id}`);

    client.emit(CLIENT_ID_EVENT, { data: { clientId: client.id } });

    this.service.addClient(client);
    let roomList = this.service.roomList;
    let clientKeys = _.keys(this.service.clientList);

    if (roomList.length > 0) {
      // ! There's room opened
      let clientKeysExceptMe = _.clone(clientKeys);
      let randomClient = _.sample(
        clientKeysExceptMe.filter((key) => key !== client.id),
      );
      console.log(randomClient, roomList);
      let randomRoom = this.service.findRoom(randomClient);
      randomRoom.peer = client.id;
      console.log('Room found! Wait for signal from host...');
    } else {
      // ! Create your own room and wait
      this.service.addRoom(client, null);
      let retryInterval = 0;
      while (retryInterval < 5) {
        let myRoom = this.service.findRoom(client.id);
        console.log(myRoom);
        if (myRoom.peer !== null) {
          console.log('Someone joins my room');

          let peer = this.service.findClient(myRoom.peer);

          console.log(myRoom);
          peer.emit(MATCHMAKING_EVENT, { data: { ...myRoom } });
          client.emit(MATCHMAKING_EVENT, { data: { ...myRoom } });
          break;
        }

        await timer(3000);
        if (retryInterval == 4) {
          console.log("There's no one here!");
          client.emit(MATCHMAKING_EVENT, { data: { peerId: null } });
        } else {
          console.log('Keep waiting...');
          console.log('Server Info: ', {
            client: clientKeys,
            room: this.service.roomList,
            numberOfClient: clientKeys.length,
          });
        }
        retryInterval++;
      }
    }
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);

    this.service.removeClient(client.id);
    // this.service.removeAvailableClient(client.id);
    this.service.removeRoom(client);

    console.log('Server Info: ', {
      client: _.keys(this.service.clientList),
      numberOfClient: _.size(this.service.clientList),
    });
  }
}
