import 'package:flutter/material.dart';
import 'active_constants.dart';

class KTextStyles {
  final TextStyle header;
  final TextStyle drawer;
  final TextStyle title;
  final TextStyle description;
  final TextStyle caption;
  final TextStyle author;
  final TextStyle actions;
  final TextStyle small;
  final TextStyle muted;

  const KTextStyles({
    required this.header,
    required this.drawer,
    required this.title,
    required this.description,
    required this.caption,
    required this.author,
    required this.actions,
    required this.small,
    required this.muted,
  });
}

KTextStyles textStyles1 = KTextStyles(
  header: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36.0,
    color: activeColors.black,
  ),
  drawer: TextStyle(
    letterSpacing: 0.3,
    fontSize: 14.0,
    fontWeight: FontWeight.w100,
    color: activeColors.grey,
  ),
  title: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: activeColors.black,
  ),
  description: TextStyle(
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: Colors.grey.shade700,
  ),
  caption: TextStyle(
    height: 1.4,
    fontSize: 12.0,
    color: Colors.grey.shade700,
  ),
  author: TextStyle(
    fontSize: 14.0,
    color: Colors.grey.shade700,
    fontStyle: FontStyle.italic,
  ),
  actions: TextStyle(
    height: 1.4,
    fontSize: 16.0,
    color: activeColors.secondary,
  ),
  small: TextStyle(
    fontSize: 12.0,
    color: Colors.grey.shade500,
  ),
  muted: TextStyle(
    fontSize: 16.0,
    color: activeColors.grey,
  ),
);
