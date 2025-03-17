import 'package:flutter/material.dart';
import 'faq_screen.dart';
import 'contact_screen.dart';
import 'help_center_screen.dart';
import 'report_problem_screen.dart';

class SupportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> supportModules = [
    {
      'icon': Icons.question_answer,
      'title': 'Questions fréquentes',
      'subtitle': 'Trouvez rapidement des réponses à vos questions',
      'screen': () => FAQScreen(),
    },
    {
      'icon': Icons.contact_support,
      'title': 'Contactez-nous',
      'subtitle': 'Nous sommes là pour vous aider',
      'screen': () => ContactScreen(),
    },
    {
      'icon': Icons.help_center,
      'title': 'Centre d\'aide',
      'subtitle': 'Guides et tutoriels détaillés',
      'screen': () => HelpCenterScreen(),
    },
    {
      'icon': Icons.report_problem,
      'title': 'Signaler un problème',
      'subtitle': 'Faites-nous part de vos difficultés',
      'screen': () => ReportProblemScreen(),
    },
  ];

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
          'Support',
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
              itemCount: supportModules.length,
              itemBuilder: (context, index) {
                final module = supportModules[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => module['screen'](),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xFF001F17),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xFFB4F700).withOpacity(0.3),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFB4F700).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  module['icon'] as IconData,
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
                                      module['title'] as String,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      module['subtitle'] as String,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFB4F700),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
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