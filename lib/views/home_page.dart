import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:user_list/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:user_list/models/user_model.dart';
import 'package:user_list/views/user_details_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  final UserController _userController = UserController();
  ScrollController scrollController = ScrollController();
  _HomePageState() : super(UserController());
  List<List<UserModel>?>? items;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool? loading, allLoaded;
  int? pageNo = 1;
  int? loadingItems = 5;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items!.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _userController.getTodayUserAsStream(pageNo, loadingItems);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future<List<UserModel>> manageDataLoader(
      int? pageNo, int? loadingItems) async {
    return await _userController.getTodayUserAsStream(pageNo, loadingItems);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: manageDataLoader(pageNo, loadingItems),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }
          int? itemCountPerPage = snapshot.data!.length;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "User Details",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: itemCountPerPage,
                  itemBuilder: (con, index) {
                    scrollController.addListener(() {
                      if (scrollController.position.pixels ==
                          scrollController.position.maxScrollExtent) {
                        setState(() {
                          itemCountPerPage = 10;
                          pageNo = 2;
                          loadingItems = 5;
                        });
                      } else {
                        setState(() {
                          itemCountPerPage = snapshot.data!.length;
                          pageNo = 1;
                          loadingItems = 5;
                        });
                      }
                    });
                    return UserDetailsWidget(
                      userFirstName: snapshot.data![index].firstName,
                      userLastName: snapshot.data![index].lastName,
                      userEmailId: snapshot.data![index].email,
                      userAvatar: snapshot.data![index].avatar,
                    );
                  }),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
            ),
          );
        });
  }
}
