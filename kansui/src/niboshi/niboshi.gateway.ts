import { NiboshiService } from './niboshi.service';
import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Logger } from '@nestjs/common';
import { Server, Socket } from 'socket.io';
import * as _ from 'lodash';

const CLIENT_ID_EVENT = 'client-id-event';
const MATCHMAKING_EVENT = 'matchmaking-event';
const OFFER_EVENT = 'offer-event';
const ANSWER_EVENT = 'answer-event';
const ICE_CANDIDATE_EVENT = 'ice-candidate-event';

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
    let availableRooms = _.clone(roomList).filter(
      (room) => room.peer == null && room.host !== client.id,
    );
    console.log(availableRooms);

    if (availableRooms.length > 0) {
      // ! There's room opened
      let availableClientKeys = _.clone(availableRooms).map(({ host }) => host);
      let randomClient = _.sample(availableClientKeys);
      let randomRoom = this.service.findRoom(randomClient);
      randomRoom.peer = client.id;
      console.log(randomClient, roomList);
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
          this.service.removeClient(client.id);
          this.service.removeRoom(client);
          client.emit(MATCHMAKING_EVENT, { data: { peer: null } });
        } else {
          console.log('Keep waiting...');
        }
        console.log('Server Info: ', {
          client: clientKeys,
          room: this.service.roomList,
          numberOfClient: clientKeys.length,
        });
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

  @SubscribeMessage(OFFER_EVENT)
  async onOfferEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { peerId: string; description: any },
  ): Promise<number> {
    console.log('OFFER_EVENT 🔔');
    // console.log('data: ', data);
    console.log(data.peerId);

    const peer = this.service.findClient(data.peerId);

    if (peer) {
      peer.emit(OFFER_EVENT, { data: { description: data.description } });
    } else {
      console.log('onOfferEvent: Peer does not found');
    }
    return 0;
  }

  @SubscribeMessage(ANSWER_EVENT)
  async onAnswerEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { hostId: string; description: any },
  ): Promise<number> {
    console.log('ANSWER_EVENT 🔔');
    // console.log('data: ', data);

    const host = this.service.findClient(data.hostId);
    console.log(data.hostId);

    if (host) {
      host.emit(ANSWER_EVENT, { data: { description: data.description } });
    } else {
      console.log('onAnswerEvent: Host does not found');
    }
    return 0;
  }

  // ! ICE_CANDIDATE_EVENT
  @SubscribeMessage(ICE_CANDIDATE_EVENT)
  async onIceCandidateEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { isHost: boolean; candidate: any },
  ): Promise<number> {
    // console.log(data);

    let clientId;
    console.log(this.service.roomList);
    if (data.isHost) {
      clientId = this.service.findPeerId(client.id);
    } else {
      clientId = this.service.findHostId(client.id);
    }

    const peer = this.service.findClient(clientId);

    console.log('ICE PEER: ', peer?.id);

    if (peer) {
      peer.emit(ICE_CANDIDATE_EVENT, { data: { candidate: data.candidate } });
    } else {
      console.log('onIceCandidateEvent: Peer does not found');
    }
    return 0;
  }
}
