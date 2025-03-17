import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  final List<Map<String, dynamic>> contactOptions = [
    {
      'icon': Icons.phone,
      'title': 'Appelez-nous',
      'subtitle': 'Service disponible 24/7',
      'action': 'tel:+212520000000',
    },
    {
      'icon': Icons.email,
      'title': 'Envoyez-nous un email',
      'subtitle': 'support@example.com',
      'action': 'mailto:support@example.com',
    },
    {
      'icon': Icons.chat_bubble,
      'title': 'Chat en direct',
      'subtitle': 'Temps de réponse moyen : 2 min',
      'action': 'chat',
    },
    {
      'icon': Icons.whatsapp,
      'title': 'WhatsApp',
      'subtitle': 'Messagerie instantanée',
      'action': 'https://wa.me/212520000000',
    },
  ];

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _handleContactOption(BuildContext context, String action) {
    if (action == 'chat') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Le chat en direct sera bientôt disponible'),
          backgroundColor: Color(0xFF002B20),
        ),
      );
      return;
    }
    _launchUrl(action);
  }

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
        title: Text(
          'Contactez-nous',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Comment pouvons-nous vous aider ?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: contactOptions.length,
              itemBuilder: (context, index) {
                final option = contactOptions[index];
                return Card(
                  color: Color(0xFF001F17),
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xFFB4F700).withOpacity(0.3),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFB4F700).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        option['icon'] as IconData,
                        color: Color(0xFFB4F700),
                        size: 24,
                      ),
                    ),
                    title: Text(
                      option['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        option['subtitle'] as String,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFB4F700),
                      size: 16,
                    ),
                    onTap: () => _handleContactOption(
                      context,
                      option['action'] as String,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Notre équipe est disponible pour vous assister 24h/24 et 7j/7',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 