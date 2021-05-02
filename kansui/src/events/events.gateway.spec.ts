import { Test, TestingModule } from '@nestjs/testing';
import { EventsGateway } from './events.gateway';
import { EventsService } from './events.service';
import * as dotenv from 'dotenv';
import { WsAdapter } from '@nestjs/platform-ws';
import SocketClient from 'socket.io-client';

dotenv.config();

describe('EventsGateway', () => {
  let gateway: EventsGateway;

  let app, client: SocketIOClient.Socket;

  beforeAll(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EventsGateway, EventsService],
    }).compile();

    gateway = module.get<EventsGateway>(EventsGateway);
    app = module.createNestApplication();
    app.useWebSocketAdapter(new WsAdapter(app));

    await app.init();

    const address = app.getHttpServer().listen().address();
    const baseAddress = `http://[${address.address}]:${address.port}`;

    client = SocketClient.connect(`${baseAddress}/some-namespace`);
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });

  it('should connect successfully', async (done) => {
    client.on('open', () => {
      console.log('I am connected! YEAAAP');
      done();
    });

    client.on('close', (code, reason) => {
      done({ code, reason });
    });

    client.on('error', (error) => {
      done(error);
    });
  });
});
