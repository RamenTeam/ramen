const String rejectConnectionRequestMutation = r'''
mutation($data: RejectConnectionRequest!){
  rejectConnectionRequest(data:$data){
    path
    message
  }
}
''';