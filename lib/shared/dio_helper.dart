import 'package:dio/dio.dart';

const String API_KEY = 'cc3c2ef7b55eff8b85d61730553cc86c';

class ImageUploader {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://api.imgbb.com/1/', receiveDataWhenStatusError: true));
  }

  static Future<Response> uploadImage({required String imagePath}) async {
    return await dio.post('upload',
        options: Options(headers: {'key': API_KEY, 'image': imagePath}));
  }
}

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.195.83:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> register({
    required String name,
    required String email,
    required String image,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required bool isMale,
    required String birthDay,
    required String medicineUsed,
    required String medicineAllergies,
    required String foodAllergies,
    required String haveDisease,
    required String anotherDisease,
  }) async {
    return await dio.post('register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'number': phone,
          'gender': isMale ? 'male' : 'female',
          'b_day': birthDay,
          'medicine_used': medicineUsed,
          'medicine_allergies': medicineAllergies,
          'food_allergies': foodAllergies,
          'have_disease': haveDisease,
          'another_disease': anotherDisease,
          'img': image
        },
        options: Options(
            headers: {'Accept': 'application/json'},
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }));
  }

  static Future<Response> login(
      {required String email, required String password}) async {
    return await dio.post('login',
        data: {'email': email, 'password': password},
        options: Options(
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

  static Future<Response> updateProfile(
      {required String token,
        required String name,
      required String email,
      required String image,
      required String phone,
      required String birthDate,
      required String medicineUsed,
      required String medicineAllergies,
      required String foodAllergies,
      required String haveDisease,}) async {
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
            headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token',},
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
      required String category,
      required String activeIngredient,
      required String image,
      required String quantity,
      required String usesFor,
      required String sideEffects,
      required String expiryDate,
      required String a_price,
      required String b_price}) async {
    return await dio.post('add',
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
          'b_price': b_price,
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
    return await dio.get('total_medican',
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
          'img': image,
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
}
