/* import 'dart:async';

import 'package:antidote/models/therapist_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class IndexPage extends StatefulWidget {
  final bool isVoiceCall;
  final Therapist therapistData;

  const IndexPage({
    Key key,
    @required this.isVoiceCall,
    @required this.therapistData,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => IndexState(
        isVoiceCall: isVoiceCall,
      );
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();
  final bool isVoiceCall;

  /// if channel textField is validated to have error
  bool _validateError = false;

  IndexState({
    @required this.isVoiceCall,
  });

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: onJoin,
                        child: Text('Join'),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => 
        ),
      );
    }
  }

 
}
 */