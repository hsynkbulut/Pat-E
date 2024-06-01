import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';

class IndividualLoginHeader extends StatelessWidget {
  const IndividualLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          height: 180,
          image: AssetImage(ImagePaths.appLogo),
        ),
        Text(TTexts.individualLoginTitle,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.darkerGrey)),
        const SizedBox(height: TSizes.sm),
        Text(TTexts.individualLoginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
