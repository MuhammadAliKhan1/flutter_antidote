import 'package:antidote/global.dart';
import 'package:antidote/helpers/shared_preferences.dart';
import 'package:antidote/models/user_model.dart';
import 'package:antidote/theme.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../global.dart';
import 'login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  String _photoName;
  bool _editProfile;
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _date = TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  var _selected;
  var selectedGender;
  var pinkRedGradient;
  int gender = -1;

  @override
  void initState() {
    super.initState();
    _editProfile = true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('patients')
            .document(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = User.fromSnapshot(
              snapshot.data,
            );
            _photoName = userData.photoName;
            return Stack(
              children: <Widget>[
                Scaffold(
                  body: AbsorbPointer(
                    child: _buildBody(
                      context,
                      userData,
                    ),
                    absorbing: isLoading,
                  ),
                ),
                isLoading ? FullScreenLoader() : Container()
              ],
            );
          } else
            return FullScreenLoader();
        });
  }

  SafeArea _buildBody(BuildContext context, snapshot) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: <Widget>[
              Column(
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.offWhite,
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.lerp(
                    Alignment.topCenter, Alignment.bottomCenter, 0.4),
                child: Container(
                  width: MediaQuery.of(context).size.width - 70,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 5,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Column(children: <Widget>[
                                Spacer(
                                  flex: 3,
                                ),
                                AutoSizeText(snapshot.name,
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                        color: AppColors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                InkWell(
                                  child: Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height / 25,
                                    child: Center(
                                      child: Text(
                                          _editProfile
                                              ? "Edit Profile"
                                              : "Save",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)),
                                      color: _editProfile
                                          ? AppColors.hardblue
                                          : Colors.green,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _editProfile = !_editProfile;
                                    });
                                  },
                                )
                              ]),
                            ),
                          ),
                          Divider(),
                          Flexible(
                            flex: 2,
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: AutoSizeText("Mobile Number",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        _editProfile
                                            ? AutoSizeText("+851 9885 0994",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color:
                                                        AppColors.normalGrey))
                                            : Expanded(
                                                child: Container(
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: _mobileNumber,
                                                    decoration: InputDecoration(
                                                        focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .darkBlue)),
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .darkBlue))),
                                                  ),
                                                  height: 25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: AutoSizeText("Email ID",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        _editProfile
                                            ? AutoSizeText(snapshot.email,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: AppColors.normalGrey,
                                                ))
                                            : Container(
                                                child: TextField(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  controller: _email,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .darkBlue)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .darkBlue)),
                                                  ),
                                                ),
                                                height: 25,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    155,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        AutoSizeText('Gender',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        _editProfile
                                            ? AutoSizeText("Male",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color:
                                                        AppColors.normalGrey))
                                            : Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: <Widget>[
                                                  new Radio(
                                                    value: 0,
                                                    groupValue: gender,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        gender = value;
                                                      });
                                                    },
                                                    activeColor:
                                                        AppColors.darkBlue,
                                                  ),
                                                  AutoSizeText("Male"),
                                                  new Radio(
                                                    value: 1,
                                                    groupValue: gender,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        gender = value;
                                                      });
                                                    },
                                                    activeColor:
                                                        AppColors.darkBlue,
                                                  ),
                                                  AutoSizeText("Female"),
                                                  
                                                ],
                                              ),
                                              height: 25,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width / 2,
                                            ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: AutoSizeText("Date Of Birth",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        _editProfile
                                            ? AutoSizeText("Jan 12 2020",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color:
                                                        AppColors.normalGrey))
                                            : Expanded(
                                                child: Container(
                                                  child: GestureDetector(
                                                    child: AbsorbPointer(
                                                      child: TextField(
                                                        controller: _date,
                                                        decoration: InputDecoration(
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .darkBlue)),
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .darkBlue))),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      DatePicker.showDatePicker(
                                                          context,
                                                          showTitleActions:
                                                              true,
                                                          minTime: DateTime(
                                                              1900, 0, 0),
                                                          maxTime: DateTime(
                                                              2019, 12, 30),
                                                          theme: DatePickerTheme(
                                                              headerColor: theme
                                                                  .primaryColor,
                                                              backgroundColor: theme
                                                                  .primaryColor,
                                                              itemStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 18),
                                                              doneStyle: TextStyle(color: Colors.white, fontSize: 16)), onChanged: (date) {
                                                        print('change $date in time zone ' +
                                                            date.timeZoneOffset
                                                                .inHours
                                                                .toString());
                                                      }, onConfirm: (date) {
                                                        setState(() {
                                                          _date.text = format
                                                              .format(date);

                                                          print('date.value' +
                                                              _date.toString());

                                                          print('local time: ' +
                                                              date.toString());
                                                        });
                                                        print('confirm $date');
                                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                                    },
                                                  ),
                                                  height: 25,
                                                  width: 200,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      AutoSizeText("Location",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      _editProfile
                                          ? AutoSizeText("USA",
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: AppColors.normalGrey,
                                              ))
                                          : CountryPicker(
                                              dense: false,
                                              showFlag:
                                                  false, //displays flag, true by default
                                              showDialingCode:
                                                  false, //displays dialing code, false by default
                                              showName:
                                                  true, //displays country name, true by default
                                              showCurrency:
                                                  false, //eg. 'British pound'
                                              showCurrencyISO:
                                                  false, //eg. 'GBP'\

                                              onChanged: (Country country) {
                                                setState(() {
                                                  _selected = country;
                                                });
                                              },
                                              selectedCountry: _selected,
                                            ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      isLoading = true;
                                      if (LoginStatus.fLoginStatus) {
                                        LoginStatus.fLoginStatus =
                                            !LoginStatus.fLoginStatus;
                                        googleLogin.signOut();
                                      }
                                      if (LoginStatus.gLoginStatus) {
                                        LoginStatus.gLoginStatus =
                                            !LoginStatus.gLoginStatus;
                                        facebookLogin.logOut();
                                      }
                                      isLoading = false;
                                      prefHandle.clearPreferences();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        AutoSizeText(
                                          "Logout",
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: AppColors.hardRed,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 3.2,
                              child: Image.network(
                                snapshot.photoUrl,
                                fit: BoxFit.fill,
                              ),
                            )),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Make a choice!",
                                      style: GoogleFonts.roboto(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Container(
                                      child: Column(children: <Widget>[
                                        Align(
                                          child: InkWell(
                                            child: AutoSizeText(
                                              "Select Picture",
                                              style: GoogleFonts.roboto(
                                                fontSize: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              getImageFromGallery(context);
                                            },
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Align(
                                          child: InkWell(
                                            child: AutoSizeText(
                                              "Take Picture",
                                              style: GoogleFonts.roboto(
                                                fontSize: 20,
                                              ),
                                            ),
                                            onTap: () {
                                              getImageFromCamera(context);
                                            },
                                          ),
                                          alignment: Alignment.centerLeft,
                                        )
                                      ]),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                  );
                                });
                          },
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImageFromGallery(BuildContext context) async {
    try {
      SharedPreferencesHandler _prefHandle = SharedPreferencesHandler();
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _image = image;
      if (_image != null) {
        String fileName = basename(_image.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child(fileName);
        setState(() {
          isLoading = true;
        });
        String _email = await _prefHandle.getValue('email');
        _photoName = await Firestore.instance
            .collection(FireStoreKeys.patientsCollection)
            .document(_email)
            .get()
            .then((doc) => doc['photoName']);
        if (_photoName != null)
          await FirebaseStorage.instance.ref().child(_photoName).delete();
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        String photoUrl = await firebaseStorageRef.getDownloadURL();
        await Firestore.instance
            .collection(FireStoreKeys.patientsCollection)
            .document(_email)
            .updateData({
          'photoUrl': photoUrl,
          'photoName': fileName,
        });
        setState(() {
          isLoading = false;
        });
      }
    } catch (ex) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Oops!",
        desc: "An error has occurred",
        buttons: [
          DialogButton(
            child: Text("DISMISS",
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    )),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ).show();
    } finally {
      setState(
        () => isLoading = false,
      );
    }
  }

  Future getImageFromCamera(BuildContext context) async {
    try {
      SharedPreferencesHandler _prefHandle = SharedPreferencesHandler();
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      _image = image;
      if (_image != null) {
        String fileName = basename(_image.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child(fileName);
        setState(() {
          isLoading = true;
        });
        String _email = await _prefHandle.getValue('email');
        _photoName = await Firestore.instance
            .collection(FireStoreKeys.patientsCollection)
            .document(_email)
            .get()
            .then((doc) => doc['photoName']);
        if (_photoName != null)
          await FirebaseStorage.instance.ref().child(_photoName).delete();
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        String photoUrl = await firebaseStorageRef.getDownloadURL();
        await Firestore.instance
            .collection('patients')
            .document(_email)
            .updateData({
          'photoUrl': photoUrl,
          'photoName': fileName,
        });
        setState(() {
          isLoading = false;
        });
      }
    } catch (ex) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Oops!",
        desc: "An error has occurred",
        buttons: [
          DialogButton(
            child: Text("DISMISS",
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    )),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ).show();
    } finally {
      setState(
        () => isLoading = false,
      );
    }
  }
}
