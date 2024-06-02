import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/taxi.dart';

class TaxiService {
  final CollectionReference taxiCollection =
      FirebaseFirestore.instance.collection('taxis');

  // Add a new taxi
  Future<void> addTaxi(Taxi taxi) async {
    return await taxiCollection.doc(taxi.id).set({
      'ownerId': taxi.ownerId,
      'vehicleNumber': taxi.vehicleNumber,
      'type': taxi.type,
      'capacity': taxi.capacity,
    });
  }

  // Get all taxis
  Stream<List<Taxi>> getTaxis() {
    return taxiCollection.snapshots().map(_taxiListFromSnapshot);
  }

  // Taxi list from snapshot
  List<Taxi> _taxiListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Taxi(
        id: doc.id,
        ownerId: doc['ownerId'] ?? '',
        vehicleNumber: doc['vehicleNumber'] ?? '',
        type: doc['type'] ?? '',
        capacity: doc['capacity'] ?? 0,
      );
    }).toList();
  }
}
