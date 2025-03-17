import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';

class DeliverySelectionStep extends StatelessWidget {
  final String? selectedMethod;
  final String? deliveryDetails;
  final Function(String) onMethodSelected;
  final Function(String) onDetailsChanged;

  const DeliverySelectionStep({
    Key? key,
    required this.selectedMethod,
    required this.deliveryDetails,
    required this.onMethodSelected,
    required this.onDetailsChanged,
  }) : super(key: key);

  static final List<DeliveryMethod> deliveryMethods = [
    DeliveryMethod(id: 'email', name: 'Email', icon: Icons.email),
    DeliveryMethod(id: 'sms', name: 'SMS', icon: Icons.phone_android),
    DeliveryMethod(id: 'whatsapp', name: 'WhatsApp', icon: Icons.message),
    DeliveryMethod(id: 'telegram', name: 'Telegram', icon: Icons.send),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mode de livraison',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
            childAspectRatio: 1.2,
          ),
          itemCount: deliveryMethods.length,
          itemBuilder: (context, index) {
            final method = deliveryMethods[index];
            final isSelected = selectedMethod == method.id;

            return InkWell(
              onTap: () => onMethodSelected(method.id),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF001F17),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      method.icon,
                      color: Color(0xFFB4F700),
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      method.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (selectedMethod != null) ...[
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF001F17),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Détails de livraison',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: selectedMethod == 'email' 
                      ? 'Entrez votre email' 
                      : 'Entrez votre numéro',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFB4F700)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFB4F700).withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFFB4F700)),
                    ),
                  ),
                  onChanged: onDetailsChanged,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
} 
