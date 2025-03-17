// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\prepaid_cards_screen.dart

import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';
import '../widgets/step_progress.dart';
import '../widgets/card_selection_step.dart';
import '../widgets/country_selection_step.dart';
import '../widgets/amount_selection_step.dart';
import '../widgets/delivery_selection_step.dart';
import '../widgets/review_step.dart';
import '../widgets/payment_step.dart';
import '../widgets/confirmation_step.dart';
import '../widgets/custom_card.dart';

class PrepaidCardsScreen extends StatefulWidget {
  @override
  _PrepaidCardsScreenState createState() => _PrepaidCardsScreenState();
}

class _PrepaidCardsScreenState extends State<PrepaidCardsScreen> {
  int currentStep = 0;
  PrepaidCard? selectedCard;
  Country? selectedCountry;
  double? selectedAmount;
  String? deliveryMethod;
  String? deliveryDetails;
  bool termsAccepted = false;
  bool isProcessing = false;
  bool success = false;

  final List<StepData> steps = [
    StepData(id: 'card', title: 'Carte', description: 'Choisir une carte'),
    StepData(id: 'amount', title: 'Montant', description: 'Choisir le montant'),
    StepData(id: 'details', title: 'Détails', description: 'Informations'),
    StepData(id: 'payment', title: 'Paiement', description: 'PayPal'),
    StepData(id: 'confirmation', title: 'Confirmation', description: 'Confirmation'),
  ];

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return CardSelectionStep(
          selectedCard: selectedCard,
          onCardSelected: (card) => setState(() => selectedCard = card),
        );
      case 1:
        if (selectedCard == null) return Container();
        return AmountSelectionStep(
          selectedCard: selectedCard!,
          selectedAmount: selectedAmount,
          onAmountSelected: (amount) => setState(() => selectedAmount = amount),
        );
      case 2:
        return DeliverySelectionStep(
          selectedMethod: deliveryMethod,
          deliveryDetails: deliveryDetails,
          onMethodSelected: (method) => setState(() => deliveryMethod = method),
          onDetailsChanged: (details) => setState(() => deliveryDetails = details),
        );
      case 3:
        return _buildPaymentStep();
      case 4:
        return _buildConfirmationStep();
      default:
        return Container();
    }
  }

  Widget _buildPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paiement via PayPal',
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
                Icon(
                  Icons.paypal,
                  size: 60,
                  color: Color(0xFF00457C),
                ),
                SizedBox(height: 16),
                Text(
                  'PayPal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Paiement sécurisé via PayPal',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isProcessing = true;
                    });
                    // Simuler le processus de paiement
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        isProcessing = false;
                        currentStep++;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0079C1),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isProcessing
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Payer avec PayPal',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationStep() {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          size: 100,
          color: Color(0xFFB4F700),
        ),
        SizedBox(height: 24),
        Text(
          'Paiement Confirmé !',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Votre carte prépayée a été traitée avec succès.',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB4F700),
            foregroundColor: Color(0xFF002B20),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text('Retour à l\'accueil'),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedCard != null;
      case 1:
        return selectedAmount != null;
      case 2:
        return deliveryMethod != null && deliveryDetails != null;
      case 3:
        return termsAccepted;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building PrepaidCardsScreen');
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Cartes Prépayées'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentStep > 0) {
              setState(() => currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StepProgress(
                steps: steps,
                currentStep: currentStep,
              ),
              SizedBox(height: 30),
              _buildCurrentStep(),
              if (currentStep < steps.length - 1 && currentStep != 3) ...[
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentStep > 0)
                      TextButton(
                        onPressed: () => setState(() => currentStep--),
                        child: Text(
                          'Retour',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _canProceed() 
                            ? () => setState(() => currentStep++) 
                            : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB4F700),
                            foregroundColor: Color(0xFF002B20),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text('Suivant'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
