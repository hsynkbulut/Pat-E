import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/common/styles/spacing_styles.dart';
import 'package:pat_e/core/models/individual_model.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/edit_profile/widgets/individual_edit_profile_form.dart';
import 'package:pat_e/ui/views/individualUser/edit_profile/widgets/individual_edit_profile_header.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualEditProfilePage extends StatefulWidget {
  final Individual individual;
  const IndividualEditProfilePage({super.key, required this.individual});

  @override
  State<IndividualEditProfilePage> createState() =>
      _IndividualEditProfilePageState();
}

class _IndividualEditProfilePageState extends State<IndividualEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    //final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
                2), //TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                /// Logo, Title & Sub-Title
                const IndividualEditProfileHeader(),

                /// Form
                IndividualEditProfileForm(individual: widget.individual),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
