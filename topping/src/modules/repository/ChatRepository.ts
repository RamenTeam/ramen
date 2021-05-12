import { EntityRepository, Repository } from "typeorm";
import { Message } from "../../entity/Message";

@EntityRepository(Message)
export class ChatRepository extends Repository<Message> {}
