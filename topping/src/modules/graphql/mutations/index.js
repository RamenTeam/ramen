const fs = require('fs');
const path = require('path');

module.exports.login = fs.readFileSync(path.join(__dirname, 'login.gql'), 'utf8');
module.exports.logout = fs.readFileSync(path.join(__dirname, 'logout.gql'), 'utf8');
module.exports.register = fs.readFileSync(path.join(__dirname, 'register.gql'), 'utf8');
module.exports.sendForgotPasswordEmail = fs.readFileSync(path.join(__dirname, 'sendForgotPasswordEmail.gql'), 'utf8');
module.exports.forgotPasswordChange = fs.readFileSync(path.join(__dirname, 'forgotPasswordChange.gql'), 'utf8');
module.exports.sendConnectRequest = fs.readFileSync(path.join(__dirname, 'sendConnectRequest.gql'), 'utf8');
module.exports.updateProfile = fs.readFileSync(path.join(__dirname, 'updateProfile.gql'), 'utf8');
