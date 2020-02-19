import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../user_model.dart';

class UTData extends InheritedWidget {
  final User userData;
  final List<DocumentSnapshot> therapistList;

  UTData({
    Key key,
    @required this.userData,
    @required this.therapistList,
    @required Widget child,
  })  : assert(userData != null),
        assert(therapistList != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(UTData oldWidget) =>
      userData != oldWidget.userData ||
      therapistList.last != oldWidget.therapistList.last;
  static UTData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UTData>();
  }
}
