import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clone_uber_app/src/models/prices.dart';

class PricesProvider {

  CollectionReference _ref;

  PricesProvider() {
    _ref = FirebaseFirestore.instance.collection('Prices');
  }

  Future<Prices> getAll() async {
    DocumentSnapshot document = await _ref.doc('info').get();
    Prices prices = Prices.fromJson(document.data());
    return prices;
  }

}