import { Injectable } from '@nestjs/common';
import { Socket } from 'socket.io';

type ClientList = {
  [key: string]: Socket;
};
type Candidate = {
  candidate: string;
  sdpMid: string;
  sdpMlineIndex: number;
};

type OfferList = {
  [key: string]: string;
};

type AnswerList = {
  [key: string]: string;
};

@Injectable()
export class NiboshiService {
  public clientList: ClientList = {};
  public offerList: OfferList = {};
  public answerList: AnswerList = {};

  // ! CLIENT

  findClient(clientId: string) {
    return this.clientList[clientId];
  }

  addClient(client: Socket) {
    this.clientList[client.id] = client;
  }

  removeClient(client: Socket) {
    delete this.clientList[client.id];
  }

  // ! ANSWER

  findAnswer(clientId: string) {
    return this.answerList[clientId];
  }

  addAnswer(client: Socket, description: string) {
    this.answerList[client.id] = description;
  }

  removeAnswer(client: Socket) {
    delete this.answerList[client.id];
  }

  // ! OFFER

  findOffer(clientId: string) {
    return this.offerList[clientId];
  }

  addOffer(client: Socket, description: string) {
    this.offerList[client.id] = description;
  }

  removeOffer(client: Socket) {
    delete this.offerList[client.id];
  }
}
