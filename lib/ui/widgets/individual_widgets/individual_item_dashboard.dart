import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';

class IndividualItemDashboard extends StatelessWidget {
  const IndividualItemDashboard({
    super.key,
    required this.context,
    required this.title,
    required this.iconData,
    required this.background,
    required this.page,
  });

  final BuildContext context;
  final String title;
  final IconData iconData;
  final Color background;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return InkWell(
      onTap: () {
        // burada ilgili sayfaya yönlendirme kodunu yazın
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.ratingColor, //kartların rengi
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: AppColors.gold.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(iconData, color: AppColors.bColor)), //ikonların rengi
            SizedBox(height: height * 0.02),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color:
                        AppColors.primaryColor)) //kartlarda yazan yazının rengi
          ],
        ),
      ),
    );
  }
}
