import { Module } from '@nestjs/common';
import { NiboshiModule } from './niboshi/niboshi.module';

@Module({
  imports: [NiboshiModule],
  providers: [],
})
export class AppModule {}
