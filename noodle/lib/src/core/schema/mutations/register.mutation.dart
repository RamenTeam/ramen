const String registerMutation = r'''
mutation Register($data: RegisterDto!){
  register(data:$data){
    path
    message
  }
}
''';