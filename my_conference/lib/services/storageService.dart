import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:my_conference/utilities/vars.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService{
  static Future<File> compressImage(String photoId, File image) async{
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 65,
    );

    return compressedImageFile;
  }

  static Future<String> uploadPost(File imageFile) async{
    //generate uid
    String photoId = Uuid().v4();
    //compress image
    File image = await compressImage(photoId, imageFile);
    
    StorageUploadTask uploadTask = storageRef
      .child('images/posts/post_$photoId.jpg')
      .putFile(image);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadUserProfileImg(String url, File ImageFile) async{
    String photoId= Uuid().v4();
    File img = await compressImage(photoId, ImageFile);

    if(url.isNotEmpty){
      //update image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
      //print(photoId);
    }


    StorageUploadTask uploadTask = storageRef.child('images/users/userProfile_$photoId.jpg').putFile(img);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}