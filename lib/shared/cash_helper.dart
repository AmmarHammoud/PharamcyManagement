import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putString({required key, required value})async{
    return await sharedPreferences.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> putUser({required String userToken})async{
    bool putUserToken = await sharedPreferences.setString('token', userToken);
    return putUserToken;
  }
  static Future<bool> putUserEmail({required String email}) async{
    return await sharedPreferences.setString('email', email);
  }

  static String? getUserToken(){
    return sharedPreferences.getString('token');
  }
  static bool isAdmin(){
    //print('ADMIN EMAIL: ${sharedPreferences.getString('email')}');
    return sharedPreferences.getString('email') == 'a@a.com';
  }
  static logoutUser(){
    sharedPreferences.clear();
  }
}
