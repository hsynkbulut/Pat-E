import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/chooseProfile/widgets/profile_icon.dart';
import 'package:pat_e/ui/views/corporateUser/auth/corporate_tabbar_auth_screen.dart';
import 'package:pat_e/ui/views/individualUser/auth/individual_tabbar_auth_screen.dart';

class ChooseProfile extends StatelessWidget {
  const ChooseProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profil Seç',
            style: TextStyle(
                fontSize: 22.0,
                color: dark ? AppColors.whiteColor : AppColors.darkerGrey,
                fontWeight: FontWeight.bold),
          ),
          GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 32.0,
                  crossAxisSpacing: 8.0,
                  crossAxisCount: 2),
              itemCount: 2,
              itemBuilder: (BuildContext ctx, index) {
                Color iconColor =
                    index == 0 ? AppColors.error : AppColors.primaryColor;
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CorporateTabbarAuthScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const IndividualTabbarAuthScreen()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: ProfileIcon(
                                color: iconColor,
                              )),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        index == 0 ? 'Kurumsal' : 'Bireysel',
                        style: TextStyle(color: iconColor),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
