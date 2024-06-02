import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Uttrakhand Taxi App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await authProvider.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Book a Taxi'),
              onPressed: () {
                Navigator.pushNamed(context, '/booking');
              },
            ),
            ElevatedButton(
              child: Text('View Taxis'),
              onPressed: () {
                Navigator.pushNamed(context, '/taxi-list');
              },
            ),
            ElevatedButton(
              child: Text('My Dashboard'),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ElevatedButton(
              child: Text('Subscription'),
              onPressed: () {
                Navigator.pushNamed(context, '/subscription');
              },
            ),
          ],
        ),
      ),
    );
  }
}
