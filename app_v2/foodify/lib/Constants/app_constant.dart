import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AppConstant {
  static List<String> _indian = [];
  static List<String> _veg = [];
  static List<String> _dinner = [];
  static List<String> _dessert = [];
  static List<String> _appetizers = [];
  static List<String> _chicken = [];
  static List<String> _eggless = [];
  static List<String> _healthy = [];
  static List<String> _chinese = [];
  static List<String> _paneer = [];
  static List<String> _pastaNoodles = [];
  static List<String> _seafood = [];
  static List<String> _sideDish = [];
  static List<String> _soup = [];
  static List<Map<String, dynamic>> _ingredientsWithImages = [];
  AppConstant._();
  static final AppConstant _appsData = AppConstant._();

  static AppConstant get instance => _appsData;

  List<String> get indian => _indian;
  List<String> get veg => _veg;
  List<String> get dinner => _dinner;
  List<String> get dessert => _dessert;
  List<String> get appetizers => _appetizers;
  List<String> get chicken => _chicken;
  List<String> get eggless => _eggless;
  List<String> get healthy => _healthy;
  List<String> get chinese => _chinese;
  List<String> get paneer => _paneer;
  List<String> get pastaNoodles => _pastaNoodles;
  List<String> get seafood => _seafood;
  List<String> get sideDish => _sideDish;
  List<String> get soup => _soup;
  List<Map<String, dynamic>> get ingredientsWithImages =>
      _ingredientsWithImages;

  Future<void> init() async {
    var res = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/imsudip/foodify/main/data/categoryId.json'));
    var res1 = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/imsudip/foodify/main/data/ingredients_with_images_dict.json'));
    Map<String, dynamic> m = jsonDecode(res.body);
    var m1 = jsonDecode(res1.body);

    log("Getting categories Data completed", name: "AppConstant");
    _indian = m['indian'].map<String>((e) => e.toString()).toList();
    _veg = m['veg'].map<String>((e) => e.toString()).toList();
    _dinner = m['dinner'].map<String>((e) => e.toString()).toList();
    _dessert = m['dessert'].map<String>((e) => e.toString()).toList();
    _appetizers = m['appetizers'].map<String>((e) => e.toString()).toList();
    _chicken = m['chicken'].map<String>((e) => e.toString()).toList();
    _eggless = m['eggless'].map<String>((e) => e.toString()).toList();
    _healthy = m['healthy'].map<String>((e) => e.toString()).toList();
    _chinese = m['chinese'].map<String>((e) => e.toString()).toList();
    _paneer = m['paneer'].map<String>((e) => e.toString()).toList();
    _pastaNoodles = m['pastaNoodles'].map<String>((e) => e.toString()).toList();
    _seafood = m['seafood'].map<String>((e) => e.toString()).toList();
    _sideDish = m['sideDish'].map<String>((e) => e.toString()).toList();
    _soup = m['soup'].map<String>((e) => e.toString()).toList();
    log("Getting ingredients Data completed", name: "AppConstant");
    _ingredientsWithImages = (m1 as List<dynamic>)
        .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
        .toList();
    // log(_ingredientsWithImages[0].toString(), name: "AppConstant");
  }

  static List<String> stringListAdapter(dynamic list) {
    return (list as List).map<String>((e) => e).toList();
  }

  String getIngredientImage(String ingredient) {
    String img = '';
    for (var i = 0; i < _ingredientsWithImages.length; i++) {
      if (_ingredientsWithImages[i]['ingredient'] == ingredient) {
        img = _ingredientsWithImages[i]['image'];
        break;
      }
    }
    if (img.isNotEmpty) {
      return 'https://cloudinary-cdn.whisk.com/image/upload/g_auto,c_fill,f_auto,q_auto:eco,fl_progressive:semi,h_512,w_512' +
          img;
    }
    return 'https://raw.githubusercontent.com/imsudip/foodify/main/data/shopping-bag.png';
  }
}
