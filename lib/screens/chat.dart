import 'package:antidote/models/user_model.dart';
import 'package:antidote/screens/chat_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TypedMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SafeArea(
              child: AppBar(
                leading: Container(),
                elevation: 1,
                backgroundColor: Colors.white,
                flexibleSpace: Align(
                  alignment: Alignment.center,
                  child: Row(
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
                      Column(
                        children: <Widget>[
                          AutoSizeText(
                            "Dikhsha Sen",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Image(
                                image: AppImages.onlineStatus,
                                height: MediaQuery.of(context).size.height / 35,
                                width: MediaQuery.of(context).size.width / 35,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              AutoSizeText(
                                "online",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                Widget>[
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              "Today 10:30",
              style: GoogleFonts.roboto(
                color: AppColors.normalGrey,
                fontSize: 15,
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top / 3.5),
              child: Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.blue,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        "Wow! I didn’t know that there is such issue with me because of depression, But she helped me and i feels better.",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        child: AutoSizeText(
                          "10:30 am",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ]),
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ClipOval(
                  child: Image(
                image: AppImages.baldMan,
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 5,
              )),
              Align(
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: AppColors.slightOffWhite,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        AutoSizeText(
                          "Wow! I didn’t know that there is such issue with me because of depression, But she helped me and i feels better.",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Align(
                          child: AutoSizeText(
                            "10:30 am\t",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ]),
                ),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top / 3.5),
              child: Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.slightOffWhite,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        "Wow! I didn’t know that there is such issue with me because of depression, But she helped me and i feels better.",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        child: AutoSizeText(
                          "10:30 am\t",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ]),
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top / 3.5),
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.blue,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        "Ok, Thank you very doctor.",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        child: AutoSizeText(
                          "10:30 am",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ]),
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top / 3.5),
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.blue,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        "Ok, Thank you very doctor.",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        child: AutoSizeText(
                          "10:30 am",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ]),
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: AppColors.White,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image(
                    image: AppImages.typing,
                    height: MediaQuery.of(context).size.height / 28,
                    width: MediaQuery.of(context).size.width / 28,
                  ),
                  Image(
                    image: AppImages.typing,
                    height: MediaQuery.of(context).size.height / 28,
                    width: MediaQuery.of(context).size.width / 28,
                  ),
                  Image(
                    image: AppImages.typing,
                    height: MediaQuery.of(context).size.height / 28,
                    width: MediaQuery.of(context).size.width / 28,
                  )
                ]),
          ),
          Row(children: <Widget>[
            InkWell(
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: AppColors.slightGrey,
                ),
                onTap: () {
                  //TODO: ADD NAVIGATION
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChatScreen(
                      ),
                    ),
                  );
                }),
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width - 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Typing Message',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 13,
                  ),
                  filled: true,
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
                  suffixIcon: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.normalGrey,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/icon_phone.png'),
                        height: 25,
                      ),
                    ),
                  ),
                ),
                controller: TypedMessage,
              ),
            ),
          ]),
        ]));
  }
}
