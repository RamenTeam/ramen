const String getRegisterMutation = r'''
mutation Register($data: RegisterDto!){
  register(data:$data){
    path
    message
  }
}
''';