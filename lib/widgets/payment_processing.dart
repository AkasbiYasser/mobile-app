import 'package:flutter/material.dart';
import 'custom_card.dart';

class PaymentProcessing extends StatelessWidget {
  final String? operator;
  final String? phoneNumber;
  final double? amount;

  PaymentProcessing({
    this.operator,
    this.phoneNumber,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          child: ListTile(
            title: Text('Opérateur', style: TextStyle(color: Colors.white)),
            subtitle: Text(operator ?? '', style: TextStyle(color: Color(0xFFB4F700))),
          ),
        ),
        SizedBox(height: 8),
        CustomCard(
          child: ListTile(
            title: Text('Numéro', style: TextStyle(color: Colors.white)),
            subtitle: Text(phoneNumber ?? '', style: TextStyle(color: Color(0xFFB4F700))),
          ),
        ),
        SizedBox(height: 8),
        CustomCard(
          child: ListTile(
            title: Text('Montant', style: TextStyle(color: Colors.white)),
            subtitle: Text('${amount?.toStringAsFixed(2) ?? ''} MAD', style: TextStyle(color: Color(0xFFB4F700))),
          ),
        ),
      ],
    );
  }
} 
