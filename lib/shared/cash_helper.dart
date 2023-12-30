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

  static Future<bool> putUserPhone({required String mobile}) async{
    return await sharedPreferences.setString('mobile', mobile);
  }

  static String? getUserToken(){
    return sharedPreferences.getString('token');
  }

  static String? getUserPhone() {
    return sharedPreferences.getString('mobile');
  }
  static bool isAdmin(){
    //print('in isAdmin function: ${getUserPhone()}');
    return getUserPhone() == '0991996920';
  }
  static Future<bool> putUserId({required int id}) async{
    return await sharedPreferences.setInt('id', id);
  }
  static int? getUserId(){
    return sharedPreferences.getInt('id');
  }
  static logoutUser(){
    sharedPreferences.clear();
  }
}
