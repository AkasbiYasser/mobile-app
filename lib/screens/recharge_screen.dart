import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../widgets/operator_selection.dart';
import '../widgets/number_input.dart';
import '../widgets/amount_selection.dart';
import '../widgets/payment_processing.dart';
import '../widgets/country_selection.dart';
import '../widgets/custom_keypad.dart';
import '../widgets/amount_plans_selector.dart';

class RechargeScreen extends StatefulWidget {
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedCountry;
  String phoneNumber = '';
  double? selectedAmount;
  int currentStep = 0; // 0: numéro, 1: montant, 2: paiement, 3: confirmation
  bool isProcessing = false;

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
        return _buildPaymentStep();
      case 3:
        return _buildConfirmationStep();
      default:
        return Container();
    }
  }

  Widget _buildPaymentStep() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Votre commande',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF001F17),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFFB4F700).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Recharge de ${selectedAmount?.toStringAsFixed(2)} MAD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Color(0xFF001F17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          'Code promotionnel',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Entrez votre code',
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Annuler',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Code promotionnel appliqué'),
                                  backgroundColor: Colors.purple,
                                ),
                              );
                            },
                            child: Text(
                              'Valider',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Ajouter le code promotionnel',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(selectedAmount! * 0.1).toStringAsFixed(2)} USD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: Color(0xFF002B20),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        title: Text(
                          'Paiement via PayPal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFF001F17),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Color(0xFFB4F700).withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.paypal,
                                    size: 60,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'PayPal',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Paiement sécurisé via PayPal',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF002B20),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/maroc_telecom.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          phoneNumber,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${(selectedAmount! * 0.1).toStringAsFixed(2)} USD',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          isProcessing = true;
                                          currentStep = 3;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF0079C1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'Payer avec PayPal',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB4F700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Payez en toute sécurité',
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
    );
  }

  Widget _buildConfirmationStep() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isProcessing)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB4F700)),
            )
          else
            Icon(
              Icons.check_circle,
              color: Color(0xFFB4F700),
              size: 80,
            ),
          SizedBox(height: 20),
          Text(
            isProcessing ? 'Traitement en cours...' : 'Paiement effectué avec succès !',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            TextButton.icon(
              onPressed: () => setState(() => currentStep--),
              icon: Icon(Icons.arrow_back, color: Colors.white),
              label: Text('Retour', style: TextStyle(color: Colors.white)),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _canProceed() ? () => setState(() => currentStep++) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB4F700),
                  foregroundColor: Color(0xFF002B20),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currentStep == 3 ? 'Terminer' : 'Suivant'),
                    if (currentStep < 3) ...[
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  bool _canProceed() {
    // Implement the logic to determine if the user can proceed to the next step
    return true; // Placeholder, actual implementation needed
  }
}
