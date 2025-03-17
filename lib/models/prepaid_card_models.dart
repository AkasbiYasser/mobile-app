import 'package:flutter/material.dart';

class StepData {
  final String id;
  final String title;
  final String description;

  StepData({
    required this.id,
    required this.title,
    required this.description,
  });
}

class PrepaidCard {
  final String id;
  final String name;
  final String type;
  final String image;
  final String description;
  final String currency;
  final List<double> availableAmounts;

  PrepaidCard({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.description,
    required this.currency,
    required this.availableAmounts,
  });
}

class Country {
  final String id;
  final String name;
  final String code;
  final String currency;
  final String flag;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.currency,
    required this.flag,
  });
}

class DeliveryMethod {
  final String id;
  final String name;
  final IconData icon;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.icon,
  });
} 
