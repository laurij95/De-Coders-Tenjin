import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/authenticate.dart';
import 'package:tenjin/teacher/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }



}
