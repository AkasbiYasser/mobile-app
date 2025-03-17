// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\profile_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_card.dart';
import '../screens/coordinates_screen.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';
import 'payment_methods_screen.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imageUrl;
  String? _name;
  String? _birthday;
  String? _email;
  String? _phone;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageUrl = image.path;
      });
    }
  }

  void _editPersonalInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF002B20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nom',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                ),
                onChanged: (value) => setState(() => _name = value),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Date de naissance',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                ),
                onChanged: (value) => setState(() => _birthday = value),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                ),
                onChanged: (value) => setState(() => _email = value),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                ),
                onChanged: (value) => setState(() => _phone = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB4F700),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSupportScreen() {
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
              'Support',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Comment pouvons-nous vous aider ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildSupportItem(
                  'Questions fréquentes',
                  'Trouvez rapidement des réponses à vos questions',
                  Icons.help_outline,
                  () => _showFAQScreen(context),
                ),
                _buildSupportItem(
                  'Contactez-nous',
                  'Envoyez-nous un message pour toute assistance',
                  Icons.message_outlined,
                  () => _showContactScreen(context),
                ),
                _buildSupportItem(
                  'Centre d\'aide',
                  'Consultez notre documentation détaillée',
                  Icons.article_outlined,
                  () => _showHelpCenterScreen(context),
                ),
                _buildSupportItem(
                  'Signaler un problème',
                  'Faites-nous part de tout dysfonctionnement',
                  Icons.bug_report_outlined,
                  () => _showReportProblemScreen(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupportItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return CustomCard(
      child: ListTile(
        leading: Icon(
          icon,
          color: Color(0xFFB4F700),
          size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFB4F700),
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showFAQScreen(BuildContext context) {
    final List<Map<String, String>> faqItems = [
      {
        'question': 'Comment recharger mon compte ?',
        'answer': 'Pour recharger votre compte, suivez ces étapes :\n\n'
            '1. Sélectionnez "Recharge" sur l\'écran d\'accueil\n'
            '2. Entrez le numéro de téléphone\n'
            '3. Choisissez le montant de recharge\n'
            '4. Sélectionnez votre mode de paiement\n'
            '5. Confirmez le paiement',
      },
      {
        'question': 'Quels sont les moyens de paiement acceptés ?',
        'answer': 'Nous acceptons les modes de paiement suivants :\n\n'
            '• PayPal\n'
            '• Cartes bancaires (Visa, Mastercard)\n'
            '• Apple Pay\n'
            '• Paiement mobile',
      },
      {
        'question': 'Comment utiliser un code promotionnel ?',
        'answer': 'Pour utiliser un code promotionnel :\n\n'
            '1. Lors du paiement, cliquez sur "Ajouter un code promotionnel"\n'
            '2. Entrez votre code\n'
            '3. Cliquez sur "Valider"\n\n'
            'La réduction sera automatiquement appliquée à votre commande.',
      },
    ];

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
              'Questions fréquentes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: faqItems.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF001F17),
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFFB4F700).withOpacity(0.3),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(16),
                  childrenPadding: EdgeInsets.all(16),
                  title: Text(
                    faqItems[index]['question']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Color(0xFFB4F700),
                  collapsedIconColor: Color(0xFFB4F700),
                  children: [
                    Text(
                      faqItems[index]['answer']!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showContactScreen(BuildContext context) {
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
        'icon': Icons.message,
        'title': 'WhatsApp',
        'subtitle': 'Messagerie instantanée',
        'action': 'https://wa.me/212520000000',
      },
    ];

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
              'Contactez-nous',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.builder(
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
                  subtitle: Text(
                    option['subtitle'] as String,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFB4F700),
                    size: 16,
                  ),
                  onTap: () {
                    if (option['action'] == 'chat') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Le chat en direct sera bientôt disponible'),
                          backgroundColor: Color(0xFF002B20),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showHelpCenterScreen(BuildContext context) {
    final List<Map<String, dynamic>> helpCategories = [
      {
        'icon': Icons.phone_android,
        'title': 'Recharges mobiles',
        'items': [
          'Comment recharger un numéro',
          'Types de recharges disponibles',
          'Délais de traitement',
          'Problèmes courants',
        ],
      },
      {
        'icon': Icons.payment,
        'title': 'Paiements',
        'items': [
          'Modes de paiement acceptés',
          'Sécurité des transactions',
          'Remboursements',
          'Factures et reçus',
        ],
      },
    ];

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
              'Centre d\'aide',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: helpCategories.length,
            itemBuilder: (context, index) {
              final category = helpCategories[index];
              return Card(
                color: Color(0xFF001F17),
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Color(0xFFB4F700).withOpacity(0.3),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFB4F700).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Color(0xFFB4F700),
                      size: 24,
                    ),
                  ),
                  title: Text(
                    category['title'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Color(0xFFB4F700),
                  collapsedIconColor: Color(0xFFB4F700),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (category['items'] as List).length,
                      itemBuilder: (context, itemIndex) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          title: Text(
                            category['items'][itemIndex] as String,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFB4F700),
                            size: 16,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => Container(
                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: BoxDecoration(
                                  color: Color(0xFF002B20),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category['items'][itemIndex] as String,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Contenu détaillé à venir...',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showReportProblemScreen(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _selectedCategory = 'Recharge';
    String _description = '';
    String _email = '';
    bool _isSubmitting = false;

    final List<String> _categories = [
      'Recharge',
      'Paiement',
      'Code promotionnel',
      'Compte',
      'Application',
      'Autre',
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Scaffold(
            backgroundColor: Color(0xFF002B20),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Signaler un problème',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catégorie du problème',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF001F17),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFFB4F700).withOpacity(0.3),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          dropdownColor: Color(0xFF001F17),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCategory = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description du problème',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      maxLines: 5,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Décrivez votre problème en détail...',
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Color(0xFF001F17),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFB4F700).withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFB4F700),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez décrire votre problème';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _description = value;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email de contact',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Votre email',
                        hintStyle: TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Color(0xFF001F17),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFB4F700).withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFFB4F700),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!value.contains('@')) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isSubmitting
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isSubmitting = true;
                                  });

                                  // Simuler l'envoi
                                  Future.delayed(Duration(seconds: 2), () {
                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Votre signalement a été envoyé avec succès',
                                        ),
                                        backgroundColor: Color(0xFF002B20),
                                      ),
                                    );
                                  });
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB4F700),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: _isSubmitting
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF002B20),
                                ),
                              )
                            : Text(
                                'Envoyer le signalement',
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002B20),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFFB4F700).withOpacity(0.2),
                          backgroundImage: _imageUrl != null ? FileImage(File(_imageUrl!)) : null,
                          child: _imageUrl == null ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white70,
                          ) : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFB4F700),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: Color(0xFF002B20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showSupportScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB4F700),
                      foregroundColor: Color(0xFF002B20),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Obtenir de l\'aide',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (_name != null) Text(
                    _name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_email != null) Text(
                    _email!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  if (_phone != null) Text(
                    _phone!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
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
