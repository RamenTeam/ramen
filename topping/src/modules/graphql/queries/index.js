const fs = require('fs');
const path = require('path');

module.exports.me = fs.readFileSync(path.join(__dirname, 'me.gql'), 'utf8');
module.exports.getUser = fs.readFileSync(path.join(__dirname, 'getUser.gql'), 'utf8');
module.exports.getUsers = fs.readFileSync(path.join(__dirname, 'getUsers.gql'), 'utf8');
module.exports.getConnectionRequest = fs.readFileSync(path.join(__dirname, 'getConnectionRequest.gql'), 'utf8');
module.exports.getNotifications = fs.readFileSync(path.join(__dirname, 'getNotifications.gql'), 'utf8');
module.exports.getMyNotifications = fs.readFileSync(path.join(__dirname, 'getMyNotifications.gql'), 'utf8');
module.exports.getConversation = fs.readFileSync(path.join(__dirname, 'getConversation.gql'), 'utf8');
module.exports.getConversations = fs.readFileSync(path.join(__dirname, 'getConversations.gql'), 'utf8');
