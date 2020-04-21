import 'dart:async';

import 'package:antidote/global.dart';
import 'package:antidote/models/therapist_model.dart';
import 'package:flutter/material.dart';

class VoiceCallPage extends StatefulWidget {
  final Therapist therapistData;

  const VoiceCallPage({
    Key key,
    @required this.therapistData,
  }) : super(key: key);
  @override
  _VoiceCallPageState createState() => _VoiceCallPageState(
        therapistData: therapistData,
      );
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  Timer _timmerInstance;
  int _start = 0;
  String _timmer = '';
  final Therapist therapistData;
  _VoiceCallPageState({
    @required this.therapistData,
  });
  Future<void> startTimmer() async {
    var oneSec = Duration(seconds: 1);
    _timmerInstance = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 0) {
            _timmerInstance.cancel();
          } else {
            _start = _start + 1;
            _timmer = getTimerTime(_start);
          }
        },
      ),
    );
    /*   await FlutterTwilioVoice.makeCall(
      to: '+447563086342',
      accessTokenUrl:
          'https://flutter-antidote-voice.herokuapp.com/accessToken',
      toDisplayName: therapistData.name, from: null,
    ); */
  }

  String getTimerTime(int start) {
    int minutes = (start ~/ 60);
    String sMinute = '';
    if (minutes.toString().length == 1) {
      sMinute = '0' + minutes.toString();
    } else
      sMinute = minutes.toString();

    int seconds = (start % 60);
    String sSeconds = '';
    if (seconds.toString().length == 1) {
      sSeconds = '0' + seconds.toString();
    } else
      sSeconds = seconds.toString();

    return sMinute + ':' + sSeconds;
  }

  @override
  void initState() {
    super.initState();
    startTimmer();
  }

  @override
  void dispose() {
    _timmerInstance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.only(
            bottom: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'VOICE CALL',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      'Ali',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    Text(
                      _timmer,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: Image(
                  height: 200,
                  width: 200,
                  image: AppImages.baldMan,
                ),
              ),
              /*  Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FunctionalButton(
                    title: 'Speaker',
                    icon: Icons.phone_in_talk,
                    onPressed: () {},
                  ),
                  FunctionalButton(
                    title: 'Video Call',
                    icon: Icons.videocam,
                    onPressed: () {},
                  ),
                  FunctionalButton(
                    title: 'Mute',
                    icon: Icons.mic_off,
                    onPressed: () {},
                  ),
                ],
              ), */
              /* FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 20.0,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.red,
                  ),
                ),
                mini: false,
                child: Icon(
                  Icons.call_end,
                  color: Colors.red,
                ),
                backgroundColor: Colors.red[100],
              ) */
            ],
          ),
        ),
      ),
    );
  }
}

class FunctionalButton extends StatefulWidget {
  final title;
  final icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Theme.of(context).accentColor,
          fillColor: Colors.white,
          elevation: 10.0,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              widget.icon,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 2.0,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
