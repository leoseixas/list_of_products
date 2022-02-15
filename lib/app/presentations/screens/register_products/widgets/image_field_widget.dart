// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:list_of_products/app/presentations/screens/register_products/widgets/image_source_widget.dart';

// class ImageFieldWidget extends StatelessWidget {
//   final Function onImageSelected;
//   const ImageFieldWidget({Key? key, required this.onImageSelected})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.black12,
//         borderRadius: BorderRadius.all(
//           Radius.circular(10),
//         ),
//       ),
//       height: 120,
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               if (Platform.isAndroid) {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (_) =>
//                       ImageSourceWidget(onImageSelected: onImageSelected),
//                 );
//               } else {
//                 showCupertinoModalPopup(
//                   context: context,
//                   builder: (_) =>
//                       ImageSourceWidget(onImageSelected: onImageSelected),
//                 );
//               }
//             },
//             child: const CircleAvatar(
//               radius: 44,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.camera_alt,
//                 size: 40,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
