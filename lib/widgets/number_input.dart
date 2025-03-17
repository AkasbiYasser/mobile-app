import 'package:flutter/material.dart';
import 'custom_card.dart';

class NumberInput extends StatelessWidget {
  final Function(String) onNumberEntered;

  NumberInput({required this.onNumberEntered});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entrez le numéro de téléphone',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        CustomCard(
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  labelStyle: TextStyle(color: Color(0xFFB4F700)),
                  prefixIcon: Icon(Icons.phone, color: Color(0xFFB4F700)),
                  prefixText: '+212 ',
                  prefixStyle: TextStyle(
                    color: Color(0xFFB4F700),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB4F700).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB4F700),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onChanged: onNumberEntered,
              ),
              SizedBox(height: 12),
              Text(
                'Format: 6XX XX XX XX',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
