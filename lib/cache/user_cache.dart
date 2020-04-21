import 'package:antidote/helpers/shared_preferences.dart';
import 'package:antidote/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCache {
  User _user;
  SharedPreferencesHandler _prefHandle = SharedPreferencesHandler();
  String _email;
  User get user => _user;

  Future<User> getUser() async {
    _email = await _prefHandle.getValue('email');
    try {
      _user = User.fromSnapshot(await Firestore.instance
          .collection('patients')
          .document(_email)
          .get());
    } catch (e) {
      print(e);
    }
    return _user;
  }

  void clear() => _user = null;
}
