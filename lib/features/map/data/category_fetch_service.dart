import 'package:ani_life/features/map/domain/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryFetchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Place>> fetchPlacesByCategory(String categoryName) async {
    CollectionReference collectionRef = _firestore.collection(categoryName);
    QuerySnapshot snapshot = await collectionRef.get();
    return snapshot.docs
        .map((doc) => Place.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Place>> fetchPlacesByCategories(Set<String> categories) async {
    List<Place> placesList = [];
    for (String category in categories) {
      placesList.addAll(await fetchPlacesByCategory(category));
    }
    return placesList;
  }
}
