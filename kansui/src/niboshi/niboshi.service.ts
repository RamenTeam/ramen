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

type Room = {
  host: string;
  peer: string;
};

@Injectable()
export class NiboshiService {
  public clientList: ClientList = {};
  public availableClientList: ClientList = {};
  public roomList: Room[] = [];

  // ! CLIENT
  findClient(clientId: string) {
    return this.clientList[clientId];
  }

  addClient(client: Socket) {
    this.clientList[client.id] = client;
  }

  removeClient(clientId: string) {
    delete this.clientList[clientId];
  }

  // ! AVAILABLE CLIENT
  findAvailableClient(clientId: string) {
    return this.availableClientList[clientId];
  }

  addAvailableClient(client: Socket) {
    this.availableClientList[client.id] = client;
  }

  removeAvailableClient(clientId: string) {
    delete this.availableClientList[clientId];
  }

  // ! ROOM
  addRoom(client: Socket, peerId: string) {
    this.roomList.push({ host: client.id, peer: peerId });
  }
  removeRoom(client: Socket) {
    for (let i = 0; i < this.roomList.length; i++) {
      if (
        this.roomList[i].host == client.id ||
        this.roomList[i].peer == client.id
      ) {
        this.roomList.splice(i, 1);
      }
    }
  }
  findRoom(clientId: string) {
    for (let i = 0; i < this.roomList.length; i++) {
      if (
        this.roomList[i].host == clientId ||
        this.roomList[i].peer == clientId
      ) {
        return this.roomList[i];
      }
    }
  }

  findPeerId(hostId: string) {
    for (let i = 0; i < this.roomList.length; i++) {
      if (this.roomList[i].host == hostId) {
        return this.roomList[i].peer;
      }
    }
  }

  findHostId(peerId: string) {
    for (let i = 0; i < this.roomList.length; i++) {
      if (this.roomList[i].peer == peerId) {
        return this.roomList[i].host;
      }
    }
  }
}
