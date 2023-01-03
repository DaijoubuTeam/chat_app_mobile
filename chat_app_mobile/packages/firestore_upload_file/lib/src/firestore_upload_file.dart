import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

enum TypeFile {
  images,
}

class FireStoreUploadFileService {
  //final TypeFile _type;
  UploadTask? _uploadTask;

  FireStoreUploadFileService._internal();

  static FireStoreUploadFileService? _firestoreService;

  static FireStoreUploadFileService get firseStoreService {
    _firestoreService ??= FireStoreUploadFileService._internal();
    return _firestoreService!;
  }

  UploadTask? get uploadTask => _uploadTask;

  //upload image file
  Future<String?> uploadFile(XFile file) async {
    try {
      //get name for file by random time.
      String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
      // path for file in firestore
      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImage = ref.child(TypeFile.images.toString());
      Reference refToUpload = refDirImage.child(uniqueImageName);

      _uploadTask = refToUpload.putFile(File(file.path));
      final snapshot = await _uploadTask!.whenComplete(() => {});
      final urlDownloadImage = await snapshot.ref.getDownloadURL();
      disposeUploadTask();
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

      _uploadTask = refToUpload.putFile(File(file.path));
      final snapshot = await _uploadTask!.whenComplete(() => {});
      final urlDownloadImage = await snapshot.ref.getDownloadURL();
      disposeUploadTask();
      return urlDownloadImage;
    } catch (err) {
      log('Failed to pick image: $err');
      return null;
    }
  }

  void disposeUploadTask() {
    _uploadTask = null;
  }
}
