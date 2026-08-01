import 'package:flutter/widgets.dart';

import 'responsive.dart';

extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}