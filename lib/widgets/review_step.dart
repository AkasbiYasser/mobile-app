import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';

class ReviewStep extends StatelessWidget {
  final PrepaidCard selectedCard;
  final Country selectedCountry;
  final double selectedAmount;
  final String deliveryMethod;
  final String deliveryDetails;
  final bool termsAccepted;
  final Function(bool) onTermsAccepted;

  const ReviewStep({
    Key? key,
    required this.selectedCard,
    required this.selectedCountry,
    required this.selectedAmount,
    required this.deliveryMethod,
    required this.deliveryDetails,
    required this.termsAccepted,
    required this.onTermsAccepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vérifiez votre commande',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF001F17),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildReviewItem(
                'Carte',
                selectedCard.name,
                selectedCard.type,
              ),
              Divider(color: Colors.white24, height: 32),
              _buildReviewItem(
                'Pays',
                selectedCountry.name,
                selectedCountry.flag,
              ),
              Divider(color: Colors.white24, height: 32),
              _buildReviewItem(
                'Montant',
                '${selectedAmount.toStringAsFixed(2)} ${selectedCountry.currency}',
                null,
              ),
              Divider(color: Colors.white24, height: 32),
              _buildReviewItem(
                'Livraison',
                deliveryMethod,
                deliveryDetails,
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: termsAccepted,
                onChanged: (value) => onTermsAccepted(value ?? false),
                activeColor: Color(0xFFB4F700),
                checkColor: Color(0xFF002B20),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'J\'accepte les conditions générales d\'utilisation et la politique de confidentialité',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value, String? subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
} 
