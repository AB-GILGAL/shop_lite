import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

class Responsive {
  const Responsive(this.context);

  final BuildContext context;

  Size get size => MediaQuery.sizeOf(context);

  double get width => size.width;

  double get height => size.height;

  bool get isMobile =>
      width < Breakpoints.mobile;

  bool get isTablet =>
      width >= Breakpoints.mobile &&
      width < Breakpoints.desktop;

  bool get isDesktop =>
      width >= Breakpoints.desktop;

  bool get isPortrait =>
      height >= width;

  bool get isLandscape =>
      width > height;
}