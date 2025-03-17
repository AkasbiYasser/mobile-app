import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String phoneNumber;
  final double amount;
  final String operatorLogo;
  final VoidCallback onPaymentComplete;

  PaymentScreen({
    required this.phoneNumber,
    required this.amount,
    required this.operatorLogo,
    required this.onPaymentComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Votre commande',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/payment_illustration.png',
                  height: 120,
                ),
              ],
            ),
          ),

          // Numéro et opérateur
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  phoneNumber,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Image.asset(operatorLogo, height: 24),
                Spacer(),
                Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
          ),

          // Montant
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Reçoit',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  '${amount.toInt()} MAD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Code promo
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.add_circle, color: Colors.purple),
                SizedBox(width: 10),
                Text(
                  'Ajouter le code promotionnel',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          // Total et bouton
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Votre total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${amount.toStringAsFixed(2)} USD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_up, color: Colors.white),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => _showPaymentMethods(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFB4F700),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Payez en toute sécurité',
                    style: TextStyle(
                      color: Color(0xFF002B20),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF002B20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Paiement',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Choisissez de payer avec',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            _buildPaymentOption('Apple Pay', 'assets/images/apple_pay.png', false),
            Divider(color: Colors.white.withOpacity(0.1)),
            _buildPaymentOption('Carte', '', false, showCards: true),
            Divider(color: Colors.white.withOpacity(0.1)),
            _buildPaymentOption('PayPal', 'assets/images/paypal.png', true),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(operatorLogo, height: 30),
                  SizedBox(width: 10),
                  Text(
                    phoneNumber,
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    '${amount.toStringAsFixed(2)} USD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPaymentComplete();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Payer avec PayPal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String logo, bool selected, {bool showCards = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.purple : Colors.white,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Spacer(),
          if (showCards)
            Row(
              children: [
                Image.asset('assets/images/visa.png', height: 20),
                SizedBox(width: 8),
                Image.asset('assets/images/mastercard.png', height: 20),
                SizedBox(width: 8),
                Image.asset('assets/images/amex.png', height: 20),
                SizedBox(width: 8),
                Image.asset('assets/images/discover.png', height: 20),
              ],
            )
          else if (logo.isNotEmpty)
            Image.asset(logo, height: 30),
        ],
      ),
    );
  }
} 