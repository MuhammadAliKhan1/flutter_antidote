import 'package:antidote/global.dart';
import 'package:antidote/widgets/shadebutton.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFilter extends StatefulWidget {
  @override
  _ProfileFilterState createState() => _ProfileFilterState();
}

class _ProfileFilterState extends State<ProfileFilter> {
  bool marriage_counselling = false;
  bool depression = false;
  bool disorder = false;
  bool anger_management = false;
  bool anxiety = false;
  bool test = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SafeArea(
              child: AppBar(
                leading: Container(),
                elevation: 1,
                backgroundColor: Colors.white,
                flexibleSpace: Row(
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.blue,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    Image(
                      image: AppImages.logo,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )),
        body: ListView(children: <Widget>[
          AutoSizeText("\tCategories",
              style: GoogleFonts.roboto(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ShadeButton(
                  buttonText: "Marriage Councelling",
                  buttonName: marriage_counselling,
                  width: 150,
                ),
                ShadeButton(
                  buttonName: depression,
                  buttonText: "Depression",
                  width: 100,
                ),
                ShadeButton(
                  buttonName: disorder,
                  buttonText: "Disorder",
                  width: 100,
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Spacer(),
                ShadeButton(
                  buttonName: anger_management,
                  buttonText: "Anger Management",
                  width: 140,
                ),
                Spacer(),
                ShadeButton(
                  buttonName: anxiety,
                  buttonText: "Anxiety",
                  width: 90,
                ),
                Spacer(
                  flex: 20,
                ),
              ]),
        ]));
  }
}
