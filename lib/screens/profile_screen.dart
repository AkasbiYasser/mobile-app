// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\profile_screen.dart

import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../screens/coordinates_screen.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';
import 'payment_methods_screen.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête avec photo de profil et numéro
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFB4F700).withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '+212611250429',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Bouton Mes coordonnées
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomCard(
                child: ListTile(
                  title: Text(
                    'Mes coordonnées',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.purple,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoordinatesScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bouton Obtenir de l'aide
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Obtenir de l\'aide',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            // Liste des options
           
            _buildOptionTile(
              context: context,
              icon: Icons.account_balance_wallet,
              iconColor: Color(0xFFB4F700),
              title: 'Modes de paiement',
            ),
            _buildOptionTile(
              context: context,
              icon: Icons.translate,
              iconColor: Color(0xFFB4F700),
              title: 'Langue',
            ),
            _buildOptionTile(
              context: context,
              icon: Icons.settings,
              iconColor: Color(0xFFB4F700),
              title: 'Paramètres du compte',
            ),
            _buildOptionTile(
              context: context,
              icon: Icons.settings,
              iconColor: Color(0xFFB4F700),
              title: 'A Propos de PrepayConnect',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: CustomCard(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {
            if (title == 'A Propos de PrepayConnect') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutScreen(),
                ),
              );
            } else if (title == 'Langue') {
              _showLanguageSelector(context);
            } else if (title == 'Paramètres du compte') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountSettingsScreen(),
                ),
              );
            } else if (title == 'Modes de paiement') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentMethodsScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF002B20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisir la langue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildLanguageOption(context, 'Français', '🇫🇷', true),
            Divider(color: Colors.white.withOpacity(0.1)),
            _buildLanguageOption(context, 'English', '🇬🇧', false),
            Divider(color: Colors.white.withOpacity(0.1)),
            _buildLanguageOption(context, 'العربية', '🇲🇦', false),
            Divider(color: Colors.white.withOpacity(0.1)),
            _buildLanguageOption(context, 'Español', '🇪🇸', false),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String language, String flag, bool selected) {
    return ListTile(
      leading: Text(
        flag,
        style: TextStyle(fontSize: 24),
      ),
      title: Text(
        language,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: selected 
        ? Icon(Icons.check_circle, color: Color(0xFFB4F700))
        : null,
      onTap: () {
        // Ici vous pouvez ajouter la logique pour changer la langue
        Navigator.pop(context);
      },
    );
  }
}