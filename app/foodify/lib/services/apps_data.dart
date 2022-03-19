import 'dart:convert';

import 'package:http/http.dart' as http;

class AppsData {
  AppsData._();

  static final AppsData _appsData = AppsData._();

  static AppsData get instance => _appsData;
  static const String url =
      'https://raw.githubusercontent.com/imsudip/foodify/main/data/recipes_withid.json';

  Future<void> init() async {
    await _loadData();
  }

  late Map<String, String> _data;
  Map<String, String> get recipeMap => _data;

  late List<String> _recipes;
  List<String> get recipes => _recipes;

  String getIdFromName(String name) {
    return _data[name] ?? '';
  }

  Future<void> _loadData() async {
    // create a get request to url and get the data
    await http.get(Uri.parse(url)).then((response) {
      // decode the json data
      var jsonData = json.decode(response.body);
      // convert the json data to map
      _data = Map<String, String>.from(jsonData);
      // get the recipes
      _recipes = _data.keys.toList();
    }).catchError((error) {
      print(error);
    });
  }
}
