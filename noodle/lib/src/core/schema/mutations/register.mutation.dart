const String registerMutation = r'''
mutation($data: RegisterDto!){
  register(data:$data){
    path
    message
  }
}
''';