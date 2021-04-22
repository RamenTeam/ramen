const fs = require('fs');
const path = require('path');

module.exports.newNotificationAdded = fs.readFileSync(path.join(__dirname, 'newNotificationAdded.gql'), 'utf8');
