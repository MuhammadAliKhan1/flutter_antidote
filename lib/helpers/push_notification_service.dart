import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final String serverToken =
      'AAAAvz8zQ5E:APA91bHbk3T2W3sFgCCLhMMUuSDDnsD9aUYJDTJB2nACldt9s8QzrkIH9kYEx7fH0yYIlueVSe6EWA-MCYNX_e_Z9S45zoHnEVNRWOrgko6jB8TmzpkHs6l9bfUuTBu45p8dp94cyYK1';
  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
    _fcm.subscribeToTopic('testtopic');
  }

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _fcm.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': 'testtopic',
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }
}
