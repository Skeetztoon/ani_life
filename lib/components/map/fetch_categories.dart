import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chipsCarousel.dart';
import 'place_model.dart';

// fetching specific category
final categoryDataProvider = FutureProvider.autoDispose.family<List<Place>, String>((ref, categoryName) async {
  // DocumentReference cityRef = FirebaseFirestore.instance.collection('cities').doc('moscow');
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(categoryName);
  QuerySnapshot snapshot = await collectionRef.get();
  return snapshot.docs.map((doc) => Place.fromMap(doc.data() as Map<String, dynamic>)).toList();
});

// providing list of places of active filterchips
final selectedCategoriesDataProvider = FutureProvider.autoDispose.family<List<Place>, Set<String>>((ref, selectedCategoriesSet) async {
  List<Place> _placesList = [];
  for (String categoryName in selectedCategoriesSet) {
    List<Place> categoryData = await ref.watch(categoryDataProvider(categoryName).future);
    _placesList.addAll(categoryData);
  }
  return _placesList;
});

class FetchCategories extends ConsumerWidget {
  const FetchCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListStateNotifierProvider);
    return Container(
      child: ref.watch(selectedCategoriesDataProvider(categoryList)).when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            Place place = data[index];
            return Text('${place.name} ${place.place} ${place.coords}');
          },
        ),
        loading: () => const CircularProgressIndicator(),
        error: (e, __) =>  Text(e.toString()),
      ),
    );
  }
}

