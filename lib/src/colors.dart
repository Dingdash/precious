import 'package:flutter/material.dart';




final backgroundColor = Colors.white;
final primaryColor = hexToColor('#e85555');
final canvasColor = hexToColor('#2a2a2c');
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}