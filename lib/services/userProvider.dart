import 'package:flutter/foundation.dart';

class User with ChangeNotifier, DiagnosticableTreeMixin {
  Map<dynamic, String> _user = {
    'firstName': '',
    'id': '',
  };

  Map<dynamic, String> get user => _user;

  void updateUser(String firstName, String id) {
    _user = {'firstName': firstName, 'id': id};
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('user', user));
  }
}
