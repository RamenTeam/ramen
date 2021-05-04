const String loginMutation = r'''
mutation Login($data: LoginDto!){
  login(data:$data){
    path
    message
  }
}
''';