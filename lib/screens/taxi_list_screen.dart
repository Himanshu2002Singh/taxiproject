import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/taxi_provider.dart';
import '../models/taxi.dart';

class TaxiListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taxiProvider = Provider.of<TaxiProvider>(context);
    taxiProvider.fetchTaxis(); // Fetch taxis when screen is built

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Taxis'),
      ),
      body: Consumer<TaxiProvider>(
        builder: (context, provider, child) {
          if (provider.taxis.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.taxis.length,
            itemBuilder: (context, index) {
              final taxi = provider.taxis[index];
              return ListTile(
                title: Text(taxi.vehicleNumber),
                subtitle: Text('${taxi.type} - ${taxi.capacity} seats'),
              );
            },
          );
        },
      ),
    );
  }
}
