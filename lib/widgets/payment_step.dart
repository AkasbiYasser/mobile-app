import 'package:flutter/material.dart';
import '../models/payment_method.dart';
import '../models/prepaid_card_models.dart';

class PaymentStep extends StatefulWidget {
  final PrepaidCard selectedCard;
  final Country selectedCountry;
  final double amount;
  final Function onPaymentComplete;

  const PaymentStep({
    Key? key,
    required this.selectedCard,
    required this.selectedCountry,
    required this.amount,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  _PaymentStepState createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  String? selectedMethodId;
  bool isProcessing = false;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'visa',
      name: 'Visa',
      icon: Icons.credit_card,
    ),
    PaymentMethod(
      id: 'mastercard',
      name: 'Mastercard',
      icon: Icons.credit_card_outlined,
    ),
    PaymentMethod(
      id: 'amex',
      name: 'American Express',
      icon: Icons.credit_score,
    ),
    PaymentMethod(
      id: 'paypal',
      name: 'PayPal',
      icon: Icons.account_balance_wallet,
    ),
  ];

  void _processPayment() async {
    setState(() => isProcessing = true);
    // Simuler un délai de traitement
    await Future.delayed(Duration(seconds: 2));
    widget.onPaymentComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez votre méthode de paiement',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            final method = paymentMethods[index];
            final isSelected = selectedMethodId == method.id;

            return InkWell(
              onTap: isProcessing ? null : () {
                setState(() => selectedMethodId = method.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF001F17),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      method.icon,
                      size: 48,
                      color: Color(0xFFB4F700),
                    ),
                    SizedBox(height: 12),
                    Text(
                      method.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 32),
        if (selectedMethodId != null) ...[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF001F17),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Résumé du paiement',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Montant',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '${widget.amount} USD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isProcessing ? null : _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB4F700),
                      foregroundColor: Color(0xFF002B20),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: isProcessing
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002B20)),
                          ),
                        )
                      : Text(
                          'Payer maintenant',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
} 
