import 'package:flutter/material.dart';

import 'package:user_list/models/user_model.dart';
import 'package:user_list/repository/user_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:user_list/models/user_model.dart';

class UserController extends ControllerMVC {
  List<UserModel> userModelList = [];

  var globalkey = GlobalKey<ScaffoldState>();

  UserController() {
    //getTodayNews();
  }

  getTodayUser() async {
    try {
      userModelList = await getUsersFromAPI();
      setState(() {});
    } catch (e) {
      globalkey.currentState!.showSnackBar(
          SnackBar(content: Text("failed due to " + e.toString())));
    }
  }

  Future<List<UserModel>> getTodayUserAsStream() async {
    List<UserModel> dataStream = await getUsersFromAPI();
    return dataStream;
  }
}
