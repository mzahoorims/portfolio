// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Experience extends StatelessWidget {
//   const Experience({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.sizeOf(context).height,
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//           gradient:LinearGradient(stops: [0.03,0.54], begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [Color(0x87001CFF),Color(0xFF13155F)]) ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Experience",
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image.asset(
//                     "assets/award.jpg",
//                     width: 250,
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(onPressed: null,
//                     child: Container(
//                       width: 120,height: 50,
//                       child: Center(child: Text("Projects",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
//                       decoration:  BoxDecoration(
//                           borderRadius: BorderRadius.circular(90),
//                           gradient: const LinearGradient(
//                               stops: [0.33,0.58], begin: Alignment.bottomLeft, end: Alignment.topRight,
//                               colors: [Color(0x0ff3cce0),Color(0xFF3C9CE0)])
//                       ),
//                     ))
//               ],
//             ),
//             Text("Flutter entern")
//           ],
//         ),
//       ),
//     );
//   }
// }
