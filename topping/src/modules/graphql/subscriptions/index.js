const fs = require('fs');
const path = require('path');

module.exports.newNotificationAdded = fs.readFileSync(path.join(__dirname, 'newNotificationAdded.gql'), 'utf8');
module.exports.newMessageSended = fs.readFileSync(path.join(__dirname, 'newMessageSended.gql'), 'utf8');
