import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/viewmodel/authentication/individual/login_viewmodel_individual.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class IndividualLoginForm extends StatefulWidget {
  const IndividualLoginForm({
    super.key,
  });

  @override
  State<IndividualLoginForm> createState() => _IndividualLoginFormState();
}

class _IndividualLoginFormState extends State<IndividualLoginForm> {
  LoginViewModelIndividual viewModel = LoginViewModelIndividual();
  bool isSignIn = false; // Bayrak tanımlama

  void _signIn() async {
    setState(() {
      isSignIn = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.signIn(context);

    setState(() {
      isSignIn = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            IndividualTextFormField(
              keyboardType: TextInputType.emailAddress,
              labelText: TTexts.email,
              prefixIcon: Iconsax.direct_right,
              maxLength: 30,
              controller: viewModel.emailController,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            IndividualTextFormField(
              keyboardType: TextInputType.visiblePassword,
              labelText: TTexts.password,
              prefixIcon: Iconsax.lock_14,
              suffixIcon: Iconsax.eye_slash,
              maxLength: 20,
              obscureText: true, //şifreyi gizlemek için
              controller: viewModel.passwordController,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 3),

            /// Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {}, child: const Text(TTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _signIn();
                      //viewModel.signIn(context);
                      //Navigator.pushNamed(context, RouteConstant.bottomNaviRoute);
                    },
                    child: isSignIn
                        ? const CircularProgressIndicator(
                            backgroundColor: AppColors.whiteColor,
                            color: AppColors.ratingColor,
                            strokeWidth: 3, //Kalınlığı
                            strokeAlign:
                                CircularProgressIndicator.strokeAlignCenter,
                          )
                        : Container(
                            width: double.infinity,
                            height: 20.0, // veya istediğiniz yükseklik
                            alignment: Alignment.center,
                            child: Text(TTexts.signIn,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.titleLarge)))),
          ],
        ),
      ),
    );
  }
}
