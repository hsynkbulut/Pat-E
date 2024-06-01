import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/individualUser/auth/login/widgets/individual_login_form.dart';
import 'package:pat_e/ui/views/individualUser/auth/login/widgets/individual_login_header.dart';

class IndividualLoginScreen extends StatelessWidget {
  const IndividualLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2), //TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              IndividualLoginHeader(),

              /// Form
              IndividualLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
