import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';

class CountrySelectionStep extends StatelessWidget {
  final Country? selectedCountry;
  final Function(Country) onCountrySelected;

  const CountrySelectionStep({
    Key? key,
    required this.selectedCountry,
    required this.onCountrySelected,
  }) : super(key: key);

  static final List<Country> countries = [
    Country(
      id: 'usa',
      name: 'États-Unis',
      code: 'US',
      currency: 'USD',
      flag: '🇺🇸',
    ),
    Country(
      id: 'uk',
      name: 'Royaume-Uni',
      code: 'GB',
      currency: 'GBP',
      flag: '🇬🇧',
    ),
    Country(
      id: 'ma',
      name: 'Maroc',
      code: 'MA',
      currency: 'MAD',
      flag: '🇲🇦',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez un pays',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: countries.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final country = countries[index];
            final isSelected = selectedCountry?.id == country.id;

            return InkWell(
              onTap: () => onCountrySelected(country),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF001F17),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFFB4F700) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      country.flag,
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            country.currency,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFFB4F700),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
} 
