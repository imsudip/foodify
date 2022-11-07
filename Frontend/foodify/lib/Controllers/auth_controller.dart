// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:foodify/Constants/app_constant.dart';
import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/Screens/onboarding/calorie_page.dart';
import 'package:foodify/Screens/onboarding/diet_filter.dart';
import 'package:foodify/Screens/recipe_details.dart';
import 'package:foodify/Widgets/loader.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants/firebase_constants.dart';
import '../Screens/home.dart';
import '../Screens/onboarding/landing.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  static const String usersCollection = 'users';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;
  Rx<Map<String, dynamic>> userData = Rx({});
  PendingDynamicLinkData? initialLink;
  AuthController(this.initialLink);
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    ever(userData, _setUserData);
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print(dynamicLinkData.link.path);
      if (dynamicLinkData.link.path.isNotEmpty) {
        Get.dialog(const PopupLoader());
        var recipeId = dynamicLinkData.link.path.split('/').last;
        DatabaseService.instance.getRecipe(recipeId).then((value) {
          Get.back();
          Get.to(() => RecipeDetailScreen(recipe: value));
        });
      }
    }).onError((error) {
      Get.snackbar("Invalid Link", "Please try again");
    });
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      // user is logged in
      await getUserDocument();
      controlNavigation(userData.value);
      if (initialLink != null) {
        Get.dialog(const PopupLoader());
        var link = initialLink!.link;
        var recipeId = link.path.split('/').last;
        DatabaseService.instance.getRecipe(recipeId).then((value) {
          Get.back();
          Get.to(() => RecipeDetailScreen(recipe: value));
        });
      }
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => const OnboardingScreen());
      if (initialLink != null) {
        Get.snackbar(
          'You are not logged in',
          'Please login to continue',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  _setUserData(Map<String, dynamic>? user) async {
    print('user is being updated');
    print(user);
  }

  void register(String email, String password, String name) async {
    Get.dialog(const PopupLoader());
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await createUserDocument(auth.currentUser);
      if (auth.currentUser?.displayName == null || auth.currentUser?.displayName == '') {
        print('adding display name');
        await updateUserDocument({'userName': name});
      }
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      print(e.message);
      Get.back();
      // Get.snackbar("Error", e.message!);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.back();
      // this is temporary. you can handle different kinds of activities
      //such as dialogue to indicate what's wrong
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    Get.dialog(const PopupLoader());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      Get.back();
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.message);
    } catch (e) {
      Get.back();
      print(e.toString());
    }
  }

  void googleSignIn() async {
    try {
      Get.dialog(const PopupLoader());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      Get.back();
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.message);
    } catch (e) {
      Get.back();
      print(e.toString());
    }
  }

  void signOut() {
    try {
      userData.value = {};
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // create a document in the users collection
  Future<void> createUserDocument(User? user) async {
    try {
      // check if the user exists in the database
      DocumentSnapshot? userDoc = await _firestore.collection(usersCollection).doc(user?.uid).get();
      var d = {
        "userName": user?.displayName,
        "userEmail": user?.email,
        "userPhotoUrl": user?.photoURL ?? '',
        "userId": user?.uid,
      };
      if (userDoc.exists == false) {
        await _firestore.collection(usersCollection).doc(user?.uid).set(d);
        userData.value = d;
      } else {
        await _firestore.collection(usersCollection).doc(user?.uid).update(d);
        userData.value = d;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getUserDocument() async {
    try {
      DocumentSnapshot? userDoc = await _firestore.collection(usersCollection).doc(auth.currentUser?.uid).get();
      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;
        refresh();
      } else {
        print('user does not exist');
        print('creating user');
        await createUserDocument(auth.currentUser);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserDocument(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(usersCollection).doc(firebaseUser.value?.uid).set(data, SetOptions(merge: true));
      // add the data to the userData
      // userData.value = {...userData.value, ...data};
      await getUserDocument();
    } catch (e) {
      print(e.toString());
    }
  }

  static void controlNavigation(Map<String, dynamic> data) {
    if (data['diet'] == null) {
      Get.offAll(() => const DietFilterScreen());
    } else if (data['calorie'] == null) {
      Get.offAll(() => const CaloriePage());
    } else {
      Get.offAll(() => const Home());
    }
  }

  List<String> get savedRecipes => AppConstant.stringListAdapter(userData.value['savedRecipes'] ?? []);
  Future<bool> saveRecipe(String id) async {
    List<String> existing = savedRecipes;
    if (existing.contains(id)) {
      existing.remove(id);
    } else {
      existing.insert(0, id);
    }
    await updateUserDocument({'savedRecipes': existing});
    return savedRecipes.contains(id);
  }
}
