

import 'package:flutter/material.dart';
class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;
  final IconData icon;


  const Transaction({
    required this.id,
    required this.value,
    required this.title,
    required this.date,
    required this.icon,
  });
}
