

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
//
// Future<void> pickAndUploadImage() async {
//   XFile? pickedFile = await ImagePicker()
//       .pickImage(source: ImageSource.gallery)
//       .catchError((onError) {
//     Fluttertoast.showToast(msg: onError.toString());
//   });
//   File? image = pickedFile != null ? File(pickedFile.path) : null;
//   if (image != null) {
//     final storageProvider = StorageProviderFirebase();
//     storageProvider.initialize();
//
//     try {
//       // final photoUrl = await storageProvider.uploadImageFileAndStoreUrl(image: image, fileName: userId);
//     } on FirebaseException catch (e) {
//       Fluttertoast.showToast(msg: 'FirebaseException:\t${e.toString()}');
//     } on Exception catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }

