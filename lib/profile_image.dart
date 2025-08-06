import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:profile_name_avatar/profile_name_avatar.dart';

class ProfileImage extends StatelessWidget {
  /// Image path or URL
  final String imageSource;

  // Either placeholder or fallback name is necessary
  /// Optional placeholder path (asset or URL)
  final String? placeholder;

  /// Name to display if the image and placeholder both fail to load
  final String? fallbackName;

  /// Optional radius
  final double? radius;

  /// Optional text style for the fallback avatar
  final TextStyle? textStyle;

  /// Optional background color for the fallback avatar
  final Color? backgroundColor;

  ProfileImage({
    Key? key,
    required this.imageSource,
    this.fallbackName,
    this.radius,
    this.textStyle,
    this.backgroundColor,
    this.placeholder,
  }) : super(key: key) {
    if (fallbackName == null && placeholder == null) {
      throw ArgumentError(
        'ProfileImage requires at least one fallback: either fallbackName or placeholder must be provided.',
      );
    }
  }

  bool _isNetworkPath(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  Widget _buildFinalFallback() {
    if (fallbackName != null) {
      return ProfileAvatar(
        name: fallbackName!,
        radius: radius,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
      );
    }
    // Fallback to a blank container if both somehow fail (shouldn't happen due to assert)
    return Container(color: Colors.grey);
  }

  Widget _buildPlaceholderWidget() {
    if (placeholder != null) {
      if (_isNetworkPath(placeholder!)) {
        return Image.network(
          placeholder!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFinalFallback(),
        );
      } else {
        return Image.asset(
          placeholder!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFinalFallback(),
        );
      }
    }
    return _buildFinalFallback();
  }

  @override
  Widget build(BuildContext context) {
    final Widget fallbackWidget = _buildPlaceholderWidget();

    return SizedBox(
      width: radius,
      height: radius,
      child: ClipOval(
        child: isNetworkImage
            ? CachedNetworkImage(
                imageUrl: imageSource,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => fallbackWidget,
                placeholder: (context, url) => fallbackWidget,
              )
            : Image.asset(
                imageSource,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => fallbackWidget,
              ),
      ),
    );
  }

  bool get isNetworkImage => _isNetworkPath(imageSource);
}
