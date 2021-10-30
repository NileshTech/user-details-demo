import 'package:flutter/material.dart';
import 'package:user_list/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:user_list/models/user_model.dart';

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
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("User Details"),
            ),
            body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (con, index) {
                  return Material(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [Colors.white, Colors.indigo]),
                                  border: Border.all(
                                    color: Colors.indigo,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data![index].firstName!),
                                    Text(snapshot.data![index].lastName!),
                                    Text(snapshot.data![index].email!),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Positioned(
                              top: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [Colors.white, Colors.indigo]),
                                    border: Border.all(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    snapshot.data![index].avatar!,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
