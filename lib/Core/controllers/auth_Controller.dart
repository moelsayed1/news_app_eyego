import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app_eyego/Core/Controllers/news_controller.dart';
import 'package:news_app_eyego/Core/helpers/shared_pref_helpers.dart';
import 'package:news_app_eyego/Features/home/ui/views/home_screen.dart';
import 'package:news_app_eyego/Features/login/ui/login_screen.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool isLoggedIn = false;

  static bool isLoggedIn2 = false;
  String userId = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  Future<void> onInit() async {
    super.onInit();

    checkIfLoggedInUser();

    _newsAppAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
        userId = user.uid;
      }
    });
    isLoggedIn = false;

    //Activate NewsController.
  }

  static final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _newsAppAuth = FirebaseAuth.instance;

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return await _newsAppAuth.signInWithCredential(credential);
  }

  Future<bool> _hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> googleLogin() async {
    try {
      if (!await _hasNetwork()) {
        Get.snackbar(
          "You're not Connected",
          "Check your internet connection",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error_outline),
        );
        return false;
      }
      log("test");
      (await _signInWithGoogle()).user!.uid;


      log(_newsAppAuth.currentUser!.uid);
      if ((await _signInWithGoogle()).user?.uid != null) {
        isLoggedIn = true;
        userId = _newsAppAuth.currentUser!.uid;
        log(_newsAppAuth.currentUser!.uid);
        //init my news Controller
        Get.lazyPut<newsController>(() => newsController());
        await SharedPrefHelper.setData("userToken", userId);

        //Navigation

        Get.off(() => HomeScreen());
      }
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      isLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2));
      await _newsAppAuth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoggedIn = true;
      userId = _newsAppAuth.currentUser!.uid;
      isLoading = false;
      update();
      await SharedPrefHelper.setData("userToken", userId);
      //mrmostafa@gmail.com
      //Get.offAllNamed(Routes.NEWS_HOME); //Navigation
      Get.to(() => HomeScreen());
      GetSnackBar(
          title: "Welcome ${email.split('@')[0]}",
          message: "You are logged in successfully");
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      GetSnackBar(
          title: "Error", message: e.message ?? 'Email or Password is wrong');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading = true;
      update();
      await _newsAppAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      isLoggedIn = true;

      userId = _newsAppAuth.currentUser!.uid;
      Future.delayed(Duration(seconds: 15));
      isLoading = false;
      update();
      Get.to(() => LoginScreen());

      GetSnackBar(
          title: "Welcome ${email.split('@')[0]}",
          message: "You are registered successfully");
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      GetSnackBar(
          title: "Error",
          message: e.message ??
              'User already Registered , try to use antoher email , or Click on Forgot password ');
    }
  }

  Future<void> logOut() async {
    isLoading = true;
    update();
    await _newsAppAuth.signOut();
    isLoggedIn = false;
    userId = '';
    await SharedPrefHelper.removeData("userToken");
    isLoading = false;
    update();
    Get.off(() => LoginScreen());
  }

  Future<bool> checkIfLoggedInUser() async {
    String? userToken = await SharedPrefHelper.getString("userToken");
    if (userToken?.isEmpty == false) {
      isLoggedIn = true;
      return true;
    } else {
      isLoggedIn = false;
      return false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordObscureText = !isPasswordObscureText;
    update();
  }

  void togglePasswordConfirmationVisibility() {
    isPasswordConfirmationObscureText = !isPasswordConfirmationObscureText;
    update();
  }

  Future<void> validateThenDoSignup(BuildContext context) async {
    // Perform signup logic here
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = passwordConfirmController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please enter required fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    await signUp(email, password);

    // Proceed with signup
  }

  Future<void> validateThenDoLogin(BuildContext context) async {
    // Perform signup logic here
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter required fields');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    await loginWithEmail(email, password);

    // Proceed with signup
  }
}
