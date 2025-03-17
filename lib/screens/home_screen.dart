// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\home_screen.dart

import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/back.jpg',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/logo.jpg',
                            height: 70,
                            width: 70,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'PrepayConnect',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB4F700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Bienvenue sur PrepayConnect',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Effectuez votre première recharge en quelques secondes',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)),
                              );
                            },
                            child: Text('Commencer la recharge'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFB4F700),
                              foregroundColor: Color(0xFF002B20),
                              minimumSize: Size(double.infinity, 45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Votre plateforme de confiance pour les services prépayés',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('1M+', 'utilisateurs'),
                              _buildStatItem('50+', 'services'),
                              _buildStatItem('24/7', 'support'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB4F700),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
