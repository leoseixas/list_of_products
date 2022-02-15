// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageSourceWidget extends StatelessWidget {
//   final Function onImageSelected;
//   const ImageSourceWidget({
//     Key? key,
//     required this.onImageSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isAndroid) {
//       return BottomSheet(
//         onClosing: () {},
//         builder: (_) => Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextButton(
//               onPressed: getFromCamera,
//               child: const Text('Câmera'),
//             ),
//             TextButton(
//               onPressed: getFromGallery,
//               child: const Text('Galeria'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return CupertinoActionSheet(
//         title: const Text('Selecione foto para o produto'),
//         cancelButton: CupertinoActionSheetAction(
//             child: const Text(
//               'Cancelar',
//               style: TextStyle(color: Colors.red),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop;
//             }),
//         actions: [
//           CupertinoActionSheetAction(
//             onPressed: getFromCamera,
//             child: const Text('Câmera'),
//           ),
//           CupertinoActionSheetAction(
//             onPressed: getFromGallery,
//             child: const Text('Galeria'),
//           ),
//         ],
//       );
//     }
//   }

  // Future<void> getFromCamera() async {
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
  //   if (pickedFile == null) return;
  //   onImageSelected(image: (File(pickedFile.path)));
  //   // imageSelected(File(pickedFile.path));
  // }

  // Future<void> getFromGallery() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile == null) return;
  //   onImageSelected(image: (File(pickedFile.path)));
  //   // imageSelected(File(pickedFile.path));
  // }

