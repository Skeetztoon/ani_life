import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chipsCarousel.dart';

// Future<List<Map<String, dynamic>>> fetchCategoryData(String categoryName) async {
//   DocumentReference cityRef = FirebaseFirestore.instance.collection('cities').doc('moscow');
//   CollectionReference collectionRef = cityRef.collection(categoryName);
//   QuerySnapshot snapshot = await collectionRef.get();
//   return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
// }
//
// Future<List<Map<String, dynamic>>> fetchSelectedCategoriesData(Set<String> selectedCategoriesSet) async {
//   List<Map<String, dynamic>> allData = [];
//   for (String categoryName in selectedCategoriesSet) {
//     List<Map<String, dynamic>> categoryData = await fetchCategoryData(categoryName);
//     allData.addAll(categoryData);
//   }
//   return allData;
// }
//
// class FetchCategories extends ConsumerWidget {
//   const FetchCategories({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final categoryList = ref.watch(categoryListStateNotifierProvider);
//     return Container(
//       child: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchSelectedCategoriesData(categoryList),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 // Replace this with your own logic to display each item
//                 return Text(snapshot.data![index].toString());
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//
//           // By default, show a loading spinner.
//           return const CircularProgressIndicator();
//         },
//       )
//       ,
//     );
//   }
// }

final categoryDataProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, categoryName) async {
  DocumentReference cityRef = FirebaseFirestore.instance.collection('cities').doc('moscow');
  CollectionReference collectionRef = cityRef.collection(categoryName);
  QuerySnapshot snapshot = await collectionRef.get();
  return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
});


final selectedCategoriesDataProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, Set<String>>((ref, selectedCategoriesSet) async {
  List<Map<String, dynamic>> allData = [];
  for (String categoryName in selectedCategoriesSet) {
    List<Map<String, dynamic>> categoryData = await ref.watch(categoryDataProvider(categoryName).future);
    allData.addAll(categoryData);
  }
  return allData;
});

class FetchCategories extends ConsumerWidget {
  const FetchCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListStateNotifierProvider);
    return Container(
      child: ref.watch(selectedCategoriesDataProvider(categoryList)).when(
        data: (allData) => ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) {
            // Replace this with your own logic to display each item
            return Text(allData[index].toString());
          },
        ),
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Text('An error occurred'),
      ),
    );
  }
}

