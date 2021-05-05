const String acceptConnectionRequestMutation = r'''
mutation($data: AcceptConnectionRequestDto!){
  acceptConnectionRequest(data:$data){
    path
    message
  }
}
''';
