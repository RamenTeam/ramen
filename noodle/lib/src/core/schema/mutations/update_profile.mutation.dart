const String updateProfileMutation = r'''
mutation updateProfile($data: UpdateProfileDto!)
{ 
  updateProfile(data: $data){ 
    path 
    message 
    } 
}
''';
