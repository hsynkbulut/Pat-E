import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';

class CorporateProfileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const CorporateProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: AppColors.dark.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(
          iconData,
          color: dark ? AppColors.dark : AppColors.primaryColor,
        ),
        /*
        trailing: Icon(Iconsax.arrow_right,
            color: dark ? AppColors.dark : AppColors.primaryColor2),
            */
        tileColor: AppColors.primaryColor,
      ),
    );
  }
}
