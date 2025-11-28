// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'Models/News_Models/article.dart'; // تأكد من مسار الموديل

// class ArticleDetailsPage extends StatelessWidget {
//   const ArticleDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // استقبال الـ Article المبعوث من الكنترولر
//     final Article article = Get.arguments as Article;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           // 1. صورة الخبر
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             backgroundColor: Colors.white,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.asset(
//                 article.imageUrl ??
//                     'assets/images/general.jpg', // صورة احتياطية
//                 fit: BoxFit.cover,
//                 errorBuilder: (c, e, s) => Container(color: Colors.grey[200]),
//               ),
//             ),
//             leading: IconButton(
//               icon: const CircleAvatar(
//                 backgroundColor: Colors.black54,
//                 child: Icon(Icons.arrow_back, color: Colors.white),
//               ),
//               onPressed: () => Get.back(),
//             ),
//           ),

//           // 2. المحتوى
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // المصدر والتاريخ
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 5,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blueAccent.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           article.sourceName,
//                           style: const TextStyle(
//                             color: Colors.blueAccent,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         "${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),

//                   // العنوان
//                   Text(
//                     article.title,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       height: 1.3,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Divider(),
//                   const SizedBox(height: 20),

//                   // عنوان "AI Summary"
//                   Row(
//                     children: const [
//                       Icon(Icons.auto_awesome, color: Colors.purple),
//                       SizedBox(width: 8),
//                       Text(
//                         "AI Summary",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.purple,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),

//                   // نص الملخص
//                   Text(
//                     article.description ?? "No summary available.",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       height: 1.6,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
