import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image en haut
            Container(
              width: double.infinity,
              height: 400,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                image: DecorationImage(
                  image: AssetImage('assets/images/back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Titre
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'À propos de PrepayConnect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Description principale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'PrepayConnect est votre solution tout-en-un pour les services de recharge et de paiement prépayé. Notre plateforme innovante vous offre :',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            // Liste des services
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint('Recharges téléphoniques rapides et sécurisées'),
                  _buildBulletPoint('Achat de cartes-cadeaux pour vos marques préférées'),
                  _buildBulletPoint('Services de paiement pour les factures et les achats en ligne'),
                  _buildBulletPoint('Cartes prépayées pour une gestion facile de votre argent'),
                  _buildBulletPoint('Support client 24/7 pour répondre à toutes vos questions'),
                ],
              ),
            ),

            // Mission
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Chez PrepayConnect, notre mission est de simplifier vos transactions quotidiennes et de vous offrir une experience utilisateur exceptionnelle. Que vous ayez besoin de recharger votre telephone, d'acheter un cadeau, ou de gerer vos depenses, PrepayConnect est la pour vous.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            // Call to action
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Telechargez notre application et decouvrez un monde de commodite au bout de vos doigts !",
                style: TextStyle(
                  color: Color(0xFFB4F700),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),

            // Slogan
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "PrepayConnect : Simplifiez vos paiements, enrichissez votre vie.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Color(0xFFB4F700),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
