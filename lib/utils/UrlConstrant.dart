import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class URLConstants {
  // static const String base_url = "http://foxyserver.com/klench/api/";
  static const String base_url = "https://foxytechnologies.com/klench/api/";
  static const signUpApi = "signup.php";
  static const loginApi = "login.php";
  static const EditProfileApi = "edit-profile.php";
  static const sendOtpApi = "send-otp.php";
  static const ResendOtpApi = "resend-otp.php";
  static const verifyOtpApi = "otp-verify.php";
  static const ForgotpassverifyOtpApi = "forgot-verify-otp.php";
  static const getProfileApi = "get-profile.php";
  static const forgotPasswordApi = "forgot-password.php";
  static const resetPasswordApi = "reset-password.php";
  static const CheckUserApi = "check-user.php";

  static String id = "id";
  static String levels = "level";
  static String username = "username";
  static String authentication_enable = 'Authentication';
}

class PreferenceManager {
  late SharedPreferences sharedPreferences;

  // set data in preference
  Future<bool> remove() async {
    print("remove preferences");
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  // set data in preference
  Future<bool> setPref(String key, String value) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }


  // get data in preference
  Future<String> getPref(String key) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  Future<bool> setbool(String key, bool value) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  Future<bool> getbool(String key) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

}
