import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String link;

  const SocialMediaItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () async {
        //await launch(link);
        await launchUrl(Uri.parse(link));
      },
      child: Container(
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
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: AppColors.darkerGrey),
              borderRadius: BorderRadius.circular(30),
              color: AppColors.whiteColor,
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              width: 45,
              height: 45,
            ),
          ),
          /*
          trailing: Icon(Iconsax.arrow_right,
              color: dark ? AppColors.dark : AppColors.primaryColor2),
              */
          tileColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
