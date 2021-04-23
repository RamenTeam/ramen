const fs = require('fs');
const path = require('path');

module.exports.me = fs.readFileSync(path.join(__dirname, 'me.gql'), 'utf8');
module.exports.getUser = fs.readFileSync(path.join(__dirname, 'getUser.gql'), 'utf8');
module.exports.getUsers = fs.readFileSync(path.join(__dirname, 'getUsers.gql'), 'utf8');
module.exports.updateProfile = fs.readFileSync(path.join(__dirname, 'updateProfile.gql'), 'utf8');
module.exports.getNotifications = fs.readFileSync(path.join(__dirname, 'getNotifications.gql'), 'utf8');
