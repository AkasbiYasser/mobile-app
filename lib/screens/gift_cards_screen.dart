// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\gift_cards_screen.dart

import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../widgets/step_progress.dart';
import '../models/prepaid_card_models.dart';

class GiftCardsScreen extends StatefulWidget {
  @override
  _GiftCardsScreenState createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  int currentStep = 0;
  int? selectedProduct;
  String? selectedCountry;
  String? deliveryMethod;
  String deliveryDetails = '';
  String searchTerm = '';
  String selectedCategory = 'Tous';
  bool termsAccepted = false;
  bool isProcessing = false;
  
  final List<String> categories = [
    'Tous',
    'Jeux',
    'Shopping',
    'Musique',
    'Streaming',
    'Autres'
  ];

  final List<Map<String, dynamic>> steps = [
    {'id': 'product', 'title': 'Produit', 'description': 'Choisir un produit'},
    {'id': 'country', 'title': 'Pays', 'description': 'Choisir le pays'},
    {'id': 'delivery', 'title': 'Livraison', 'description': 'Mode de livraison'},
    {'id': 'payment', 'title': 'Paiement', 'description': 'PayPal'},
    {'id': 'confirmation', 'title': 'Confirmation', 'description': 'Confirmation'},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Amazon Gift Card',
      'type': 'Shopping',
      'price': 50,
      'currency': 'USD',
      'image': 'images/amazon.jpg',
      'rating': 4.5,
      'category': 'Shopping',
      'description': 'Carte cadeau Amazon'
    },
    {
      'id': 2,
      'name': 'iTunes Gift Card',
      'type': 'Musique',
      'price': 25,
      'currency': 'USD',
      'image': 'images/itunes.png',
      'rating': 4.2,
      'category': 'Musique',
      'description': 'Pour acheter de la musique, des apps et plus'
    },
    {
      'id': 3,
      'name': 'Steam Gift Card',
      'type': 'Jeux',
      'price': 20,
      'currency': 'USD',
      'image': 'images/steam.png',
      'rating': 4.7,
      'category': 'Jeux',
      'description': 'Crédit pour acheter des jeux sur Steam'
    },
    {
      'id': 4,
      'name': 'Netflix Gift Card',
      'type': 'Streaming',
      'price': 30,
      'currency': 'USD',
      'image': 'images/netflix.jpg',
      'rating': 4.8,
      'category': 'Streaming',
      'description': 'Accédez à des milliers de films et séries'
    },
    {
      'id': 5,
      'name': 'PlayStation Store',
      'type': 'Jeux',
      'price': 50,
      'currency': 'USD',
      'image': 'images/psn.png',
      'rating': 4.6,
      'category': 'Jeux',
      'description': 'Pour le PlayStation Store'
    },
  ];

  final List<Map<String, dynamic>> countries = [
    {'id': 'usa', 'name': 'États-Unis', 'flag': '🇺🇸', 'currency': 'USD'},
    {'id': 'ma', 'name': 'Maroc', 'flag': '🇲🇦', 'currency': 'MAD'},
    {'id': 'fr', 'name': 'France', 'flag': '🇫🇷', 'currency': 'EUR'},
  ];

  final List<Map<String, dynamic>> deliveryMethods = [
    {'id': 'email', 'name': 'Email', 'icon': Icons.email},
    {'id': 'sms', 'name': 'SMS', 'icon': Icons.phone_android},
    {'id': 'whatsapp', 'name': 'WhatsApp', 'icon': Icons.message},
  ];

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildProductStep();
      case 1:
        return _buildCountryStep();
      case 2:
        return _buildDeliveryStep();
      case 3:
        return _buildPaymentStep();
      case 4:
        return _buildConfirmationStep();
      default:
        return Container();
    }
  }

  Widget _buildProductStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) => setState(() => searchTerm = value),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Rechercher des cartes...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Color(0xFFB4F700)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFB4F700)),
            ),
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              bool isSelected = selectedCategory == category;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: FilterChip(
                  selected: isSelected,
                  label: Text(category),
                  onSelected: (bool selected) {
                    setState(() => selectedCategory = category);
                  },
                  backgroundColor: Color(0xFF001F17),
                  selectedColor: Color(0xFFB4F700),
                  checkmarkColor: Color(0xFF002B20),
                  labelStyle: TextStyle(
                    color: isSelected ? Color(0xFF002B20) : Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final isSelected = selectedProduct == product['id'];
            
            if ((searchTerm.isNotEmpty && 
                !product['name'].toString().toLowerCase().contains(searchTerm.toLowerCase())) ||
                (selectedCategory != 'Tous' && product['category'] != selectedCategory)) {
              return Container();
            }
            
            return _buildProductCard(product, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildCountryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez le pays',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ...countries.map((country) => CustomCard(
          child: ListTile(
            leading: Text(
              country['flag'],
              style: TextStyle(fontSize: 24),
            ),
            title: Text(
              country['name'],
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              country['currency'],
              style: TextStyle(color: Colors.white70),
            ),
            selected: selectedCountry == country['id'],
            onTap: () => setState(() => selectedCountry = country['id']),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildDeliveryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez le mode de livraison',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ...deliveryMethods.map((method) => CustomCard(
          child: ListTile(
            leading: Icon(
              method['icon'],
              color: Color(0xFFB4F700),
            ),
            title: Text(
              method['name'],
              style: TextStyle(color: Colors.white),
            ),
            selected: deliveryMethod == method['id'],
            onTap: () => setState(() => deliveryMethod = method['id']),
          ),
        )).toList(),
        if (deliveryMethod != null) ...[
          SizedBox(height: 20),
          TextField(
            onChanged: (value) => setState(() => deliveryDetails = value),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: deliveryMethod == 'email' ? 'Entrez votre email' : 'Entrez votre numéro',
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFB4F700)),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isProcessing = true;
                    });
                    // Simuler le processus de paiement
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        isProcessing = false;
                        currentStep++;
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
    );
  }

  Widget _buildConfirmationStep() {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          size: 100,
          color: Color(0xFFB4F700),
        ),
        SizedBox(height: 24),
        Text(
          'Paiement Confirmé !',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Votre carte cadeau a été traitée avec succès.',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB4F700),
            foregroundColor: Color(0xFF002B20),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text('Retour à l\'accueil'),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, bool isSelected) {
    return CustomCard(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color(0xFF001F17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                product['name'],
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product['image']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product['description'],
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${product['price']} ${product['currency']}',
                    style: TextStyle(
                      color: Color(0xFFB4F700),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Fermer',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedProduct = product['id'];
                      currentStep = 1; // Passer à l'étape pays
                    });
                    Navigator.pop(context); // Fermer le dialogue
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB4F700),
                    foregroundColor: Color(0xFF002B20),
                  ),
                  child: Text('Sélectionner'),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(product['image']),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      product['type'],
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product['price']} ${product['currency']}',
                          style: TextStyle(
                            color: Color(0xFFB4F700),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${product['rating']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      appBar: AppBar(
        title: Text('Cartes Cadeaux & PIN'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StepProgress(
                  steps: steps.map((s) => StepData(
                    id: s['id'] as String,
                    title: s['title'] as String,
                    description: s['description'] as String,
                  )).toList(),
                  currentStep: currentStep,
                ),
                SizedBox(height: 24),
                _buildCurrentStep(),
                SizedBox(height: 24),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
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
            TextButton(
              onPressed: () => setState(() => currentStep--),
              child: Text('Retour', style: TextStyle(color: Colors.white)),
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
                ),
                child: Text('Suivant'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedProduct != null;
      case 1:
        return selectedCountry != null;
      case 2:
        return deliveryMethod != null && deliveryDetails.isNotEmpty;
      default:
        return false;
    }
  }
}
