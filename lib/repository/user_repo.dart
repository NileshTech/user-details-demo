import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_list/models/user_model.dart';

Future<List<UserModel>> getUsersFromAPI(int? pageCount, int? perPage) async {
  var data = await http.get(Uri.parse(
      "https://reqres.in/api/users?page=${pageCount!}?​per_page=${perPage!}"));

  var jsonData = json.decode(data.body);

//  NewsModel.fromJSON(jsonData["aritcal"]);

  return (jsonData['data'] as List).map((e) => UserModel.fromJSON(e)).toList();
}
