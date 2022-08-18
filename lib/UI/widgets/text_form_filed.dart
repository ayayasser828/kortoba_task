import 'package:flutter/material.dart';

class MyTextFormFieldWidget extends StatelessWidget {
  const MyTextFormFieldWidget({
    Key? key,
     this.controller,
    required this.type, this.hint, this.icon, this.validation, this.onSave, this.min, required this.color, required this.isPass, this.style,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType type;
  final String? hint;
  final Widget? icon;
  final String? Function(String?)? validation;
  final String? Function(String?)? onSave;
  final int? min;
  final Color color;
  final bool isPass;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      autofocus: false,
      cursorColor: color,
      validator: validation,
      obscureText: isPass,
      onSaved: onSave,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: style ?? const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontFamily: 'khebrat'),
        hoverColor: color,
        focusColor: color,
        fillColor: color,
        filled: true,
        suffixIcon: icon,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.transparent,width: 1.3)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color,width: 1.3)),
        //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.transparent,width: 1.3)),
        //prefixIcon: icon
      ),
    );
  }
}

