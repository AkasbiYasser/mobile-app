// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\history_screen.dart

import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual number of history items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CustomCard(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF002B20),
                  child: Icon(Icons.history, color: Color(0xFFB4F700)),
                ),
                title: Text(
                  'Transaction #${index + 1}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Service: Prepaid Card',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$50.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB4F700),
                      ),
                    ),
                    Text(
                      '2023-06-${15 - index}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
