import { ObjectType } from "type-graphql";
import { ChildEntity } from "typeorm";
import { Conversation } from "./Conversation";

@ObjectType("DirectConversationSchema")
@ChildEntity("DirectConversation")
export class DirectConversation extends Conversation {}
