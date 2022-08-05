import 'package:flutter/material.dart';

class ColorUtility {
  static Color colorFromHex(String hex) => Color(int.parse('0xff$hex'));
}
