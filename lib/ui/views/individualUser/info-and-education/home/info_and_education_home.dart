// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/home/widgets/category_info_card.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/home/widgets/info_and_education_color.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/home/widgets/info_and_education_data.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class InfoAndEducationHomePage extends StatefulWidget {
  @override
  State<InfoAndEducationHomePage> createState() =>
      _InfoAndEducationHomePageState();
}

class _InfoAndEducationHomePageState extends State<InfoAndEducationHomePage> {
  InfoAndEducationData infoData = InfoAndEducationData();

  InfoAndEducationColor infoColor = InfoAndEducationColor();

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.ratingColor, AppColors.whiteColor],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(infoData.pages.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  child: CategoryInfoCard(
                    decoration: BackgroundGradient().buildGradient9(),
                    title: infoData.getTitle(index),
                    imagePath: infoData.getImagePath(index),
                    description: infoData.getDescription(index),
                    backgroundColor: infoColor.getBackgroundColor[
                        index % infoColor.getBackgroundColor.length],
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => infoData.pages[index]),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
