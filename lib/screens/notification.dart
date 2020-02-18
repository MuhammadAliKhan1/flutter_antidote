import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antidote/global.dart';

class NotificationAntidote extends StatefulWidget {
  @override
  _NotificationAntidoteState createState() => _NotificationAntidoteState();
}

class _NotificationAntidoteState extends State<NotificationAntidote> {
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
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: <Widget>[
                InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Spacer(),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText("Notification",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      AutoSizeText("You have 2 new notifications",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  ),
                ),
                Spacer(),
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
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: AutoSizeText('Booking Appointment',
                                maxLines: 1,
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            isThreeLine: true,
                            subtitle: AutoSizeText(
                                "Your Appointment with Harry Garrson is successful.",
                                maxLines: 2,
                                style: GoogleFonts.roboto(
                                    color: AppColors.deepGrey, fontSize: 15)),
                            trailing: Column(
                              children: <Widget>[
                                Spacer(),
                                AutoSizeText("10:30 am",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        color: AppColors.normalGrey)),
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
    ));
  }
}
