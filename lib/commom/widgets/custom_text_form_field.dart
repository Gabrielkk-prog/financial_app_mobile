import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:flutter/material.dart' show BorderSide, TextFormField, TextInputAction, StatefulWidget, EdgeInsetsGeometry, TextCapitalization, TextEditingController, TextInputType;

class CustomTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    super.key, required 
    this.padding,
    this.hintText,
    this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.greenlightTwo)
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? 
      const EdgeInsets.symmetric(
        horizontal: 24.0, 
        vertical: 12.0
        ),
      child: TextFormField(
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
       decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always, // the text will always float above the text field
         hintText: widget.hintText ,
         labelText: widget.labelText?.toUpperCase(), // text that appears upon the text field when it is empty     
         labelStyle: 
              AppTextStyles.inputLabelText.copyWith(
          color: AppColors.lightGrey),
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: AppColors.red,
          ),
          ),
            focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: AppColors.red,
          ),
          ),
          enabledBorder: defaultBorder, 
           disabledBorder: defaultBorder, 
            
             
        ),
      )
    );
  }
}