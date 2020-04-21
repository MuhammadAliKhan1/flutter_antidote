import 'package:antidote/global.dart';
import 'package:antidote/models/inherited/user_therapist.dart';
import 'package:antidote/models/therapist_model.dart';
import 'package:antidote/models/user_model.dart';
import 'package:antidote/screens/chat_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './bookAnAppointment.dart';
import 'call.dart';

class BookAnAppointmentProfile extends StatefulWidget {
  final Therapist therapistData;
  final User userData;

  const BookAnAppointmentProfile({
    Key key,
    @required this.therapistData,
    @required this.userData,
  }) : super(key: key);
  @override
  _BookAnAppointmentProfileState createState() =>
      _BookAnAppointmentProfileState();
}

class _BookAnAppointmentProfileState extends State<BookAnAppointmentProfile> {
  _BookAnAppointmentProfileState();
  @override
  Widget build(BuildContext context) {
    final UTData inheritedData = UTData.of(context);
    inheritedData.userData = widget.userData;
    inheritedData.therapistData = widget.therapistData;
    return BookAppointmentWidget(
      rating: 4.5,
    );
  }
}

class BookAppointmentWidget extends StatelessWidget {
  final double rating;

  BookAppointmentWidget({
    Key key,
    @required this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UTData inheritedData = UTData.of(context);
    print(inheritedData.userData.email);
    print(inheritedData.therapistData.email);
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
                    colors: [
                      AppColors.lightBlue,
                      AppColors.darkBlue,
                    ],
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
                  Stack(
                    children: <Widget>[
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
                              image:
                                  inheritedData.therapistData.photoUrl == null
                                      ? AppImages.baldMan
                                      : NetworkImage(
                                          inheritedData.therapistData.photoUrl,
                                        ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 1,
                        child: Image(
                          image: AppImages.onlineStatus,
                          height: MediaQuery.of(context).size.height / 23,
                          width: MediaQuery.of(context).size.width / 23,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  AutoSizeText(inheritedData.therapistData.name,
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                      Widget>[
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookAnAppointment()));
                      },
                      child: Stack(
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
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                      },
                      child: Stack(
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
                              height: MediaQuery.of(context).size.height / 25,
                              width: MediaQuery.of(context).size.height / 25,
                            ),
                          ),
                        ],
                      ),
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
                          child: InkWell(
                            onTap: () async {
                              // await for camera and mic permissions before pushing video page
                              await _handleCameraAndMic();
                              DocumentSnapshot data = await Firestore.instance
                                  .collection(
                                      FireStoreKeys.therapistsCollection)
                                  .document(
                                      inheritedData.therapistData.mobileNumber)
                                  .get();
                              Therapist therapistData =
                                  Therapist.fromSnapshot(data);
                              if (data['call'] == null) {
                                await Firestore.instance
                                    .collection(
                                        FireStoreKeys.therapistsCollection)
                                    .document(inheritedData
                                        .therapistData.mobileNumber)
                                    .setData({
                                  'call': {
                                    'user': inheritedData.userData.email,
                                    'isVoiceCall': true
                                  }
                                }, merge: true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CallPage(
                                      channelName:
                                          '${inheritedData.therapistData.mobileNumber}THISISAHIGHLYENCRYTEDTEXTTOPREVENTCHANNELSCOLLISION :)',
                                      isVoiceCall: true,
                                      therapistData:
                                          inheritedData.therapistData,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Image(
                              image: AppImages.phoneIcon,
                              height: MediaQuery.of(context).size.height / 25,
                              width: MediaQuery.of(context).size.height / 25,
                            ),
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
                          child: InkWell(
                            onTap: () async {
                              // await for camera and mic permissions before pushing video page
                              await _handleCameraAndMic();
                              DocumentSnapshot data = await Firestore.instance
                                  .collection(
                                      FireStoreKeys.therapistsCollection)
                                  .document(
                                      inheritedData.therapistData.mobileNumber)
                                  .get();
                              Therapist therapistData =
                                  Therapist.fromSnapshot(data);
                              if (data['call'] == null) {
                                await Firestore.instance
                                    .collection(
                                        FireStoreKeys.therapistsCollection)
                                    .document(inheritedData
                                        .therapistData.mobileNumber)
                                    .setData({
                                  'call': {
                                    'user': inheritedData.userData.email,
                                    'isVoiceCall': false
                                  }
                                }, merge: true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CallPage(
                                      channelName:
                                          '${inheritedData.therapistData.mobileNumber}THISISAHIGHLYENCRYTEDTEXTTOPREVENTCHANNELSCOLLISION :)',
                                      isVoiceCall: false,
                                      therapistData:
                                          inheritedData.therapistData,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Image(
                              image: AppImages.videoSymbol,
                              height: MediaQuery.of(context).size.height / 25,
                              width: MediaQuery.of(context).size.height / 25,
                            ),
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
            "\tReviews",
            style: GoogleFonts.roboto(
                color: AppColors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
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
                    leading: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AppImages.baldMan,
                            ))),
                    title: AutoSizeText('Victoria Helena',
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    isThreeLine: true,
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              size: 15,
                              allowHalfRating: true,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              color: AppColors.seaGreen,
                              rating: rating,
                              borderColor: AppColors.dullWhite,
                            ),
                            AutoSizeText("4.5",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))
                          ],
                        ),
                        AutoSizeText(
                            "Wow! I didn’t know that there is such issue with me because of depression, But she helped me and i feels better.",
                            maxLines: 3,
                            style: GoogleFonts.roboto(
                                color: AppColors.deepGrey, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    ));
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
