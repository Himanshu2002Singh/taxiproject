import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/taxi.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingScreen extends StatelessWidget {
  final String userId;

  BookingScreen({required this.userId});

  final _formKey = GlobalKey<FormState>();
  String _taxiId = '';
  int _seats = 1;

  @override
  Widget build(BuildContext context) {
    final bookingService = Provider.of<BookingService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Taxi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Taxi ID'),
                validator: (val) => val!.isEmpty ? 'Enter a taxi ID' : null,
                onChanged: (val) {
                  _taxiId = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of Seats'),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val!.isEmpty ? 'Enter number of seats' : null,
                onChanged: (val) {
                  _seats = int.parse(val);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Book Taxi'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final booking = Booking(
                      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
                      userId: userId, // Use userId passed from constructor
                      taxiId: _taxiId,
                      bookingTime: DateTime.now(),
                      seats: _seats,
                    );
                    await bookingService.addBooking(booking);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
