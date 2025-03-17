import 'package:flutter/material.dart';
import 'custom_card.dart';

class AmountSelection extends StatelessWidget {
  final Function(double) onAmountSelected;

  AmountSelection({required this.onAmountSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAmountButton(10),
            _buildAmountButton(20),
            _buildAmountButton(50),
          ],
        ),
        SizedBox(height: 16),
        CustomCard(
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Montant personnalisé',
              labelStyle: TextStyle(color: Color(0xFFB4F700)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFB4F700)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFB4F700), width: 2),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => onAmountSelected(double.tryParse(value) ?? 0),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountButton(double amount) {
    return ElevatedButton(
      child: Text('$amount MAD'),
      onPressed: () => onAmountSelected(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFB4F700),
        foregroundColor: Color(0xFF002B20),
      ),
    );
  }
} 
