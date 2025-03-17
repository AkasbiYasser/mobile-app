import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';
import '../widgets/custom_card.dart';

class CardSelectionStep extends StatelessWidget {
  final PrepaidCard? selectedCard;
  final Function(PrepaidCard) onCardSelected;

  const CardSelectionStep({
    required this.selectedCard,
    required this.onCardSelected,
  });

  // Liste des cartes prépayées disponibles
  static final List<PrepaidCard> cards = [
    PrepaidCard(
      id: 'visa',
      name: 'Global Traveler Card',
      type: 'Visa',
      description: 'Carte Visa pour les voyages internationaux',
      currency: 'USD',
      image: 'images/visa.jpg',
      availableAmounts: [25, 50, 100, 200],
    ),
    PrepaidCard(
      id: 'mastercard',
      name: 'Shopping Card',
      type: 'MasterCard',
      description: 'Carte MasterCard pour vos achats',
      currency: 'EUR',
      image: 'images/mastercard.jpg',
      availableAmounts: [20, 30, 50, 100],
    ),
    // Ajoutez d'autres cartes si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choisissez une carte',
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
            childAspectRatio: 0.8,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            final isSelected = selectedCard?.id == card.id;
            
            return CustomCard(
              child: InkWell(
                onTap: () => onCardSelected(card),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(card.image),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          card.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          card.description,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
} 
