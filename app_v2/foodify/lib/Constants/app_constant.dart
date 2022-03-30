import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AppConstant {
  static List<String> _indian = [];
  static List<String> _veg = [];
  static List<String> _dinner = [];
  static List<String> _dessert = [];
  AppConstant._();
  static final AppConstant _appsData = AppConstant._();

  static AppConstant get instance => _appsData;

  List<String> get indian => _indian;
  List<String> get veg => _veg;
  List<String> get dinner => _dinner;
  List<String> get dessert => _dessert;

  Future<void> init() async {
    var res = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/imsudip/foodify/main/data/categoryId.json'));
    Map<String, dynamic> m = jsonDecode(res.body);
    log("Getting categories Data completed", name: "AppConstant");
    _indian = m['indian'].map<String>((e) => e.toString()).toList();
    _veg = m['veg'].map<String>((e) => e.toString()).toList();
    _dinner = m['dinner'].map<String>((e) => e.toString()).toList();
    _dessert = m['dessert'].map<String>((e) => e.toString()).toList();
  }

  static List<String> stringListAdapter(dynamic list) {
    return (list as List).map<String>((e) => e).toList();
  }
}
