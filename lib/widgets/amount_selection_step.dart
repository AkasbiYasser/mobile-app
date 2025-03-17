import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';
import '../widgets/custom_card.dart';

class AmountSelectionStep extends StatelessWidget {
  final PrepaidCard selectedCard;
  final double? selectedAmount;
  final Function(double) onAmountSelected;

  const AmountSelectionStep({
    required this.selectedCard,
    required this.selectedAmount,
    required this.onAmountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez le montant',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        CustomCard(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Liste des montants disponibles
                ...selectedCard.availableAmounts.map((amount) => 
                  RadioListTile<double>(
                    title: Text(
                      '${amount.toStringAsFixed(2)} ${selectedCard.currency}',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: amount,
                    groupValue: selectedAmount,
                    onChanged: (value) => onAmountSelected(value!),
                    activeColor: Color(0xFFB4F700),
                  ),
                ).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 
