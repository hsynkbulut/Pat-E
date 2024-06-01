import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';

class CorporateLoginHeader extends StatelessWidget {
  const CorporateLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          height: 180,
          image: AssetImage(ImagePaths.appLogo2),
        ),
        Text(TTexts.corporateLoginTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.primaryColor2)),
        const SizedBox(height: TSizes.sm),
        Text(TTexts.corporateLoginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.darkerGrey)),
      ],
    );
  }
}
