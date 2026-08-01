import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/icons/app_icon_sizes.dart';
import '../../../app/theme/radius/app_radius.dart';
import '../../enums/image_shape.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = ImageShape.rounded,
    this.borderRadius = AppRadius.md,
    this.placeholder,
    this.errorWidget,
    this.aspectRatio,
    this.memCacheHeight,
    this.memCacheWidth,
  });

  final String imageUrl;

  final double? width;

  final double? height;

  final BoxFit fit;

  final ImageShape shape;

  final double borderRadius;

  final Widget? placeholder;

  final Widget? errorWidget;

  final double? aspectRatio;

  final int? memCacheWidth;

  final int? memCacheHeight;

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: _borderRadius,

      child: CachedNetworkImage(
        imageUrl: imageUrl,

        width: width,

        height: height,

        fit: fit,
        
        memCacheWidth: memCacheWidth,

        memCacheHeight: memCacheHeight,

        placeholder: (_, _) => placeholder ?? _defaultPlaceholder(),

        errorWidget: (context, url, error) {
  debugPrint('IMAGE LOAD FAILED');
  debugPrint('URL: $url');
  debugPrint('ERROR: $error');

  return errorWidget ?? _defaultError();
},

        fadeInDuration: const Duration(milliseconds: 300),
      ),
    );
    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: image);
    }

    return image;
  }

  BorderRadius get _borderRadius {
    switch (shape) {
      case ImageShape.circle:
        return BorderRadius.circular(999);

      case ImageShape.rounded:
        return BorderRadius.circular(borderRadius);

      case ImageShape.rectangle:
        return BorderRadius.zero;
    }
  }

  Widget _defaultPlaceholder() {
    return Container(
      color: Colors.grey.shade200,

      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _defaultError() {
    return Container(
      color: Colors.grey.shade200,

      child: const Icon(
        Icons.image_not_supported_outlined,
        size: AppIconSizes.xxl,
      ),
    );
  }
}
