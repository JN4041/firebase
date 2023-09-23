import 'package:flutter/material.dart';

class Comman_tax extends StatelessWidget {
  final hint;
  final sufix;
  final perfix;
  final taxinput;
  final bool obscur;
  final VoidCallback ontap;
  final String? Function(String?)? validator;
  final void Function(String)? onchage;
  final contro;
  final leg;

  const Comman_tax(
      {Key? key,
      this.hint,
      this.perfix,
      this.validator,
      this.onchage,
      this.contro,
      this.sufix,
      required this.ontap,
      required this.obscur,
      this.taxinput,
      this.leg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: leg,
      keyboardType: taxinput,
      onTap: ontap,
      obscureText: obscur,
      validator: validator,
      onChanged: onchage,
      controller: contro,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.grey.shade100,
        filled: true,
        prefixIcon: perfix,
        suffixIcon: sufix,
        counterText: "",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
