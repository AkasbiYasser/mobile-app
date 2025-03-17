import 'package:flutter/material.dart';
import '../screens/payment_screen.dart';
import '../screens/order_screen.dart';

class AmountPlansSelector extends StatefulWidget {
  final String phoneNumber;
  final Function(double) onAmountSelected;

  AmountPlansSelector({
    required this.phoneNumber,
    required this.onAmountSelected,
  });

  @override
  _AmountPlansSelectorState createState() => _AmountPlansSelectorState();
}

class _AmountPlansSelectorState extends State<AmountPlansSelector> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF002B20),
      child: Column(
        children: [
          // En-tête avec logo
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/maroc.png',
                  height: 60,
                ),
                SizedBox(height: 20),
                Text(
                  'Quel montant souhaitez-vous envoyer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/maroc.png', height: 20),
                    SizedBox(width: 8),
                    Text(
                      widget.phoneNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.edit, color: Color(0xFFB4F700), size: 18),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              labelColor: Color(0xFF002B20),
              unselectedLabelColor: Color(0xFF002B20).withOpacity(0.5),
              tabs: [
                Tab(text: 'Recharge'),
                Tab(text: 'Plans prépayés'),
              ],
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Recharges
                ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    _buildRechargeCard(
                      amount: 100,
                      price: 12.99,
                      isPopular: true,
                    ),
                    SizedBox(height: 12),
                    _buildRechargeCard(
                      amount: 300,
                      price: 38.99,
                      isPopular: false,
                    ),
                    SizedBox(height: 12),
                    _buildRechargeCard(
                      amount: 200,
                      price: 25.99,
                      isPopular: false,
                    ),
                    SizedBox(height: 12),
                    _buildRechargeCard(
                      amount: 50,
                      price: 6.49,
                      isPopular: false,
                    ),
                    SizedBox(height: 12),
                    _buildRechargeCard(
                      amount: 30,
                      price: 3.99,
                      isPopular: false,
                    ),
                    SizedBox(height: 12),
                    _buildRechargeCard(
                      amount: 20,
                      price: 2.69,
                      isPopular: false,
                    ),
                  ],
                ),

                // Plans prépayés
                ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    _buildPlanCard(
                      name: 'Passe Internet Jawal 5 Go',
                      validity: '30 jours',
                      description: 'Le produit délivre 5 Go de données valables 30 jours',
                      price: 6.49,
                      isPopular: true,
                    ),
                    SizedBox(height: 16),
                    _buildPlanCard(
                      name: 'Passe Internet Jawal 2 Go',
                      validity: '7 jours',
                      description: 'Le produit délivre 2 Go de données valables 7 jours',
                      price: 2.69,
                      isPopular: false,
                    ),
                    SizedBox(height: 16),
                    _buildPlanCard(
                      name: 'Passe Internet Jawal 1 Go',
                      validity: '3 jours',
                      description: 'Le produit délivre 1 Go de données valable 7 jours',
                      price: 1.39,
                      isPopular: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRechargeCard({
    required int amount,
    required double price,
    required bool isPopular,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF001F17),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPopular ? Color(0xFF1A237E) : Colors.transparent,
          width: isPopular ? 1 : 0,
        ),
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF1A237E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Plus populaires',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$amount MAD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB4F700),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onAmountSelected(price);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                              phoneNumber: widget.phoneNumber,
                              amount: amount.toDouble(),
                              operatorLogo: 'assets/images/maroc.png',
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          'Acheter $price USD',
                          style: TextStyle(
                            color: Color(0xFF002B20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String name,
    required String validity,
    required String description,
    required double price,
    required bool isPopular,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF001F17),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPopular ? Colors.purple : Colors.transparent,
          width: isPopular ? 1 : 0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                'Plus populaires',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Valable pour $validity',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB4F700),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onAmountSelected(price);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                phoneNumber: widget.phoneNumber,
                                amount: price,
                                operatorLogo: 'assets/images/maroc.png',
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Text(
                            'Acheter $price USD',
                            style: TextStyle(
                              color: Color(0xFF002B20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
