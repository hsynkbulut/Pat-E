// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/individual_search_for_lost_pets.dart.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/sub_home/make_a_lost_claim.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/rounded_button.dart';

class LostAndFoundHomePage extends StatefulWidget {
  @override
  _LostAndFoundHomePageState createState() => _LostAndFoundHomePageState();
}

class _LostAndFoundHomePageState extends State<LostAndFoundHomePage> {
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
                    color: Color.fromARGB(255, 122, 77, 255),
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
                      'Kayıp ilanı',
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
                                  const IndividualSearchForLostPets()),
                        );
                      },
                      colour: AppColors.ratingColor,
                      tcolor: AppColors.primaryColor,
                      title: 'Kayıp İlanlarına Bak',
                    ),
                    SizedBox(height: height * 0.005),
                    RoundedButton(
                      onPressed: () {
                        // "Hayvan Sahiplendir" butonuna tıklama işlemleri
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MakeALostClaim()),
                        );
                      },
                      colour: AppColors.primaryColor,
                      tcolor: AppColors.ratingColor,
                      title: 'Kayıp Talebinde Bulun',
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      height: height * 0.26, //200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          ImagePaths.categoryLost,
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
