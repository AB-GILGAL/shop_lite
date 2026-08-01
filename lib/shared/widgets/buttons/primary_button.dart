import 'package:flutter/material.dart';

import '../../enums/button_size.dart';
import '../../enums/button_variant.dart';
import '../../../app/theme/icons/app_icon_sizes.dart';
import '../../../app/theme/spacing/app_spacing.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  });


  final String text;

  final VoidCallback? onPressed;

  final IconData? icon;

  final ButtonVariant variant;

  final ButtonSize size;

  final bool isLoading;

  final bool isFullWidth;



  @override
  Widget build(BuildContext context) {

    final button = _buildButton(context);


    return SizedBox(
      width: isFullWidth
          ? double.infinity
          : null,
      child: SizedBox(
        height: _height,
        child: button,
      ),
    );
  }



  Widget _buildButton(BuildContext context) {

    final child = _child;


    switch (variant) {

      case ButtonVariant.filled:

        return FilledButton(
          onPressed:
              isLoading ? null : onPressed,
          child: child,
        );


      case ButtonVariant.outlined:

        return OutlinedButton(
          onPressed:
              isLoading ? null : onPressed,
          child: child,
        );


      case ButtonVariant.text:

        return TextButton(
          onPressed:
              isLoading ? null : onPressed,
          child: child,
        );


      case ButtonVariant.danger:

        return FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor:
                Theme.of(context)
                    .colorScheme
                    .error,
          ),

          onPressed:
              isLoading ? null : onPressed,

          child: child,
        );
    }
  }



  Widget get _child {

    if (isLoading) {

      return Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [

          const SizedBox(
            height: AppIconSizes.md,
            width: AppIconSizes.md,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),


          const SizedBox(
            width: AppSpacing.sm,
          ),


          Text(text),
        ],
      );
    }



    if (icon == null) {
      return Text(text);
    }



    return Row(
      mainAxisSize:
          MainAxisSize.min,

      children: [

        Icon(
          icon,
          size: AppIconSizes.md,
        ),


        const SizedBox(
          width: AppSpacing.sm,
        ),


        Text(text),
      ],
    );
  }



  double get _height {

    switch(size){

      case ButtonSize.small:
        return 40;


      case ButtonSize.medium:
        return 52;


      case ButtonSize.large:
        return 60;
    }
  }
}