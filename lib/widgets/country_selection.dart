import 'package:flutter/material.dart';
import 'custom_card.dart';

class CountrySelection extends StatelessWidget {
  final Function(String) onCountrySelected;

  CountrySelection({required this.onCountrySelected});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          ListTile(
            leading: Text('🇲🇦', style: TextStyle(fontSize: 24)),
            title: Text('Maroc', style: TextStyle(color: Colors.white)),
            trailing: Text('+212', style: TextStyle(color: Colors.white70)),
            onTap: () => onCountrySelected('MA'),
          ),
          // Ajoutez d'autres pays selon vos besoins
        ],
      ),
    );
  }
} 
