import 'package:flutter/material.dart';

class MyChip extends StatelessWidget{
  final String text;
  final bool isSelected;

  const MyChip({required this.text, required this.isSelected});

  Widget build(BuildContext context) {
    return Chip(
      label: Text(text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey[500]),
      ),
      backgroundColor: isSelected ? Colors.brown[400] : Colors.grey[100],
      padding: EdgeInsets.all(16),
    );
  }
}