import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:clone_uber_app/src/models/travel_history.dart';

class TravelHistoryProvider {

  CollectionReference _ref;

  TravelHistoryProvider() {
    _ref = FirebaseFirestore.instance.collection('TravelHistory');
  }

  Future<String> create(TravelHistory travelHistory) async {
    String errorMessage;

    try {
      String id = _ref.doc().id;
      travelHistory.id = id;

      await _ref.doc(travelHistory.id).set(travelHistory.toJson()); // ALMACENAMOS LA INFORMACIÓN
      return id;
    } catch(error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<TravelHistory> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      TravelHistory client = TravelHistory.fromJson(document.data());
      return client;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }

  Future<void>  delete(String id) {
    return _ref.doc(id).delete();
  }

}