import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_list/models/user_model.dart';

Future<List<UserModel>> getUsersFromAPI() async {
  var data =
      await http.get(Uri.parse("https://reqres.in/api/users?per_page=5"));

  var jsonData = json.decode(data.body);

//  NewsModel.fromJSON(jsonData["aritcal"]);

  return (jsonData['data'] as List).map((e) => UserModel.fromJSON(e)).toList();
}

// Future<Stream<List<UserModel>>> getUsersFromAPIStream() async {
//   try {
//     var streamData = http
//         .get(Uri.parse("https://reqres.in/api/users?per_page=5"))
//         .asStream();

//     return streamData.map((event) {
//       var jsonData = json.decode(event.body);

//       return (jsonData['articles'] as List)
//           .map((e) => UserModel.fromJSON(e))
//           .toList();
//     });
//   } catch (e) {
//     return Stream.value([]);
//   }
// }
