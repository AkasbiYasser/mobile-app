import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../widgets/operator_selection.dart';
import '../widgets/number_input.dart';
import '../widgets/amount_selection.dart';
import '../widgets/payment_processing.dart';
import '../widgets/country_selection.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/amount_plans_selector.dart';
import '../widgets/payment_screen.dart';

class RechargeScreen extends StatefulWidget {
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedCountry;
  String phoneNumber = '';
  double? selectedAmount;
  int currentStep = 0; // 0: numéro, 1: montant, 2: paiement

  final List<Map<String, dynamic>> countries = [
    {
      'name': 'Afghanistan',
      'code': 'AF',
      'flag': '🇦🇫',
      'prefix': '+93',
    },
    {
      'name': 'Afrique du Sud',
      'code': 'ZA',
      'flag': '🇿🇦',
      'prefix': '+27',
    },
    {
      'name': 'Albanie',
      'code': 'AL',
      'flag': '🇦🇱',
      'prefix': '+355',
    },
    {
      'name': 'Algérie',
      'code': 'DZ',
      'flag': '🇩🇿',
      'prefix': '+213',
    },
    {
      'name': 'Allemagne',
      'code': 'DE',
      'flag': '🇩🇪',
      'prefix': '+49',
    },
    // Ajoutez d'autres pays ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            currentStep == 0 ? Icons.close : Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: _handleBackPress,
        ),
        actions: [
          if (currentStep == 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB4F700),
                  foregroundColor: Color(0xFF002B20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Contacts'),
              ),
            ),
        ],
      ),
      body: _buildCurrentStep(),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Veuillez saisir le numéro de téléphone que vous souhaitez recharger',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF001F17),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFB4F700).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: _showCountryPicker,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0xFFB4F700).withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedCountry != null 
                                  ? countries.firstWhere((c) => c['code'] == selectedCountry)['flag']!
                                  : '🇲🇦',
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFFB4F700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        phoneNumber.isEmpty ? 'Entrez un numéro' : phoneNumber,
                        style: TextStyle(
                          color: phoneNumber.isEmpty ? Colors.white38 : Colors.white,
                          fontSize: 20,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (phoneNumber.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentStep = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB4F700),
                    foregroundColor: Color(0xFF002B20),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Confirmer le numéro de téléphone',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Spacer(),
            CustomKeypad(
              onKeyPressed: (key) {
                setState(() {
                  if (phoneNumber.length < 10) {
                    phoneNumber += key;
                  }
                });
              },
              onBackspace: () {
                setState(() {
                  if (phoneNumber.isNotEmpty) {
                    phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
                  }
                });
              },
            ),
          ],
        );
      case 1:
        return AmountPlansSelector(
          phoneNumber: phoneNumber,
          onAmountSelected: (amount) {
            setState(() {
              selectedAmount = amount;
              currentStep = 2;
            });
          },
        );
      case 2:
        return PaymentScreen(
          phoneNumber: phoneNumber,
          amount: selectedAmount ?? 0,
          operatorLogo: 'assets/images/maroc.png',
          onPaymentComplete: () {
            // Gérer la fin du paiement
            Navigator.pop(context);
          },
        );
      default:
        return Container();
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF002B20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Rechercher un pays',
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFB4F700)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFB4F700)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFB4F700).withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFB4F700)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Text(
                      country['flag']!,
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      country['name']!,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      country['prefix']!,
                      style: TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      setState(() {
                        selectedCountry = country['code'];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackPress() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }
}