import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/common/styles/spacing_styles.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/add_lost_announcement/widgets/individual_add_lost_listing_form.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualAddLostListingsScreen extends StatefulWidget {
  const IndividualAddLostListingsScreen({super.key});

  @override
  State<IndividualAddLostListingsScreen> createState() =>
      _IndividualAddLostListingsScreenState();
}

class _IndividualAddLostListingsScreenState
    extends State<IndividualAddLostListingsScreen> {
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
        padding: const EdgeInsets.only(top: 10.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      height: 140,
                      image: AssetImage(ImagePaths.appLogo),
                    ),

                    /// Title
                    Text(TTexts.createListingTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dark
                                    ? AppColors.whiteColor
                                    : AppColors.darkerGrey)),
                    const SizedBox(height: TSizes.spaceBtwSections / 2),
                  ],
                ),

                /// Form
                const IndividualAddLostListingForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
