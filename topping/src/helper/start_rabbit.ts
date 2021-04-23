import * as amqp from "amqplib/callback_api";

const retryInterval = 5000;

export type VoiceSendDirection = "recv" | "send";

export interface HandlerDataMap {
	"hello-world": { roomId: string; peerId: string };
}

export type HandlerMap = {
	[Key in keyof HandlerDataMap]: (
		d: HandlerDataMap[Key],
		uid: string,
		send: <Key extends keyof OutgoingMessageDataMap>(
			obj: OutgoingMessage<Key>
		) => void,
		errBack: () => void
	) => void;
};

type OutgoingMessageDataMap = {} & {
	[Key in SendTrackDoneOperationName]: {
		error?: string;
		id?: string;
		roomId: string;
	};
} &
	{
		[Key in ConnectTransportDoneOperationName]: {
			error?: string;
			roomId: string;
		};
	};

type OutgoingMessage<Key extends keyof OutgoingMessageDataMap> = {
	op: Key;
	d: OutgoingMessageDataMap[Key];
} & ({ uid: string } | { rid: string });

interface IncomingChannelMessageData<Key extends keyof HandlerMap> {
	op: Key;
	d: HandlerDataMap[Key];
	uid: string;
}

export let send = <Key extends keyof OutgoingMessageDataMap>(
	_obj: OutgoingMessage<Key>
) => {};

type SendTrackDoneOperationName = `@send-track-${VoiceSendDirection}-done`;
type ConnectTransportDoneOperationName = `@connect-transport-${VoiceSendDirection}-done`;

export const startRabbit = async (handler: HandlerMap) => {
	console.log(
		"trying to connect to: ",
		process.env.RABBITMQ_URL || "amqp://localhost"
	);
};
