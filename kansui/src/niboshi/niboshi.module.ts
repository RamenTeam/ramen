import { Module } from '@nestjs/common';
import { NiboshiService } from './niboshi.service';
import { NiboshiGateway } from './niboshi.gateway';

@Module({
  providers: [NiboshiGateway, NiboshiService],
})
export class NiboshiModule {}
