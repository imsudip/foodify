import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodify/Constants/app_constant.dart';
import 'package:foodify/Screens/onboarding/calorie_page.dart';
import 'package:foodify/Screens/onboarding/diet_filter.dart';
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

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    ever(userData, _setUserData);
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      // user is logged in
      await getUserDocument();
      controlNavigation(userData.value);
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => const OnboardingScreen());
    }
  }

  _setUserData(Map<String, dynamic>? user) async {
    // compare the user data with the current user data
    print('user is being updated');
    // print(user);
    // if (user != null && user != userData.value) {
    //   // update the user data
    //   userData.value = user;
    // }
  }

  void register(String email, String password, String name) async {
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
      // Get.snackbar("Error", e.message!);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // this is temporary. you can handle different kinds of activities
      //such as dialogue to indicate what's wrong
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.message);
    } catch (e) {
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
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
    Get.back();
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
      DocumentSnapshot? userDoc =
          await _firestore.collection(usersCollection).doc(user?.uid).get();
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
      DocumentSnapshot? userDoc =
          await _firestore.collection(usersCollection).doc(auth.currentUser?.uid).get();
      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;
        // print(userData.value);
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
      await _firestore
          .collection(usersCollection)
          .doc(firebaseUser.value?.uid)
          .set(data, SetOptions(merge: true));
      // add the data to the userData
      userData.value = {...userData.value, ...data};
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
      Get.offAll(() => Home());
    }
  }

  List<String> get savedRecipes =>
      AppConstant.stringListAdapter(userData.value['savedRecipes']);
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
