const String sendConnectRequestMutation = r'''
mutation($data: ConnectUserDto!){
  sendConnectRequest(data: $data){
    path
    message
  }
}
''';
