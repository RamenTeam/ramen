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
const OFFER_EVENT = 'offer-event';
const ANSWER_EVENT = 'answer-event';
const ICE_CANDIDATE_EVENT = 'ice-candidate-event';
const MATCHMAKING_EVENT = 'match-making-event';

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

  handleConnection(client: Socket, ...args: any[]) {
    console.log(`Client connected: ${client.id}`);

    this.service.addClient(client);

    console.log('Client list: ', {
      Keys: _.keys(this.service.clientList),
      Length: _.size(this.service.clientList),
    });

    client.emit(CLIENT_ID_EVENT, client.id);
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);

    this.service.removeClient(client);
    this.service.removeOffer(client);
    this.service.removeAnswer(client);

    console.log('Client list: ', {
      Keys: _.keys(this.service.clientList),
      Length: _.size(this.service.clientList),
    });
  }

  // ! OFFER_EVENT
  @SubscribeMessage(OFFER_EVENT)
  async onOfferEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { description: any },
  ): Promise<number> {
    if (_.isEmpty(this.service.offerList)) {
      this.service.addOffer(client, data.description);
      console.log('Offer List: ', {
        Offers: this.service.offerList,
        Length: _.size(this.service.offerList),
      });
    } else {
      console.log('AnswerEvent');
    }

    return 0;
  }
  // ! ANSWER_EVENT
  @SubscribeMessage(ANSWER_EVENT)
  async onAnswerEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { description: any },
  ): Promise<number> {
    return 0;
  }

  // ! ICE_CANDIDATE_EVENT
  @SubscribeMessage(ICE_CANDIDATE_EVENT)
  async onIceCandidateEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { isHost: boolean; candidate: any },
  ): Promise<number> {
    return 0;
  }

  // ! GENERAL
  @SubscribeMessage(MATCHMAKING_EVENT)
  async onMatchmakingEvent(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { description },
  ) {
    // If there's no one offering
    if (_.isEmpty(this.service.offerList)) {
      console.log('[...] Offer');
      this.service.removeOffer(client);
      // Add the offer with a description
      this.service.addOffer(client, data.description);
      console.log('Offer List: ', {
        Offers: this.service.offerList,
        Length: _.size(this.service.offerList),
      });
    } else {
      console.log('[...] Answer');
      this.service.removeAnswer(client);

      // Find a random offer from offer list
    }
  }
}
