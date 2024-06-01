import 'package:flutter/material.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/User/userModel.dart' ;

class UserData with ChangeNotifier {
  UserDetail? _user;

  UserDetail get getUser => _user!;
Future<void>refreshUser() async{
  UserDetail user = await FirebaseServices().getUserDetails();
  _user = user;
  notifyListeners();
}


 
}
