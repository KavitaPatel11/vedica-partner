// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:vrb/app/utils/error_helper.dart';

// class FileUpload {
//   Future<List<String>> uploadFiles(List _images) async {
//     try {
//       List<String> imagesUrls = [];

//       _images.forEach((_image) async {
//         final storageReference =
//             FirebaseStorage.instance.ref().child('posts/${_image.path}');
//         final uploadTask = storageReference.putFile(_image);

//         imagesUrls.add(await (await uploadTask.snapshot).ref.getDownloadURL());
//       });
//       print(imagesUrls);
//       return imagesUrls;
//     } catch (e) {
//       Errorhelper.showErrorDialog(
//           title: "Error: Uploading Images ",
//           discription: e.toString(),
//           onSubmit: () => Get.back());
//       return [];
//     }
//   }
// }
