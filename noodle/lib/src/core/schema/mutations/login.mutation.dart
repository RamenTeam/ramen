const String getLoginMutation = r'''
mutation Login($data: LoginDto!){
  login(data:$data){
    path
    message
  }
}
''';