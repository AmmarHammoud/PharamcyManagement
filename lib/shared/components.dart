import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/models/search_model/medicine_model/medicine_model.dart';
import 'package:dac/modules/categories/medication_categories/medical_equipments.dart';
import 'package:dac/modules/register_screen/cubit/cubit.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../modules/calculations_screen/calculation_screen.dart';
import '../modules/categories/categories.dart';
import '../modules/categories/medication_categories/cosmatics.dart';
import '../modules/login_screen/login_screen.dart';
import '../modules/profile_screen/profile_screen.dart';
import 'constants.dart';

navigateTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

class ValidatedTextField extends StatelessWidget {
  final GlobalKey<FormState> validator;
  final String errorText;
  final String hintText;
  final bool hasNextText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  final bool enable;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final double fontSize;
  final double radius;

  const ValidatedTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.errorText,
      required this.hintText,
      required this.onChanged,
      this.onFieldSubmitted,
      this.hasNextText = true,
      this.enable = true,
      this.icon,
      this.suffixIcon,
      this.obscureText = false,
      this.fontSize = 20.0,
      this.radius = 15.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType? textInputType;
    if (hintText == 'email') {
      textInputType = TextInputType.emailAddress;
    } else if (hintText == 'phone number') {
      textInputType = TextInputType.phone;
    }
    return Form(
      key: validator,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        enabled: enable,
        textInputAction:
            hasNextText ? TextInputAction.next : TextInputAction.done,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        onChanged: onChanged,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

///This is for all platforms
///but needs to be handled
FToast fToast = FToast();

showToast(
    {required context,
    required String text,
    required Color color,
    int duration = 3}) {
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: duration),
  );
}

///This is only for android and IOS.
void showToastAndroidIos({required String text}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget showPasswordIcon(
    {required Function() onPressed, required bool passwordIsShown}) {
  return IconButton(
      onPressed: onPressed,
      icon: passwordIsShown
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off));
}

class ShowQuestionAnswerBox extends StatelessWidget {
  final TextEditingController controller;
  final cubitObject;
  final String question;
  final GlobalKey<FormState> validator;
  final String errorText;
  final String hintText;
  final Function(String) onChanged;
  final int switchIndex;

  const ShowQuestionAnswerBox(
      {Key? key,
      required this.controller,
      required this.cubitObject,
      required this.question,
      required this.validator,
      required this.errorText,
      required this.hintText,
      required this.onChanged,
      required this.switchIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            FlutterSwitch(
                value: cubitObject.questions[switchIndex],
                onToggle: (value) {
                  cubitObject.changeQuestionSwitch(switchIndex: switchIndex);
                }),
          ],
        ),
        if (cubitObject.questions[switchIndex])
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ValidatedTextField(
                  hasNextText: false,
                  controller: controller,
                  validator: validator,
                  errorText: errorText,
                  hintText: hintText,
                  onChanged: onChanged),
              const SizedBox(
                height: 10,
              ),
            ],
          )
      ],
    );
  }
}

class GenderSelection extends StatelessWidget {
  final RegisterCubit register;

  const GenderSelection({Key? key, required this.register}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Gender: ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Expanded(
          child: GenderSelectionButton(
              register: register, text: 'male', gender: Gender.male),
        ),
        Expanded(
          child: GenderSelectionButton(
              register: register, text: 'female', gender: Gender.female),
        )
      ],
    );
  }
}

class GenderSelectionButton extends StatelessWidget {
  final RegisterCubit register;
  final String text;
  final Gender gender;

  const GenderSelectionButton(
      {Key? key,
      required this.register,
      required this.text,
      required this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.all(0),
      title: Text(text),
      leading: Radio(
        value: gender,
        groupValue: register.gender,
        onChanged: (Gender? newGender) {
          register.changeGenderSelection(gender: newGender);
        },
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  final String title;
  final Widget widget;
  final String imagePath;

  const MainScreenButton(
      {super.key,
      required this.title,
      required this.widget,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double imageSize = 100;
    return Card(
      // clipBehavior is necessary because, without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          navigateTo(context, widget);
        },
        child: SizedBox(
          width: 200,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                        color: Colors.blueAccent,
                        child: Center(child: Text(title))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesScreenButton extends StatelessWidget {
  final String title;
  final Widget widget;
  final String imagePath;

  const CategoriesScreenButton(
      {super.key,
      required this.title,
      required this.widget,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior is necessary because, without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
      clipBehavior: Clip.hardEdge,
      //color: Colors.blueAccent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          navigateTo(context, widget);
        },
        child: SizedBox(
          width: 200,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                        color: Colors.blueAccent,
                        child: Center(
                            child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyText2,
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final double width;
  final Color color;
  final String title;
  final String imagePath;
  final Function() onPressed;

  const DrawerButton(
      {super.key,
      this.width = 20,
      this.color = Colors.blueAccent,
      required this.title,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double imageSize = 40;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () {},
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: imageSize,
              height: imageSize,
            ),
            MaterialButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double divisor = 15;
    return Drawer(
      //width: 250,
      child: ListView(padding: EdgeInsets.zero, children: [
        SizedBox(
          width: 200,
          height: 120,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'more info',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
          onPressed: () => navigateTo(context, const ProfileScreen()),
          title: 'my profile',
          imagePath: 'images/profile.png',
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
          onPressed: () => navigateTo(context, CategorizedMedicineScreen()),
          title: 'medicine',
          imagePath: 'images/medicine.png',
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
          onPressed: () => navigateTo(context, MedicalEquipmentsScreen()),
          title: 'medical equipments',
          imagePath: 'images/medical_equipments.png',
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
          onPressed: () => navigateTo(context, CosmaticsScreen()),
          title: 'cosmetics',
          imagePath: 'images/cosmetics.png',
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
          onPressed: () => navigateTo(context, const CalculationScreen()),
          title: 'calculations',
          imagePath: 'images/budget.png',
        ),
        SizedBox(
          height: divisor,
        ),
        DrawerButton(
            title: 'logout',
            imagePath: 'images/logout.png',
            onPressed: () {
              CashHelper.logoutUser();
              navigateAndFinish(context, const LoginScreen());
            })
      ]),
    );
  }
}

class CustomizedButton extends StatelessWidget {
  final String title;
  final bool condition;
  final Function() onPressed;
  final Color color;

  const CustomizedButton(
      {Key? key,
      required this.title,
      required this.condition,
      required this.onPressed,
      this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: condition,
      builder: (context) => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Text(title)),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DateSelector extends StatelessWidget {
  final Function() onTap;
  final DateTime shownDate;
  final String hintText;

  const DateSelector(
      {Key? key,
      required this.onTap,
      required this.shownDate,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ValidatedTextField(
            controller: TextEditingController(),
            icon: Icons.calendar_month,
            enable: false,
            validator: GlobalKey<FormState>(),
            errorText: '',
            hintText: '$hintText ${DateFormat('yyyy/MM/dd').format(shownDate)}',
            onChanged: (x) {}));
  }
}

class MedicineComponents extends StatelessWidget {
  final cubitObject;
  final MedicineModel? medicineModel;

  const MedicineComponents(
      {Key? key, required this.cubitObject, this.medicineModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime initialDate;
    if (medicineModel?.expireDate == null) {
      initialDate = cubitObject.medicineTextControllers.expireDate;
    } else {
      initialDate = DateTime.parse(medicineModel!.expireDate);
    }
    double divisor = 20;
    return Column(
      children: [
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.medicineNameController,
            icon: Icons.medication,
            validator: cubitObject.medicineTextValidators.medicineNameValidator,
            errorText: 'name field must be filled',
            hintText: medicineModel?.name ?? 'medicine name',
            onChanged: (name) {
              cubitObject.medicineNameValidator.currentState?.validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.scientificNameController,
            icon: Icons.medication,
            validator:
                cubitObject.medicineTextValidators.scientificNameValidator,
            errorText: 'scientific name field must be filled',
            hintText: medicineModel?.scientificName ?? 'scientific name',
            onChanged: (scientificName) {
              cubitObject
                  .medicineTextValidators.scientificNameValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.companyNameController,
            icon: Icons.house,
            validator: cubitObject.medicineTextValidators.companyNameValidator,
            errorText: 'company name field must be filled',
            hintText: medicineModel?.companyName ?? 'company name',
            onChanged: (companyName) {
              cubitObject
                  .medicineTextValidators.companyNameValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.categoryController,
            icon: Icons.padding,
            validator: cubitObject.medicineTextValidators.categoryValidator,
            errorText: 'categories field must be filled',
            hintText: medicineModel?.category ?? 'categories',
            onChanged: (categories) {
              cubitObject.medicineTextValidators.categoryValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        DateSelector(
            hintText: 'expiry date:',
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1950, 1),
                  lastDate: DateTime(2101));
              if (picked != null && picked != initialDate) {
                cubitObject.changeDate(expireDate: picked);
              }
            },
            shownDate: initialDate),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.quantityController,
            icon: Icons.production_quantity_limits_rounded,
            validator: cubitObject.medicineTextValidators.quantityValidator,
            errorText: 'quantity field must be filled',
            hintText: medicineModel?.quantity.toString() ?? 'quantity',
            onChanged: (quantity) {
              cubitObject.medicineTextValidators.quantityValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.usesForController,
            icon: Icons.medical_services_outlined,
            validator: cubitObject.medicineTextValidators.usesForValidator,
            errorText: 'uses for field must be filled',
            hintText: medicineModel?.usesFor ?? 'uses for',
            onChanged: (usesFor) {
              cubitObject.medicineTextValidators.usesForValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.sideEffectsController,
            icon: Icons.medical_information,
            validator: cubitObject.medicineTextValidators.sideEffectsValidator,
            errorText: 'side effects field must be filled',
            hintText: medicineModel?.sideEffects ?? 'side effects',
            onChanged: (sideEffects) {
              cubitObject
                  .medicineTextValidators.sideEffectsValidator.currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            controller: cubitObject.medicineTextControllers.activeIngredientController,
            icon: Icons.medical_information,
            validator:
                cubitObject.medicineTextValidators.activeIngredientValidator,
            errorText: 'active ingredients field mist be filled',
            hintText: medicineModel?.activeIngredients ?? 'active ingredients',
            onChanged: (activeIngredients) {
              cubitObject.medicineTextValidators.activeIngredientValidator
                  .currentState!
                  .validate();
            }),
        SizedBox(
          height: divisor,
        ),
        ValidatedTextField(
            hasNextText: false,
            controller: cubitObject.medicineTextControllers.priceController,
            icon: Icons.price_change,
            validator: cubitObject.medicineTextValidators.priceValidator,
            errorText: 'price filed must be filled',
            hintText: medicineModel?.price ?? 'price',
            onChanged: (price) {
              cubitObject.medicineTextValidators.priceValidator.currentState!
                  .validate();
            }),
      ],
    );
  }
}

void showNotification({
  required int id,
  required String mainTitle,
  required String details,
  bool ongoing = false,
}) async {
  await FlutterLocalNotificationsPlugin().show(
    888,
    mainTitle,
    details,
    const NotificationDetails(
      android: AndroidNotificationDetails(

        channelID,
        'MY SERVICE',
        icon: 'ic_bg_service_small',
        ongoing: false,
      ),
    ),
  );
}
