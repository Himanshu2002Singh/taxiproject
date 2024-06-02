import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/payment_service.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentService = Provider.of<PaymentService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Premium Features:'),
            Text('1. Detailed revenue report'),
            Text('2. Priority customer support'),
            Text('3. Advanced analytics'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Subscribe Monthly - ₹500'),
              onPressed: () {
                paymentService.openCheckout(500);
              },
            ),
            ElevatedButton(
              child: Text('Subscribe Yearly - ₹5000'),
              onPressed: () {
                paymentService.openCheckout(5000);
              },
            ),
          ],
        ),
      ),
    );
  }
}
