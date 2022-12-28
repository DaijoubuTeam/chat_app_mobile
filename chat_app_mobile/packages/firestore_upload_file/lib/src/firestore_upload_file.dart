import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

enum TypeFile {
  images,
}

class FireStoreUploadFileService {
  final TypeFile _type;

  FireStoreUploadFileService._internal() : _type = TypeFile.images;

  static FireStoreUploadFileService? _firestoreService;

  static FireStoreUploadFileService get firseStoreService {
    _firestoreService ??= FireStoreUploadFileService._internal();
    return _firestoreService!;
  }

  //upload image file
  Future<String?> uploadFile(XFile file) async {
    try {
      //get name for file by random time.
      String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
      // path for file in firestore
      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImage = ref.child(TypeFile.images.toString());
      Reference refToUpload = refDirImage.child(uniqueImageName);

      UploadTask? uploadTask = refToUpload.putFile(File(file.path));
      final snapshot = await uploadTask.whenComplete(() => {});
      final urlDownloadImage = await snapshot.ref.getDownloadURL();
      return urlDownloadImage;
    } catch (err) {
      log('Failed to pick image: $err');
      return null;
    }
  }

  //upload video file
  Future<String?> uploadVideoFile(File file) async {
    try {
      //get name for file by random time.
      String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
      // path for file in firestore
      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImage = ref.child("videos");
      Reference refToUpload = refDirImage.child(uniqueImageName);

      UploadTask? uploadTask = refToUpload.putFile(File(file.path));
      final snapshot = await uploadTask.whenComplete(() => {});
      final urlDownloadImage = await snapshot.ref.getDownloadURL();
      return urlDownloadImage;
    } catch (err) {
      log('Failed to pick image: $err');
      return null;
    }
  }
}
