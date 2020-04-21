import 'package:antidote/global.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BookAnAppointment extends StatefulWidget {
  @override
  _BookAnAppointmentState createState() => _BookAnAppointmentState();
}

class _BookAnAppointmentState extends State<BookAnAppointment> {
  double rating = 4.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Spacer(),
                  Row(
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
                        child: AutoSizeText("Book Appointment",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AppImages.baldMan,
                            ))),
                  ),
                  AutoSizeText("Thp. Dikhsa Sen",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SmoothStarRating(
                    starCount: 5,
                    size: 25,
                    allowHalfRating: false,
                    filledIconData: Icons.star,
                    color: AppColors.seaGreen,
                    rating: rating,
                    borderColor: AppColors.dullWhite,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Image(
                                image: AppImages.calendarIcon,
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.height / 25,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Image(
                                image: AppImages.instant_message,
                                color: AppColors.darkBlue,
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.height / 25,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Image(
                                image: AppImages.phoneIcon,
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.height / 25,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Image(
                                image: AppImages.videoSymbol,
                                height: MediaQuery.of(context).size.height / 25,
                                width: MediaQuery.of(context).size.height / 25,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ]),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            "\tYour Booking",
            style: GoogleFonts.roboto(
                color: AppColors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: CalendarCarousel(
            selectedDateTime: DateTime(2020, 2, 12),
            selectedDayButtonColor: AppColors.skyBlue,
            weekendTextStyle: TextStyle(
              color: Colors.black,
            ),
            weekdayTextStyle: TextStyle(
              color: Colors.black,
            ),
            headerTextStyle: TextStyle(
                color: AppColors.skyBlue,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            headerMargin: EdgeInsets.symmetric(horizontal: 80),
            leftButtonIcon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.skyBlue,
              size: 20,
            ),
            rightButtonIcon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.skyBlue,
              size: 20,
            ),
            todayButtonColor: AppColors.skyBlue,
          ),
        ),
      ]),
    ));
  }
}
