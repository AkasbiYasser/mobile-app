import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../screens/home_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String phoneNumber;
  final double amount;
  final String operatorLogo;
  final Function onPaymentComplete;

  PaymentScreen({
    required this.phoneNumber,
    required this.amount,
    required this.operatorLogo,
    required this.onPaymentComplete,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isProcessing = false;
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    if (isConfirmed) {
      return Scaffold(
        backgroundColor: Color(0xFF002B20),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFB4F700),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 60,
                    color: Color(0xFF002B20),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Paiement Confirmé !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Votre commande a été traitée avec succès.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Retourner directement à la page d'accueil
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB4F700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Retour à l\'accueil',
                      style: TextStyle(
                        color: Color(0xFF002B20),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
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
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.operatorLogo,
                            height: 30,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.phone_android,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.phoneNumber,
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            '${widget.amount.toStringAsFixed(2)} USD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                            isConfirmed = true;
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
        ),
      ),
    );
  }
} 