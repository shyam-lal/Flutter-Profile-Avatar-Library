library profile_name_avatar;

import 'package:flutter/material.dart';

/// A customizable circular profile avatar that displays up to the first
/// four letters of the provided name.
///
/// If no [radius] is provided, the widget will adapt to its parent
/// container's size using [LayoutBuilder].
class ProfileAvatar extends StatelessWidget {
  /// Full name of the user (e.g., "Sarbath Shameer").
  final String name;

  /// Optional radius of the circular avatar.
  /// If null, size will adapt to parent container via LayoutBuilder.
  final double? radius;

  /// Optional custom text style for the displayed letters.
  final TextStyle? textStyle;

  /// Optional background color. If null, a color will be generated from name hash.
  final Color? backgroundColor;

  const ProfileAvatar({
    Key? key,
    required this.name,
    this.radius,
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  /// Extracts up to the first four letters from the name.
  /// If the name is shorter than four letters, returns it as is.
  String getFirstLetters(String name) {
    final cleaned = name.trim().replaceAll(RegExp(r'\s+'), '');
    if (cleaned.isEmpty) return '';
    return cleaned
        .substring(0, cleaned.length < 4 ? cleaned.length : 4)
        .toUpperCase();
  }

  /// Generates a consistent background color based on the input string's hash.
  Color generateColor(String input) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.teal,
      Colors.indigo,
    ];
    final hash = input.codeUnits.fold(0, (prev, e) => prev + e);
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final letters = getFirstLetters(name);
    final bgColor = backgroundColor ?? generateColor(name);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use provided radius or compute from parent container size
        final double effectiveRadius =
            radius ?? constraints.biggest.shortestSide / 2;

        // Scale text size based on radius
        final double fontSize = effectiveRadius * 0.3;

        return CircleAvatar(
          backgroundColor: bgColor,
          radius: radius,
          child: Center(
            child: Text(
              letters,
              textAlign: TextAlign.center,
              style: textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      },
    );
  }
}
