import { Injectable } from '@nestjs/common';
import { Socket } from 'socket.io';

interface ClientList {
  [key: string]: Socket;
}
@Injectable()
export class EventsService {
  public clientList: ClientList = {};
  public roomList: any = [];

  findClient(clientId: string) {
    return this.clientList[clientId];
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

  /**
   * TODO Add connected client into clientList
   * @chungquantin
   */

  addClient(client: Socket) {
    this.clientList[client.id] = client;
  }

  /**
   * TODO Add room to a roomList with
   * -> The host is a client --offer-->
   * -> The host is also a first peer
   */
  addRoom(client: Socket, peerId: string) {
    this.roomList.push({ host: client.id, peer: peerId });
  }

  /**
   * TODO Remove the client from clientList
   * @chungquantin
   */
  removeClient(client: Socket) {
    delete this.clientList[client.id];
  }

  removeRoom(client: Socket) {
    /**
     * TODO Remove the room which the client is a host or peer
     * @chungquantin
     */
    for (let i = 0; i < this.roomList.length; i++) {
      if (
        this.roomList[i].host == client.id ||
        this.roomList[i].peer == client.id
      ) {
        this.roomList.splice(i, 1);
      }
    }
  }
}
