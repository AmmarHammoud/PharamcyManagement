import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dac/modules/add_new_product/add_new_medication/add_new_medication_screen.dart';
import 'package:dac/modules/add_new_product/add_new_medication/cubit/cubit.dart';
import 'package:dac/modules/add_new_product/add_new_medication/cubit/states.dart';
import 'package:dac/modules/categories/medication_categories/cubit/cubit.dart';
import 'package:dac/modules/categories/medication_categories/cubit/states.dart';
import 'package:dac/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cash_helper.dart';
import '../search_box/search_box.dart';
import 'add_category_screen.dart';

class CategorizedMedicineScreen extends StatelessWidget {
  var searchController = TextEditingController();
  bool isAdmin = CashHelper.isAdmin();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMedicineCategoriesCubit()..getCategories(),
      child:
          BlocConsumer<GetMedicineCategoriesCubit, GetMedicineCategoriesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var categoriesCubitObject = GetMedicineCategoriesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'categorized medicine',
              ),
            ),
            drawer: MyDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SearchBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    if(isAdmin)ElevatedButton(
                        onPressed: () {
                          navigateTo(context, const AddCategoryScreen());
                        },
                        child: const Text('add Category')),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // if(isAdmin)CustomizedButton(
                    //   title: 'add new medication',
                    //   condition: state is! AddNewMedicationLoadingState,
                    //   onPressed: () {
                    //     navigateTo(context, const AddNewMedicationScreen());
                    //   },),
                    const SizedBox(
                      height: 30,
                    ),
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   crossAxisCount: 2,
                    //   children: const [
                    //     CategoriesScreenButton(
                    //       title: 'heart',
                    //       widget: CategorizedMedicines(category: 'heart'),
                    //       imagePath: 'images/heart.png',
                    //     ),
                    //     CategoriesScreenButton(
                    //       title: 'skin',
                    //       widget: CategorizedMedicines(category: 'skin'),
                    //       imagePath: 'images/skin.png',
                    //     ),
                    //     CategoriesScreenButton(
                    //       title: 'nero',
                    //       widget: CategorizedMedicines(category: 'nero'),
                    //       imagePath: 'images/neuron.png',
                    //     ),
                    //     CategoriesScreenButton(
                    //       title: 'dig',
                    //       widget: CategorizedMedicines(category: 'digestive'),
                    //       imagePath: 'images/digestive.png',
                    //     ),
                    //     CategoriesScreenButton(
                    //       title: 'opth',
                    //       widget: CategorizedMedicines(category: 'optical'),
                    //       imagePath: 'images/ophtalmology.png',
                    //     ),
                    //   ],
                    // )
                    // ListView.separated(
                    //     itemBuilder: (context, idx) => CategoriesScreenButton(
                    //           title: categoriesCubitObject
                    //               .categories[idx].category.title,
                    //           imagePath: 'images/skin.png',
                    //           widget: CategorizedMedicines(
                    //               category: categoriesCubitObject
                    //                   .categories[idx].category.title),
                    //         ),
                    //     separatorBuilder: (context, idx) => SizedBox(
                    //           height: 20,
                    //         ),
                    //     itemCount: categoriesCubitObject.categories.length),
                    ConditionalBuilder(
                      condition: state is! GetMedicineCategoriesLoadingState,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, idx) => CategoriesScreenButton(
                            title: categoriesCubitObject
                                .categories[idx].title,
                            imagePath: 'images/skin.png',
                            widget: CategorizedMedicines(
                                category: categoriesCubitObject
                                    .categories[idx].title),
                          ),
                          separatorBuilder: (context, idx) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: categoriesCubitObject.categories.length),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
