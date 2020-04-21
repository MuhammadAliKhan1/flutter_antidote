import 'package:flutter/material.dart';
import 'package:antidote/global.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText("Messages",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  AutoSizeText(
                    "You have 4 new messages",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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
                    physics: BouncingScrollPhysics(),
                    controller: ScrollController(),
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: Stack(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AppImages.baldMan,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    right: 0,
                                    child: Image(
                                      image: AppImages.onlineStatus,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      width: MediaQuery.of(context).size.width /
                                          30,
                                    ),
                                  )
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AutoSizeText('Harry Garison',
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  AutoSizeText(
                                    "10:30 am",
                                    style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      color: AppColors.normalGrey,
                                    ),
                                  )
                                ],
                              ),
                              isThreeLine: true,
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AutoSizeText("Hi Doctor!",
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                          color: AppColors.deepGrey,
                                          fontSize: 13)),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: AppColors.blue),
                                    child: AutoSizeText(
                                      "\t\t\t\t2\t\t\t\t",
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
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
