class Booking {
  final String id;
  final String userId;
  final String taxiId;
  final DateTime bookingTime;
  final int seats;

  Booking({
    required this.id,
    required this.userId,
    required this.taxiId,
    required this.bookingTime,
    required this.seats,
  });
}
