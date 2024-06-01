import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/corporateUser/auth/login/corporate_login.dart';
import 'package:pat_e/ui/views/corporateUser/auth/signup/corporate_signup.dart';

class CorporateTabbarAuthScreen extends StatefulWidget {
  const CorporateTabbarAuthScreen({super.key});

  @override
  State<CorporateTabbarAuthScreen> createState() =>
      _CorporateTabbarAuthScreenState();
}

class _CorporateTabbarAuthScreenState extends State<CorporateTabbarAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    final Size screenSize = THelperFunctions.screenSize(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
                color: dark ? AppColors.whiteColor : AppColors.black),
            centerTitle: true,
            title: Text(
              'Kurumsal Kullanıcı',
              style: TextStyle(
                color: dark ? AppColors.whiteColor : AppColors.black,
                fontFamily: 'SignikaNegative',
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.08,
                vertical: screenSize.height * 0.02),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.01),
                Container(
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      color: dark
                          ? AppColors.primaryColor2.withOpacity(0.35)
                          : AppColors.primaryColor2.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
                    indicatorColor:
                        dark ? AppColors.whiteColor : AppColors.primaryColor2,
                    labelColor:
                        dark ? AppColors.whiteColor : AppColors.primaryColor2,
                    unselectedLabelColor:
                        dark ? AppColors.primaryColor2 : AppColors.darkerGrey,
                    tabs: const [
                      Tab(
                        text: 'Giriş',
                      ),
                      Tab(
                        text: 'Kayıt',
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    child: TabBarView(
                  children: [
                    CorporateLoginScreen(),
                    CorporateSignupScreen(),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
