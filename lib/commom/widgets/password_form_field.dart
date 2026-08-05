import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/widgets/custom_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const PasswordFormField({
    super.key,
    this.controller,
    this.padding,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  bool isHidden = true;
  
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: widget.validator,
      controller: widget.controller,
      padding: widget.padding,
      hintText: widget.hintText,
      labelText: widget.labelText,
      obscureText: isHidden,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(23.0),
        onTap: () {
            setState(() {
                isHidden = !isHidden;   //recives the opposite value of isHidden, if it was true it will be false and vice versa
            });
        },
        child: Icon(
          isHidden ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    );
}
}