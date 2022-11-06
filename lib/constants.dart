import 'package:flutter/material.dart';

class Constants{
  static const normalSpace = 8.0;
  static const betweenSpace = 4.0;
  static const businessName = 'Empire Furniture City';
  static const Map<String, List<String>> menuItems = {
    'Admin': ['Add Item', 'Add Category', 'Add Color', 'Add User', 'Close Day', 'Logout'],
    'Employee': ['Cash Sale', 'Lay-buy', 'Make Payment', 'Close Day', 'Logout'],
    'Guest': ['Login']
  };
}