import 'package:dac/main/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum Gender { male, female }

Map<String, dynamic> cat = {
  'skin': 1,
  'optical': 2,
  'digestive': 3,
  'heart': 4,
  'nero': 5,
  '1': 'skin',
  '2': 'optical',
  '3': 'digestive',
  '4': 'heart',
  '5': 'nero'

};

const double imageSize = 50;
const double divisor = 20;

class MedicineTextControllers {
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController scientificNameController =
      TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  //final TextEditingController categoryController = TextEditingController();
  final TextEditingController activeIngredientController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController usesForController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController sideEffectsController = TextEditingController();
  DateTime expireDate = DateTime.now();
}

class MedicineTextValidators {
  final GlobalKey<FormState> medicineNameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> scientificNameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> companyNameValidator = GlobalKey<FormState>();
  //final GlobalKey<FormState> categoryValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> activeIngredientValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> priceValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> usesForValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> quantityValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> sideEffectsValidator = GlobalKey<FormState>();
}

class UserInfoControllers {
  final TextEditingController nameController = TextEditingController();

  //final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController haveDiseaseController = TextEditingController();
  final TextEditingController medicineUsedController = TextEditingController();
  final TextEditingController medicineAllergiesController =
      TextEditingController();
  final TextEditingController foodAllergiesController = TextEditingController();
}

class UserInfoValidators {
  //final GlobalKey<FormState> emailValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> nameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordConfirmationValidator =
      GlobalKey<FormState>();
  final GlobalKey<FormState> phoneValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> haveDiseaseValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> medicineUsedValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> medicineAllergiesValidator =
      GlobalKey<FormState>();
  final GlobalKey<FormState> foodAllergiesValidator = GlobalKey<FormState>();
}

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Uri whatsapp = Uri.parse('https://wa.me/+963959289671');

          launchUrl(whatsapp, mode: LaunchMode.externalNonBrowserApplication)
              .then((value) => print(value.toString()))
              .catchError((error) => print(error.toString()));
        },
        icon: Icon(Icons.call));
    // ElevatedButton(
    //   onPressed: () async {
    //     Uri whatsapp =
    //     Uri.parse('https://wa.me/+963959289671');
    //
    //     launchUrl(whatsapp,
    //         mode: LaunchMode
    //             .externalNonBrowserApplication)
    //         .then((value) => print(value.toString()))
    //         .catchError((error) => print(error.toString()));
    //   },
    //   child: const Text('open whatsapp'));
  }
}

mixin AppLocal {
  static const String title = 'title';
  static const String login = 'login';
  static const String register = 'register';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String userName = 'user name';
  static const String reWritePassword = 're-write passowrd';
  static const String optical = 'optical';
  static const String skin = 'skin';
  static const String digestive = 'digestive';
  static const String heart = 'heart';
  static const String nero = 'nero';
  static const String categories = 'categories';
  static const String medicines = 'medicines';
  static const String addCategory = 'Add Category';
  static const Map<String, dynamic> ar = {
    title: 'العنوان',
    login: 'تسجيل الدخول',
    register: 'تسجيل حساب',
    phone: 'رقم الهاتف',
    password: 'كلمة السر',
    userName: 'اسم المستخدم',
    reWritePassword: 'إعادة كلمة السر',
    optical: 'عينية',
    skin: 'جلدية',
    heart: 'قلبية',
    digestive: 'هضمية',
    nero: 'عصبية',
    categories: 'تصنيفات',
    medicines: 'ادوية',
    addCategory: 'إضافة تصنيف'
  };
  static const Map<String, dynamic> en = {
    title: 'title',
    login: 'login',
    register: 'register',
    phone: 'phone',
    password: 'password',
    userName: 'user name',
    reWritePassword: 're-write password',
    heart: 'heart',
    skin: 'skin',
    nero: 'nero',
    digestive: 'digestive',
    optical: 'optical',
    medicines: 'medicines',
    categories: 'categories',
    addCategory: 'Add Category'
  };
}

void translate() {
  if (localization.currentLocale.toString() == 'en') {
    localization.translate('ar');
  } else {
    localization.translate('en');
  }
}

TextDirection currentTextDirection() {
  return localization.currentLocale.toString() == 'en'
      ? TextDirection.ltr
      : TextDirection.rtl;
}

class TranslateButton extends StatelessWidget {
  const TranslateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => translate(), icon: const Icon(Icons.translate));
  }
}
