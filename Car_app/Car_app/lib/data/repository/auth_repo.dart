import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiclient;
  final SharedPreferences sharedPreferences;
  AuthRepo(
      {required this.apiclient,
      required this.sharedPreferences,
      required apiClient});
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiclient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(String phone, String password) async {
    return await apiclient.postData(
        AppConstants.LOGIN_URI, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiclient.token = token;
    apiclient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiclient.token = '';
    apiclient.updateHeader('');
    return true;
  }
}
