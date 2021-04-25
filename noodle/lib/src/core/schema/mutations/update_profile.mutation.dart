const String getUpdateProfileMutation = r'''
mutation updateProfile($data: UpdateProfileDto!)
{ 
  updateProfile(data: $data){ 
    path 
    message 
    } 
}
''';
