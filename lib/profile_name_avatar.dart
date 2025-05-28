library profile_name_avatar;

import 'package:flutter/material.dart';

/// A customizable circular profile avatar that displays user initials
/// with an optional radius, text style, and background color.
///
/// If no [radius] is provided, the widget will adapt to its parent
/// container's size using [LayoutBuilder].
class ProfileAvatar extends StatelessWidget {
  /// Full name of the user (e.g., "Sarbath Shameer")
  final String name;

  /// Optional radius of the circular avatar.
  /// If null, size will adapt to parent container via LayoutBuilder.
  final double? radius;

  /// Optional custom text style for the initials
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

  /// Extracts initials from the full name.
  /// For example, "Sarbath Shameer" becomes "SS".
  String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    String initials = parts[0][0];
    if (parts.length > 1) initials += parts[1][0];
    return initials.toUpperCase();
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
    final initials = getInitials(name);
    final bgColor = backgroundColor ?? generateColor(name);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use provided radius or compute from parent container size
        final double effectiveRadius =
            radius ?? constraints.biggest.shortestSide / 2;

        // Scale text size based on radius
        final double fontSize = effectiveRadius * 0.6;

        return CircleAvatar(
          backgroundColor: bgColor,
          radius: radius,
          child: Center(
            child: Text(
              initials,
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