// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../models/ayah.dart';
// import '../colors.dart';
//
// class AyahDetailPage extends StatelessWidget {
//   final Ayah ayah;
//
//   const AyahDetailPage({super.key, required this.ayah});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background,
//       appBar: AppBar(
//         backgroundColor: background,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           'Detail Ayat',
//           style: GoogleFonts.poppins(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Ayat ${ayah.numberInSurah}',
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: text,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: gray,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     ayah.arabicText,
//                     style: GoogleFonts.amiri(
//                       fontSize: 32,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     ayah.translation,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       color: text,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
