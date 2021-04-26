import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class FireStorageService {
  static Future<String> uploadAvatar(String path) async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("avatars").child(Uuid().v4());
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(path));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
