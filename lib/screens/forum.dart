import 'package:antidote/global.dart';
import 'package:antidote/screens/postview.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.lightBlue, AppColors.darkBlue],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  )),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText("Forum",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                        AutoSizeText("Discuccion Area",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15))
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)),
                          title: Text("New Post",
                              style: GoogleFonts.roboto(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          content: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Title",
                                      style: GoogleFonts.roboto(
                                          color: AppColors.lightGrey,
                                          fontSize: 15)),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                  controller: title,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter the title';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Message",
                                      style: GoogleFonts.roboto(
                                          color: AppColors.lightGrey,
                                          fontSize: 15)),
                                ),
                                TextFormField(
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  controller: message,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter the Message';
                                    }
                                    return null;
                                  },
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: AutoSizeText("Post",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  color: AppColors.blue,
                                  onPressed: () {},
                                ),
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.roboto(
                                        color: AppColors.blue, fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostView()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                              child: ListTile(
                                leading: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AppImages.decentMan,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AutoSizeText("Harry Garrison",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 10)),
                                    ),
                                    Expanded(
                                      child: AutoSizeText("Patient",
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontSize: 10)),
                                    )
                                  ],
                                ),
                                title: AutoSizeText(
                                    'How to maintain fitness level?',
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                isThreeLine: true,
                                subtitle: Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                        "I have one question regarding fitness, how to maintain fitness level and how it’s possible to be...",
                                        maxLines: 3,
                                        style: GoogleFonts.roboto(
                                            color: Colors.black, fontSize: 12)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.red),
                                          child: AutoSizeText(
                                            "\t\t\t\t\t2 replies\t\t\t\t\t",
                                            maxLines: 1,
                                            style: GoogleFonts.roboto(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                        ),
                                        AutoSizeText("10:30 am",
                                            style: GoogleFonts.roboto(
                                                fontSize: 10))
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
