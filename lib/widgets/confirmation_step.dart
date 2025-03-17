import 'package:flutter/material.dart';

class ConfirmationStep extends StatelessWidget {
  final bool success;
  final VoidCallback onRestart;

  const ConfirmationStep({
    Key? key,
    required this.success,
    required this.onRestart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Color(0xFFB4F700) : Colors.red,
          size: 64,
        ),
        SizedBox(height: 24),
        Text(
          success ? 'Achat réussi !' : 'Échec de l\'achat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Text(
          success 
            ? 'Votre carte prépayée a été traitée et sera livrée sous peu.'
            : 'Une erreur s\'est produite. Veuillez réessayer.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: onRestart,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB4F700),
            foregroundColor: Color(0xFF002B20),
            minimumSize: Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            success ? 'Acheter une autre carte' : 'Réessayer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 
