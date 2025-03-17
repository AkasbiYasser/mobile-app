import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';
import '../widgets/step_progress.dart';
import '../models/prepaid_card_models.dart';

class RetailServicesScreen extends StatefulWidget {
  @override
  _RetailServicesScreenState createState() => _RetailServicesScreenState();
}

class _RetailServicesScreenState extends State<RetailServicesScreen> {
  int currentStep = 0;
  String? selectedCategory;
  String? selectedProvider;
  List<CartItem> cart = [];
  String shippingAddress = '';
  bool isProcessing = false;
  String searchTerm = '';
  String deliveryMethod = 'Standard (2-3 jours)';
  String paymentMethod = 'Carte bancaire';

  final List<Map<String, dynamic>> categories = [
    {
      'id': 'pharmacy',
      'name': 'Pharmacie',
      'image': 'images/pharmacy.jpg',
      'color': Color(0xFF4CAF50),
    },
    {
      'id': 'supermarkets',
      'name': 'Supermarchés',
      'image': 'images/super.PNG',
      'color': Color(0xFF2196F3),
    },
    {
      'id': 'technology',
      'name': 'Technologie',
      'image': 'images/tec.PNG',
      'color': Color(0xFF9C27B0),
    },
    {
      'id': 'fashion',
      'name': 'Mode',
      'image': 'images/fashion.png',
      'color': Color(0xFFE91E63),
    },
    {
      'id': 'home',
      'name': 'Maison',
      'image': 'images/home.png',
      'color': Color(0xFF795548),
    },
    {
      'id': 'beauty',
      'name': 'Beauté',
      'icon': Icons.face,
      'color': Color(0xFFFF9800),
    },
  ];

  final List<Map<String, dynamic>> steps = [
    {'id': 'category', 'title': 'Catégorie', 'description': 'Choisir une catégorie'},
    {'id': 'provider', 'title': 'Fournisseur', 'description': 'Choisir un fournisseur'},
    {'id': 'products', 'title': 'Produits', 'description': 'Sélectionner des produits'},
    {'id': 'cart', 'title': 'Panier', 'description': 'Vérifier le panier'},
    {'id': 'shipping', 'title': 'Livraison', 'description': 'Détails de livraison'},
    {'id': 'payment', 'title': 'Paiement', 'description': 'PayPal'},
    {'id': 'confirmation', 'title': 'Confirmation', 'description': 'Confirmation'},
  ];

  final List<Map<String, dynamic>> providers = [
    {
      'id': 1,
      'name': 'SuperMart',
      'category': 'supermarkets',
      'rating': 4.5,
      'logo': 'assets/images/supermart.png',
      'description': 'Supermarché en ligne avec livraison rapide',
    },
    {
      'id': 2,
      'name': 'TechZone',
      'category': 'technology',
      'rating': 4.2,
      'logo': 'assets/images/techzone.png',
      'description': 'Produits électroniques et gadgets',
    },
    {
      'id': 3,
      'name': 'PharmaCare',
      'category': 'pharmacy',
      'rating': 4.7,
      'logo': 'assets/images/pharmacy.png',
      'description': 'Votre pharmacie en ligne',
    },
  ];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Bananes Bio',
      'price': 2.99,
      'provider': 1,
      'image': 'assets/images/banana.png',
      'description': 'Bananes biologiques fraîches',
      'quantity': 0,
    },
    {
      'id': 2,
      'name': 'Pommes',
      'price': 1.99,
      'provider': 1,
      'image': 'assets/images/apple.png',
      'description': 'Pommes fraîches locales',
      'quantity': 0,
    },
    {
      'id': 3,
      'name': 'Smartphone',
      'price': 599.99,
      'provider': 2,
      'image': 'assets/images/phone.png',
      'description': 'Dernier modèle',
      'quantity': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      appBar: AppBar(
        title: Text('Services de Détail'),
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

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildCategoryStep();
      case 1:
        return _buildProviderStep();
      case 2:
        return _buildProductsStep();
      case 3:
        return _buildCartStep();
      case 4:
        return _buildShippingStep();
      case 5:
        return _buildPaymentStep();
      case 6:
        return _buildConfirmationStep();
      default:
        return Container();
    }
  }

  Widget _buildCategoryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) => setState(() => searchTerm = value),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Rechercher une catégorie...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Color(0xFFB4F700)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFB4F700)),
            ),
          ),
        ),
        SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category['id'];
            
            return InkWell(
              onTap: () => setState(() {
                selectedCategory = category['id'];
                currentStep++;
              }),
              child: CustomCard(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        category['color'],
                        category['color'].withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.local_pharmacy,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        category['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProviderStep() {
    final filteredProviders = providers.where((p) => p['category'] == selectedCategory).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez un fournisseur',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredProviders.length,
          itemBuilder: (context, index) {
            final provider = filteredProviders[index];
            final isSelected = selectedProvider == provider['id'].toString();
            
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: CustomCard(
                child: ListTile(
                  onTap: () => setState(() {
                    selectedProvider = provider['id'].toString();
                    currentStep++;
                  }),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(provider['logo']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    provider['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider['description'],
                        style: TextStyle(color: Colors.white70),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            provider['rating'].toString(),
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Color(0xFFB4F700))
                      : null,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductsStep() {
    final providerProducts = products.where((p) => p['provider'].toString() == selectedProvider).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez vos produits',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        TextField(
          onChanged: (value) => setState(() => searchTerm = value),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Rechercher des produits...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Color(0xFFB4F700)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFB4F700)),
            ),
          ),
        ),
        SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: providerProducts.length,
          itemBuilder: (context, index) {
            final product = providerProducts[index];
            final inCart = cart.any((item) => item.id == product['id']);
            
            return CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(product['image']),
                          fit: BoxFit.cover,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product['price']} €',
                          style: TextStyle(
                            color: Color(0xFFB4F700),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (inCart) {
                                cart.removeWhere((item) => item.id == product['id']);
                              } else {
                                cart.add(CartItem(
                                  id: product['id'],
                                  quantity: 1,
                                ));
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: inCart ? Colors.red : Color(0xFFB4F700),
                            minimumSize: Size(double.infinity, 36),
                          ),
                          child: Text(
                            inCart ? 'Retirer' : 'Ajouter',
                            style: TextStyle(color: inCart ? Colors.white : Color(0xFF002B20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCartStep() {
    double total = 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre Panier',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...cart.map((item) {
          final product = products.firstWhere((p) => p['id'] == item.id);
          final subtotal = (product['price'] as double) * item.quantity;
          total += subtotal;
          
          return Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: CustomCard(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(product['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product['price']} €',
                            style: TextStyle(color: Color(0xFFB4F700)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.white),
                          onPressed: () => setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              cart.removeWhere((i) => i.id == item.id);
                            }
                          }),
                        ),
                        Text(
                          '${item.quantity}',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline, color: Colors.white),
                          onPressed: () => setState(() => item.quantity++),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        if (cart.isNotEmpty) ...[
          SizedBox(height: 20),
          CustomCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${total.toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: Color(0xFFB4F700),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else
          Center(
            child: Text(
              'Votre panier est vide',
              style: TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }

  Widget _buildShippingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations de Livraison',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => setState(() => shippingAddress = value),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Adresse de livraison',
                    labelStyle: TextStyle(color: Colors.white70),
                    hintText: 'Entrez votre adresse complète',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFB4F700)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Mode de livraison',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                // Options de livraison
                ...['Standard (2-3 jours)', 'Express (24h)', 'Point Relais'].map((option) {
                  return RadioListTile<String>(
                    title: Text(option, style: TextStyle(color: Colors.white)),
                    value: option,
                    groupValue: deliveryMethod,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => deliveryMethod = value);
                      }
                    },
                    activeColor: Color(0xFFB4F700),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
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
          'Votre commande a été traitée avec succès.',
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
                    Text(currentStep == steps.length - 1 ? 'Terminer' : 'Suivant'),
                    if (currentStep < steps.length - 1) ...[
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

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedCategory != null;
      case 1:
        return selectedProvider != null;
      case 2:
        return cart.isNotEmpty;
      case 3:
        return cart.isNotEmpty;
      case 4:
        return shippingAddress.isNotEmpty;
      default:
        return false;
    }
  }
}

class CartItem {
  final int id;
  int quantity;
  
  CartItem({required this.id, this.quantity = 1});
}
