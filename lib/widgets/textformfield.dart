import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class AntidoteTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final AssetImage icon;
  final String hintText;
  final Function validatorFunction;
  AntidoteTextFormField({
    this.controller,
    this.icon,
    this.hintText,
    this.validatorFunction,
  });
  @override
  _AntidoteTextFormFieldState createState() => _AntidoteTextFormFieldState();
}

class _AntidoteTextFormFieldState extends State<AntidoteTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validatorFunction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(
          fontSize: 13,
          color: theme.accentColor,
        ),
        filled: true,
        fillColor: theme.accentColor.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
            bottomLeft: Radius.circular(50.0),
            topLeft: Radius.circular(50.0),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
            bottomLeft: Radius.circular(50.0),
            topLeft: Radius.circular(50.0),
          ),
        ),
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 10),
          width: 60,
          decoration: BoxDecoration(
            color: theme.accentColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              topLeft: Radius.circular(50.0),
              bottomRight: Radius.zero,
              topRight: Radius.zero,
            ),
          ),
          child: Center(
            child: Image(
              image: widget.icon,
              height: 25,
            ),
          ),
        ),
      ),
    );
  }
}
