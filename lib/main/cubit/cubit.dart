import 'package:dac/main/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dac/main/cubit/states.dart';
import 'package:intl/intl.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  TextDirection myTextDirection = localization.currentLocale.toString() == 'en'
      ? TextDirection.LTR
      : TextDirection.RTL;

  translateApp() {
    emit(MainTranslatingState());
    // Do some stuff
    myTextDirection = localization.currentLocale.toString() == 'en'
        ? TextDirection.LTR
        : TextDirection.RTL;
    emit(MainTranslatedState());
  }
}
