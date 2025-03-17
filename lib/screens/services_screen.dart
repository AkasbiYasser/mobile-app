// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\services_screen.dart

import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import 'prepaid_cards_screen.dart';
import 'gift_cards_screen.dart';
import 'retail_services_screen.dart';

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nos Services',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Color(0xFFB4F700),
                ),
              ),
              SizedBox(height: 20),
              _buildServiceCard(
                title: 'Cartes Prépayées',
                description: 'Achetez des cartes prépayées pour vos besoins quotidiens',
                icon: Icons.credit_card,
                onTap: () {
                  print('Navigation vers PrepaidCardsScreen');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrepaidCardsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              _buildServiceCard(
                title: 'Cartes Cadeaux & PIN',
                description: 'Offrez des cartes cadeaux et codes PIN à vos proches',
                icon: Icons.card_giftcard,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GiftCardsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              _buildServiceCard(
                title: 'Services de Détail',
                description: 'Accédez à une large gamme de services de détail',
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RetailServicesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF002B20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFFB4F700),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFB4F700),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
