import 'package:flutter/widgets.dart';

import 'responsive_extensions.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    if (context.responsive.isDesktop) {
      return desktop ?? tablet ?? mobile;
    }

    if (context.responsive.isTablet) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}