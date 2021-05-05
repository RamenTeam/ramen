const String updateProfileMutation = r'''
mutation($data: UpdateProfileDto!)
{ 
  updateProfile(data: $data){ 
    path 
    message 
    } 
}
''';
