import 'package:flutter/material.dart';
import 'custom_card.dart';

class OperatorSelection extends StatelessWidget {
  final Function(String) onOperatorSelected;

  OperatorSelection({required this.onOperatorSelected});

  final List<Map<String, dynamic>> operators = [
    {
      'name': 'Orange',
      'logo': 'assets/images/orange.png',
      'color': Color(0xFFFF7900)
    },
    {
      'name': 'Maroc Telecom',
      'logo': 'assets/images/maroc.png',
      'color': Color(0xFF0066CC)
    },
    {
      'name': 'Inwi',
      'logo': 'assets/images/inwi.png',
      'color': Color(0xFF9B0BAF)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez votre opérateur',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...operators.map((operator) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CustomCard(
            child: InkWell(
              onTap: () => onOperatorSelected(operator['name']),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF001F17),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFB4F700).withOpacity(0.3),
                        ),
                      ),
                      child: Image.asset(
                        operator['logo'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            operator['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Appuyez pour sélectionner',
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
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ],
    );
  }
}
