// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/category_modules.dart';
import 'package:pat_e/ui/views/individualUser/home/widgets/category_card.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kategorileri Keşfet",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: dark
                          ? AppColors.whiteColor
                          : AppColors.primaryColor.withOpacity(.9),
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 3,
                  color: dark
                      ? AppColors.whiteColor.withOpacity(0.9)
                      : AppColors.grey,
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2, // Her satırda 2 öğe göstermek için
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.01,
            ),
            childAspectRatio: 0.82,
            crossAxisSpacing: 20,
            mainAxisSpacing: 12,
            physics:
                const NeverScrollableScrollPhysics(), // Kaydırma özelliği devre dışı bırakıldı
            children: List.generate(categoryModulesList.length, (index) {
              return CategoryCard(
                categoryModules: categoryModulesList[index],
              );
            }),
          ),
        ],
      ),
    );
  }
}
