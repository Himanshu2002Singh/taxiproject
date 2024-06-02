import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class BookingService {
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('bookings');

  // Add a new booking
  Future<void> addBooking(Booking booking) async {
    return await bookingCollection.doc(booking.id).set({
      'userId': booking.userId,
      'taxiId': booking.taxiId,
      'bookingTime': booking.bookingTime.toIso8601String(),
      'seats': booking.seats,
    });
  }

  // Get bookings by user ID
  Stream<List<Booking>> getBookingsByUserId(String userId) {
    return bookingCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(_bookingListFromSnapshot);
  }

  // Booking list from snapshot
  List<Booking> _bookingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Booking(
        id: doc.id,
        userId: doc['userId'] ?? '',
        taxiId: doc['taxiId'] ?? '',
        bookingTime: DateTime.parse(doc['bookingTime']),
        seats: doc['seats'] ?? 0,
      );
    }).toList();
  }
}
