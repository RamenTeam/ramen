- NAT (Network access translation)
- STUN (Session Traversal Utilities for NAT)
- TURN (Traversal Using Relays around NAT)

**Message**

CLIENT_ID_EVENT = client-id-event
OFFER_EVENT = offer-event
ANSWER_EVENT = answer-event
ICE_CANDIDATE_EVENT = ice-candidate-event

clientList: object
roomList: array

conversation {
host
peer
}

client connected -> add to clientList

onOfferEvent -> add new conversation -> emit OFFER_EVENT
onAnswerEvent > find host -> emit ANSWER_EVENT
