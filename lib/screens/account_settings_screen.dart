import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _smsEnabled = true;

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paramètres du compte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              
              // Section notifications
              Text(
                'Informez-moi des remises et promotions Ding\npertinentes et exclusives, spécialement pour\nmoi.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              
              // Toggle SMS et WhatsApp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SMS et WhatsApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: _smsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _smsEnabled = value;
                      });
                    },
                    activeColor: Color(0xFFB4F700),
                    activeTrackColor: Color(0xFFB4F700).withOpacity(0.3),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              
              SizedBox(height: 40),
              Divider(color: Colors.white.withOpacity(0.1)),
              SizedBox(height: 40),
              
              // Section suppression du compte
              Text(
                'Supprimer le compte',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Votre choix de supprimer le compte entraînera une demande de fermeture de votre compte Ding et de suppression de toutes les données personnelles qui y sont associées. Le traitement de votre demande peut prendre jusqu\'à un mois.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
