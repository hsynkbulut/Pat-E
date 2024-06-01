// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/individual_adopt_pet_page.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/sub_home/rehoming_the_animal.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/rounded_button.dart';

class AnimalAdoptionHomePage extends StatefulWidget {
  @override
  _AnimalAdoptionHomePageState createState() => _AnimalAdoptionHomePageState();
}

class _AnimalAdoptionHomePageState extends State<AnimalAdoptionHomePage> {
  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      //drawer: const SideMenu(),
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.ratingColor, AppColors.whiteColor],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -height * 0.14, //-100,
                right: -width * 0.2, //-90,
                child: Container(
                  width: width * 0.7, // 360,
                  height: height * 0.35, //230,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF7A4DFF),
                  ),
                ),
              ),
              Positioned(
                bottom: -height * 0.27, // -218
                left: width * 0,
                right: width * 0,
                child: Center(
                  child: Container(
                    width: width, // 530,
                    height: height * 0.48, // 420,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.ratingColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.15),
                    const Text(
                      'Hayvan Sahiplenme',
                      style: TextStyle(
                        fontFamily: 'OhChewy',
                        fontSize: 40.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    RoundedButton(
                      onPressed: () {
                        // "Hayvan Sahiplen" butonuna tıklama işlemleri
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const IndividualAdoptPetPage()),
                        );
                      },
                      colour: AppColors.ratingColor,
                      tcolor: AppColors.primaryColor,
                      title: 'Hayvan Sahiplen',
                    ),
                    SizedBox(height: height * 0.005),
                    RoundedButton(
                      onPressed: () {
                        // "Hayvan Sahiplendir" butonuna tıklama işlemleri
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RehomingTheAnimal()),
                        );
                      },
                      colour: AppColors.primaryColor,
                      tcolor: AppColors.ratingColor,
                      title: 'Hayvan Sahiplendir',
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      height: height * 0.26, //200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          ImagePaths.categoryAdoption,
                          width: width * 0.55, //200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
