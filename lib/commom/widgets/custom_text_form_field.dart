 //the statfulWidget is divided into two classes, the first one is the widget itself and the second one is the state of the widget.

import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {    //declaration of the CustomTextFormField class.
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  const CustomTextFormField({super.key,     //constructor of the CustomTextFormField class.
    this.padding,
    this.hintText,
    this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.suffixIcon,
    this.obscureText,
    this.inputFormatters,
    this.validator,
    this.helperText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  final defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.greenlightOne,
      ),
  );
   
    String? _helpText;   //to create a variable give us the ability to store the helper text that will be displayed below the text field. 
     
     @override
     void initState() {
      super.initState();
      _helpText = widget.helperText;  //initialize the _helpText variable with the value of the helperText property passed to the CustomTextFormField widget.
     }
      

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? 
      const EdgeInsets.symmetric(
        horizontal: 24.0, 
        vertical: 12.0
        ),
      child: TextFormField(
        onChanged: (value) {        //void means that the function does not return any value. thats really important.
          if (value.length == 1) {
            setState(() {           //when the user starts typing in the text field, the helper text will be removed.
              _helpText = null;
            });
          } else if (value.isEmpty) {  
            setState(() {           //when the user deletes all the text in the text field, the helper text will be displayed again.
              _helpText = widget.helperText;
            });
          }
        },
        validator: widget.validator,
        style: AppTextStyles.inputText.copyWith(
          color: AppColors.greenlightOne,
        ),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
        helperText:  _helpText,
        helperMaxLines: 3,
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always, // the text will always float above the text field
         hintText: widget.hintText ,
         labelText: widget.labelText?.toUpperCase(), // text that appears upon the text field when it is empty     
         labelStyle: 
              AppTextStyles.inputLabelText.copyWith(
          color: AppColors.lightGrey),
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide:  const BorderSide(
              color: AppColors.red,     //the color of the border when the text field is in error state
          ),
          ),

          enabledBorder: defaultBorder, 
           disabledBorder: defaultBorder, 
            
             
        ),
      )
    );
  }
}