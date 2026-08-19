

import 'package:flutter/material.dart';

class Utils {

  static String getNameInitials(String name) {
    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    final first = parts.first[0];
    final second = parts[1][0];
    return (first + second).toUpperCase();
  }

  static Color getAvatarColor(String name,BuildContext context) {
    final colors = [
      Colors.purple,
      Colors.teal,
      Colors.orange,
      Colors.pink,
      Colors.green,
      Colors.indigo,
    ];

    final index = name.hashCode % colors.length;

    return colors[index.abs()];
  }
}