import 'dart:convert';

import 'package:antidote/models/therapist_model.dart';
import 'package:antidote/models/user_model.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:antidote/global.dart';
import 'bookappointmentprofile.dart';
import 'earningandsession.dart';
import 'notification.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double rating;
  TextEditingController note = TextEditingController();
  User userData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(FireStoreKeys.patientsCollection)
          .document(userEmail)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          userData = User.fromSnapshot(
            snapshot.data,
          );
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: SafeArea(
                    child: AppBar(
                      elevation: 1,
                      backgroundColor: Colors.white,
                      flexibleSpace: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Image(
                              image: AppImages.accountWithDollar,
                              height: 40,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EarningAndSession(),
                                ),
                              );
                            },
                          ),
                          Hero(
                            child: Image(
                              image: AppImages.logo,
                            ),
                            tag: 'antidote-logo',
                          ),
                          InkWell(
                            child: Image(
                              image: AppImages.notification,
                              height: 40,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationAntidote(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: AbsorbPointer(
                  child: _buildBody(context),
                  absorbing: isLoading,
                ),
              ),
              isLoading ? FullScreenLoader() : Container()
            ],
          );
        } else {
          return FullScreenLoader();
        }
      },
    );
  }

  _buildBody(context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: AutoSizeText(
                    "Welcome",
                    style: GoogleFonts.roboto(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  subtitle: AutoSizeText(
                    userData.name,
                    style:
                        GoogleFonts.roboto(color: AppColors.blue, fontSize: 18),
                  ),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width / 7,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(userData.photoUrl),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        width: double.infinity,
                        height: 32,
                        child: AutoSizeText(
                          "\t Quote",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        )),
                    FutureBuilder<http.Response>(
                        future: http.get(
                            'https://quote-garden.herokuapp.com/quotes/random'),
                        builder:
                            (context, AsyncSnapshot<http.Response> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: AutoSizeText(
                                jsonDecode(snapshot.data.body)['quoteText'],
                                style: GoogleFonts.roboto(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })
                  ],
                ),
              ),
              AutoSizeText(
                "\tMy Therapy",
                style: GoogleFonts.roboto(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(FireStoreKeys.therapistsCollection)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> therapistList =
                      snapshot.data.documents;
                  return Container(
                    height: 165,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: therapistList.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookAnAppointmentProfile(
                                    therapistData: Therapist.fromSnapshot(
                                      therapistList[index],
                                    ),
                                    userData: userData,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: therapistList[index]
                                                        .data['photoUrl'] ==
                                                    null
                                                ? AppImages.baldMan
                                                : NetworkImage(
                                                    therapistList[index]
                                                        .data['photoUrl'],
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 1,
                                        child: Image(
                                          image: AppImages.onlineStatus,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30,
                                        ),
                                      )
                                    ],
                                  ),
                                  SmoothStarRating(
                                    starCount: 5,
                                    size: 25,
                                    allowHalfRating: false,
                                    filledIconData: Icons.star,
                                    color: AppColors.blue,
                                    borderColor: AppColors.blue,
                                  ),
                                  AutoSizeText(
                                    therapistList[index].data['name'],
                                    style: GoogleFonts.roboto(
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  AutoSizeText(
                                    "Sleeping Disorder",
                                    style: GoogleFonts.roboto(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                "\tMy Diary",
                style: GoogleFonts.roboto(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: AppColors.blue,
                  size: 30,
                ),
                onPressed: () {
                  isLoading = true;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Add note",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold)),
                          content: new TextFormField(
                            controller: note,
                            keyboardType: TextInputType.text,
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Add",
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await Firestore.instance
                                    .collection('patients')
                                    .document(userData.email)
                                    .collection(FireStoreKeys.diaryCollection)
                                    .document('${DateTime.now()}')
                                    .setData(
                                  {
                                    "note": note.text,
                                    'Date': DateTime.now(),
                                  },
                                  merge: true,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                note.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('patients')
                .document(userData.email)
                .collection(FireStoreKeys.diaryCollection)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> diaryList = snapshot.data.documents;
                return Container(
                  height: 165,
                  width: 165,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: diaryList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            diaryList[index].data['note'],
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
