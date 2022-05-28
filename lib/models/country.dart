import 'package:flutter/material.dart';

class Country {
  final String id;
  final String title;
  final Color color;
  final bool isSelected;

  const Country({
    required this.id,
    required this.title,
    this.color = Colors.blue,
    this.isSelected = false,
  });

  toggleSelected() {
    isSelected = !isSelected;
  }

  set isSelected(bool value) {
    isSelected = value;
  }

}
