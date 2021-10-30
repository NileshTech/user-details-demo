import 'package:flutter/material.dart';
import 'package:user_list/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:user_list/models/user_model.dart';
import 'package:user_list/views/user_details_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  final UserController _userController = UserController();

  _HomePageState() : super(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: _userController.getTodayUserAsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "User Details",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (con, index) {
                  return UserDetailsWidget(
                    userFirstName: snapshot.data![index].firstName,
                    userLastName: snapshot.data![index].lastName,
                    userEmailId: snapshot.data![index].email,
                    userAvatar: snapshot.data![index].avatar,
                  );
                }),
          );
        });
  }
}
