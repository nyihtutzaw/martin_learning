import 'package:flutter/material.dart';
import 'active_constants.dart';

class KTextStyles {
  final TextStyle header;
  final TextStyle drawer;
  final TextStyle title;
  final TextStyle description;
  final TextStyle caption;
  final TextStyle muted;

  const KTextStyles({
    required this.header,
    required this.drawer,
    required this.title,
    required this.description,
    required this.caption,
    required this.muted,
  });
}

KTextStyles textStyles1 = KTextStyles(
  header: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 21.0,
    color: activeColors.black,
  ),
  drawer: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: activeColors.white,
  ),
  title: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    color: activeColors.black,
  ),
  description: TextStyle(
    fontSize: 16.0,
    color: activeColors.black,
  ),
  caption: TextStyle(
    fontSize: 14.0,
    color: activeColors.black,
  ),
  muted: TextStyle(
    fontSize: 14.0,
    color: activeColors.grey,
  ),
);
