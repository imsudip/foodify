import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants/firebase_constants.dart';
import '../Screens/home.dart';
import '../Screens/login.dart';

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
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    ever(firebaseUser, _setUserData);
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      // await createUserDocument(user);
      // user is logged in
      Get.offAll(() => const Home());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => Login());
    }
  }

  _setUserData(User? user) async {
    print('user is being updated');
    if (user != null) {
      await createUserDocument(user);
    }
  }

  void register(String email, String password, String name) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (auth.currentUser?.displayName == null || auth.currentUser?.displayName == '') {
        print('adding display name');
        await auth.currentUser?.updateDisplayName(name);
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
  }

  void signOut() {
    try {
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
}
