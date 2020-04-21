import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShadeButton extends StatefulWidget {
  ShadeButton({this.buttonName, this.buttonText, this.width});
  final String buttonText;
  var buttonName;
  final double width;

  @override
  _ShadeButtonState createState() => _ShadeButtonState();
}

class _ShadeButtonState extends State<ShadeButton> {
  void action() {
    setState(() {
      widget.buttonName = !widget.buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: action,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: widget.buttonName
            ? BorderSide(color: AppColors.blue)
            : BorderSide(color: AppColors.blue),
      ),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.buttonName ? AppColors.lightBlue : Colors.white,
                widget.buttonName ? AppColors.darkBlue : Colors.white
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.width, minHeight: 35.0),
          alignment: Alignment.center,
          child: AutoSizeText(widget.buttonText,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: widget.buttonName
                  ? GoogleFonts.roboto(color: Colors.white)
                  : GoogleFonts.roboto(color: AppColors.blue)),
        ),
      ),
    );
  }
}
