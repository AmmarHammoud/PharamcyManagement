import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
enum Gender { male, female }

const double imageSize = 50;
const double divisor = 20;

class MedicineTextControllers {
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController scientificNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController activeIngredientController = TextEditingController();
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
  final GlobalKey<FormState> categoryValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> activeIngredientValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> priceValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> usesForValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> quantityValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> sideEffectsValidator = GlobalKey<FormState>();
}

class UserInfoControllers{
  final TextEditingController nameController = TextEditingController();
  //final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController haveDiseaseController = TextEditingController();
  final TextEditingController medicineUsedController = TextEditingController();
  final TextEditingController medicineAllergiesController = TextEditingController();
  final TextEditingController foodAllergiesController = TextEditingController();
}
class UserInfoValidators{
  //final GlobalKey<FormState> emailValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> nameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordConfirmationValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> haveDiseaseValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> medicineUsedValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> medicineAllergiesValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> foodAllergiesValidator = GlobalKey<FormState>();
}

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () async {
      Uri whatsapp =
      Uri.parse('https://wa.me/+963959289671');

      launchUrl(whatsapp,
          mode: LaunchMode
              .externalNonBrowserApplication)
          .then((value) => print(value.toString()))
          .catchError((error) => print(error.toString()));
    }, icon: Icon(Icons.call));
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
