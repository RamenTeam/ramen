const String getRegisterMutation = r'''
mutation Register($data: LoginDto!){
  register(data:$data){
    path
    message
  }
}
''';