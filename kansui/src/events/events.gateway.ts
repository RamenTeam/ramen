import { EventsService } from './events.service';
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

const CLIENT_ID_EVENT = 'client-id-event';
const OFFER_EVENT = 'offer-event';
const ANSWER_EVENT = 'answer-event';
const ICE_CANDIDATE_EVENT = 'ice-candidate-event';

/**
 * TODO Know issue
 * If the user click on the find chat partner button
 * TODO connect
 * -> connect to a server and sending an offer
 * --> client_1 ---offer---> client_2
 * --> client_2 ---answer---> client_1
 *
 * TODO end conversation
 * -> back to a normal state as waiting and sending another offer
 */
@WebSocketGateway(80, { namespace: 'events', transports: ['websocket'] })
export class EventsGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server | undefined;

  private logger: Logger = new Logger('AppGateway');

  constructor(private readonly service: EventsService) {}

  afterInit({ server }: { server: Server }) {
    this.logger.log(`Init socket server ${server.path?.()}`);
  }

  /**
   * Whenever a client connects to a websocket server
   * TODO Click on the "Find chat partner button"
   * -> The clientList is updated with the client added
   * -> Emit a message to a user about the client-id event
   * @chungquantin
   */
  handleConnection(client: Socket, ...args: any[]) {
    this.logger.log(`Client connected: ${client.id}`);

    this.service.addClient(client);

    console.log(this.service.clientList);

    client.emit(CLIENT_ID_EVENT, client.id);
  }

  /**
   * Whenever a client disconnect to a user
   * TODO Conversation timeout or aborting
   * -> the client is removed from the list
   * -> all the conversation contains the client as peer or host will be destroyed
   * @chungquantin
   */
  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);

    this.service.removeClient(client);

    this.service.removeRoom(client);
  }

  /**
   * Click on a find chat partner -> connected -> offer
   * TODO Sending an offer to all user in a lobby to find a matched conversation
   */
  @SubscribeMessage(OFFER_EVENT)
  async onOfferEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { peerId: string; description: any },
  ): Promise<number> {
    console.log(data);

    this.service.addRoom(client, data.peerId);

    const peer = this.service.findClient(data.peerId);

    if (peer) {
      peer.emit(OFFER_EVENT, data.description);
    } else {
      console.log('onOfferEvent: Peer does not found');
    }
    return 0;
  }

  /**
   * Receive an offer -> sending an answer to host -> emit ANSWER_EVENT
   * TODO MediaDevice like camera is turned on and connected
   */
  @SubscribeMessage(ANSWER_EVENT)
  async onAnswerEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { description: any },
  ): Promise<number> {
    console.log(data);

    const hostId = this.service.findHostId(client.id);

    const host = this.service.findClient(hostId);

    if (host) {
      host.emit(ANSWER_EVENT, data.description);
    } else {
      console.log('onAnswerEvent: Host does not found');
    }
    return 0;
  }

  @SubscribeMessage(ICE_CANDIDATE_EVENT)
  async onIceCandidateEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { isHost: boolean; candidate: any },
  ): Promise<number> {
    console.log(data);

    let clientId;

    if (data.isHost) {
      clientId = this.service.findPeerId(client.id);
    } else {
      clientId = this.service.findHostId(client.id);
    }

    const peer = this.service.findClient(clientId);

    if (peer) {
      peer.emit(ICE_CANDIDATE_EVENT, data.candidate);
    } else {
      console.log('onIceCandidateEvent: Peer does not found');
    }
    return 0;
  }
}
