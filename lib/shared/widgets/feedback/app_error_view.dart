import 'package:flutter/material.dart';
import 'package:shop_lite/app/theme/spacing/app_spacing.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Icon(Icons.error_outline),

          const SizedBox(height: AppSpacing.md),

          Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

          if (onRetry != null)

            ElevatedButton(
              onPressed: onRetry,
              child: Text(
              'Retry',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ),
        ],
      ),
    );
  }
}