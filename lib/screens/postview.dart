import 'package:antidote/global.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
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
                  Spacer()
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          children: <Widget>[
                            Expanded(
                              child: CircleAvatar(
                                child: Image(image: AppImages.baldMan),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText("Harry Garrison",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 10)),
                            ),
                            Expanded(
                              child: AutoSizeText("Patient",
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey, fontSize: 10)),
                            )
                          ],
                        ),
                        title: AutoSizeText('How to maintain fitness level?',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.red),
                                  child: AutoSizeText(
                                    "\t\t\t\t\t2 replies\t\t\t\t\t",
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ),
                                AutoSizeText("10:30 am",
                                    style: GoogleFonts.roboto(fontSize: 10))
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText("\t\t\tReplies",
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: CircleAvatar(
                                      child: Image(image: AppImages.baldMan),
                                    ),
                                  ),
                                  Expanded(
                                    child: AutoSizeText("Harry Garrison",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black, fontSize: 10)),
                                  ),
                                  Expanded(
                                    child: AutoSizeText("Doctor",
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey, fontSize: 10)),
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
                                          style:
                                              GoogleFonts.roboto(fontSize: 10))
                                    ],
                                  ),
                                ],
                              ),
                            )),
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
