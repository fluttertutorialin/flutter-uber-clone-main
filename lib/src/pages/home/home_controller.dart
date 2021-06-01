import 'package:flutter/material.dart';
import 'package:clone_uber_app/src/utils/shared_pref.dart';
import 'package:clone_uber_app/src/providers/auth_provider.dart';

class HomeController {

  BuildContext context;
  SharedPref _sharedPref;

  AuthProvider _authProvider;
  String _typeUser;
  String _isNotification;

  Future init(BuildContext context) async {
    this.context = context;
    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();

    _typeUser = await _sharedPref.read('typeUser');
    _isNotification = await _sharedPref.read('isNotification');
    checkIfUserIsAuth();
  }

  void checkIfUserIsAuth() {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {

      if(_isNotification != true) {

        if (_typeUser == 'client') {
          Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
          //Navigator.pushNamed(context, 'client/map');
        }
        else {
          Navigator.pushNamedAndRemoveUntil(context, 'driver/map', (route) => false);
          //Navigator.pushNamed(context, 'driver/map');
        }

      }


    }
    else {
      print('NO ESTA LOGEADO');
    }
  }

  void goToLoginPage(String typeUser) {
    saveTypeUser(typeUser);
    Navigator.pushNamed(context, 'login');
  }

  void saveTypeUser(String typeUser) async {
    await _sharedPref.save('typeUser', typeUser);
  }

}