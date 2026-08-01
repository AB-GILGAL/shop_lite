import 'package:flutter/material.dart';

import '../../../app/theme/icons/app_icon_sizes.dart';


class AppTextField extends StatefulWidget {

  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showClearButton = false,
  });


  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? label;

  final String? hint;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final bool obscureText;

  final bool readOnly;

  final bool enabled;

  final int maxLines;

  final int? minLines;

  final int? maxLength;

  final bool showClearButton;



  @override
  State<AppTextField> createState() =>
      _AppTextFieldState();

}



class _AppTextFieldState
    extends State<AppTextField> {


  late bool _obscure;


  @override
  void initState() {

    super.initState();

    _obscure =
        widget.obscureText;
  }



  void _togglePassword(){

    setState(() {
      _obscure = !_obscure;
    });

  }



  @override
  Widget build(BuildContext context) {


    return TextFormField(

      controller: widget.controller,

      focusNode: widget.focusNode,

      obscureText: _obscure,

      keyboardType:
          widget.keyboardType,

      textInputAction:
          widget.textInputAction,

      validator:
          widget.validator,

      onChanged:
          widget.onChanged,

      onFieldSubmitted:
          widget.onSubmitted,

      readOnly:
          widget.readOnly,

      enabled:
          widget.enabled,

      maxLines:
          _obscure
              ? 1
              : widget.maxLines,

      minLines:
          widget.minLines,

      maxLength:
          widget.maxLength,


      decoration:
          InputDecoration(

        labelText:
            widget.label,

        hintText:
            widget.hint,


        prefixIcon:
            widget.prefixIcon,


        suffixIcon:
            _buildSuffix(),


      ),

    );

  }



  Widget? _buildSuffix(){

    if(widget.obscureText){

      return IconButton(
        icon: Icon(
          _obscure
              ? Icons.visibility_off
              : Icons.visibility,
          size: AppIconSizes.lg,
        ),

        onPressed:
            _togglePassword,
      );
    }


    if(widget.showClearButton){

      return IconButton(
        icon:
            const Icon(Icons.clear),

        onPressed: (){

          widget.controller?.clear();

          widget.onChanged?.call('');

        },
      );
    }


    return widget.suffixIcon;
  }

}