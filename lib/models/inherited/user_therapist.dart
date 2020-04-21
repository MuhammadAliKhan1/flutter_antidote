import 'package:flutter/widgets.dart';
import '../therapist_model.dart';
import '../user_model.dart';

class UTData extends InheritedWidget {
  User userData;
  Therapist therapistData;

  UTData({
    Key key,
    @required this.userData,
    @required this.therapistData,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(UTData oldWidget) =>
      userData != oldWidget.userData ||
      therapistData != oldWidget.therapistData;
  static UTData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UTData>();
  }
}
