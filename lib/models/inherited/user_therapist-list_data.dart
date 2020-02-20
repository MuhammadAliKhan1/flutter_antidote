import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../user_model.dart';

class UTListData extends InheritedWidget {
  User userData = User();
  List<DocumentSnapshot> therapistList = <DocumentSnapshot>[];

  UTListData({
    Key key,
    @required this.userData,
    @required this.therapistList,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(UTListData oldWidget) =>
      userData != oldWidget.userData ||
      therapistList.last != oldWidget.therapistList.last;
  static UTListData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UTListData>();
  }
}
