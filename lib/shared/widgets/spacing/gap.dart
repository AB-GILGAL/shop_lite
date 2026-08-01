import 'package:flutter/widgets.dart';

import '../../../app/theme/spacing/app_spacing.dart';

class Gap extends StatelessWidget {
  const Gap.xs({super.key})
      : width = 0,
        height = AppSpacing.xs;

  const Gap.sm({super.key})
      : width = 0,
        height = AppSpacing.sm;

  const Gap.md({super.key})
      : width = 0,
        height = AppSpacing.md;

  const Gap.lg({super.key})
      : width = 0,
        height = AppSpacing.lg;

  const Gap.xl({super.key})
      : width = 0,
        height = AppSpacing.xl;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}