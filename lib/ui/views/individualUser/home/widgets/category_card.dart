// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/category_modules.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/home/animal_adoption_home.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/home/info_and_education_home.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/home/lost_and_found_home.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModules categoryModules;

  const CategoryCard({
    super.key,
    required this.categoryModules,
  });

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return GestureDetector(
      onTap: () {
        if (widget.categoryModules.name == 'Hayvan Sahiplenme') {
          //Navigator.pushNamed(context, RouteConstant.individualPetAdoptionRoute);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimalAdoptionHomePage()),
          );
        } else if (widget.categoryModules.name == 'Kayıp İlanı') {
          //Navigator.pushNamed(context, RouteConstant.individualLostAndFoundRoute);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LostAndFoundHomePage()),
          );
        } else if (widget.categoryModules.name == 'Bilgi & Eğitim') {
          //Navigator.pushNamed(context, RouteConstant.individualInfoAndEducationRoute);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoAndEducationHomePage()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFCC00),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.2),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ],
          border: Border.all(
            color: AppColors.ratingColor,
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.bColor,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset(
                    widget.categoryModules.thumbnail,
                    height:
                        height * 0.15, //const kCategoryCardImageSize = 138.0;
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.004),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                widget.categoryModules.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.bColor,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
