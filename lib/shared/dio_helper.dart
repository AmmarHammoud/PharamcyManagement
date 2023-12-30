import 'package:dio/dio.dart';

import 'cash_helper.dart';
import 'constants.dart';

const String API_KEY = 'cc3c2ef7b55eff8b85d61730553cc86c';

//192.168.229.83
//192.168.229.83
//'http://192.168.229.83:8000/api/'
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.137.8:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // static Future<Response> sendFcmToken(String token) async{
  //   print("User Id : "+CashHelper.getUserId().toString());
  //   print("Token : "+token);
  //   return await dio.post('saveFcmToken',
  //       data: {
  //     'user_id': CashHelper.getUserId(),
  //         'fcmtoken':token
  //       },
  //       options: Options(
  //           headers: {'Accept': 'application/json'},
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return true;
  //           }));
  // }
  static Future<Response> register({
    required String name,
    required String image,
    required String password,
    required String phone,
  }) async {
    return await dio.post('register',
        data: {
          'username': name,
          'mobile': phone,
          'password': password,
          'number': phone,
          'img': null,
        },
        options: Options(
            headers: {'Accept': 'application/json'},
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> login(
      {required String phone, required String password}) async {
    return await dio.post('login',
        data: {'mobile': phone, 'password': password},
        options: Options(
            // headers: {
            //   "Access-Control-Allow-Origin": "*",
            //   "Access-Control-Allow-Credentials": true,
            // },
            headers: {'Accept': 'application/json'},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
  }

  static Future<Response> logout() async {
    return await dio.get('logout',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> search(
      {required String token,
      required String searchText,
      required String searchType}) async {
    return await dio.post('search1',
        data: {'search_text': searchText, 'search_type': searchType},
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json'
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> updateProfile({
    required String token,
    required String name,
    required String email,
    required String image,
    required String phone,
    required String birthDate,
    required String medicineUsed,
    required String medicineAllergies,
    required String foodAllergies,
    required String haveDisease,
  }) async {
    return await dio.post('update',
        data: {
          'name': name,
          'email': email,
          'number': phone,
          'b_day': birthDate,
          'medicine_used': medicineUsed,
          'medicine_allergies': medicineAllergies,
          'food_allergies': foodAllergies,
          'have_disease': haveDisease,
          'img': image
        },
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> addNewMedication(
      {required String token,
      required String name,
      required String scientificName,
      required String companyName,
      required int category,
      required String image,
      required String quantity,
      required String expiryDate,
      required double price}) async {
    return await dio.post('medications',
        data: {
          'commercial_name': name,
          'scientific_name': scientificName,
          'manufacture': companyName,
          'category_id': category,
          'img': 'null',
          'quantity': quantity,
          'expiry_date': expiryDate,
          'price': price,
        },
        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> getUserInformation({required String token}) async {
    return await dio.get(
      'profile',
      options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
  }

  static Future<Response> getTotalMedicines({required String token}) async {
    return await dio.get('medications',
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> deleteMedicine(
      {required String token, required int id}) async {
    return await dio.get('deleteMedican/$id',
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> updateMedicineInformation({
    required String token,
    required String name,
    required String scientificName,
    required String companyName,
    required String category,
    required String activeIngredient,
    required String image,
    required String quantity,
    required String usesFor,
    required String sideEffects,
    required String expiryDate,
    required String a_price,
  }) async {
    return await dio.post('update_medi',
        data: {
          'name': name,
          'scientific_name': scientificName,
          'company_name': companyName,
          'category': category,
          'active_ingredient': activeIngredient,
          'img': image,
          'quantity': quantity,
          'uses_for': usesFor,
          'effects': sideEffects,
          'expiry_date': expiryDate,
          'a_price': a_price,
          'b_price': a_price
        },
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> addNewProduct(
      {required String token,
      required String image,
      required String name,
      required String description,
      required String quantity,
      required String price}) async {
    return await dio.post('add_product',
        data: {
          'name': name,
          'description': description,
          'price': price,
          'img': null,
          'quantity': quantity
        },
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> getWeeklyEarning({required String token}) async {
    return await dio.get('7day',
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  //
  static Future<Response> getCategories() async {
    return await dio.get('categories',
        options: Options(
            headers: {
              //'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> addCategory({required String title}) async {
    return await dio.post('categories',
        data: {'title': title},
        options: Options(
            headers: {
              //'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              //'id': cat[category]
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> getCategorizedMedicines(
      {required String category}) async {
    ///SHOULD BE UPDATED
    return await dio.get('medsByType',
        //data: {'id': cat[category]},
        queryParameters: {'id': cat[category]},
        options: Options(
            headers: {
              //'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              //'id': cat[category]
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> addMedicineRequest(
      {required String token,
      required int userId,
      required String userName,
      required String medicineName}) async {
    return await dio.post('add_medicine_request',
        data: {
          'user_id': userId,
          'user_name': userName,
          'medicine_name': medicineName
        },
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }
}
