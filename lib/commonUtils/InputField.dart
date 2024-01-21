import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? lbltxt;
  final String? hnttxt;
  final TextInputType? kybrdtype;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final FormFieldValidator<String>? validator; // Added validator
  final bool isPassword; // Added for password visibility toggle

  const InputField({
    this.controller,
    this.lbltxt,
    this.hnttxt,
    this.kybrdtype,
    this.padding,
    this.icon,
    this.isPassword = false,
     this.validator, // Default is not a password field
    super.key,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPasswordVisible = false; // Track password visibility

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.kybrdtype,
      controller: widget.controller,
      obscureText: widget.isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: widget.lbltxt,
        labelStyle: const TextStyle(
          color: Color(0xffB81736),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: widget.hnttxt,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      ),
      validator:widget.validator,
   
    );
  }
}
