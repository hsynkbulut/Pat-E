import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/viewmodel/authentication/corporate/register_viewmodel_corporate.dart';
import 'package:pat_e/ui/widgets/corporate_widgets/corporate_text_form_field.dart';
import 'package:iconsax/iconsax.dart';

class CorporateSignupForm extends StatefulWidget {
  final File? profilePhoto; // Profil fotoğrafı parametresi eklendi

  const CorporateSignupForm({
    super.key,
    this.profilePhoto,
  });

  @override
  State<CorporateSignupForm> createState() => _CorporateSignupFormState();
}

class _CorporateSignupFormState extends State<CorporateSignupForm> {
  RegisterViewModelCorporate viewModel = RegisterViewModelCorporate();
  bool isSignUp = false; // Bayrak tanımlama

  void _signUp() async {
    setState(() {
      isSignUp = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    viewModel.profilePhoto =
        widget.profilePhoto; // viewModel içindeki profilePhoto'ya resmi atama
    await viewModel.signUp(context);

    setState(() {
      isSignUp = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        /// Foundation Name
        CorporateTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.foundationName,
          prefixIcon: Iconsax.building,
          maxLength: 20,
          controller: viewModel.nameController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Email
        CorporateTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
          maxLength: 30,
          controller: viewModel.emailController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Password
        CorporateTextFormField(
          keyboardType: TextInputType.visiblePassword,
          labelText: TTexts.password,
          prefixIcon: Iconsax.lock_14,
          suffixIcon: Iconsax.eye_slash,
          maxLength: 20,
          obscureText: true, //şifreyi gizlemek için
          controller: viewModel.passwordController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Phone Number
        CorporateTextFormField(
          keyboardType: TextInputType.phone,
          labelText: TTexts.phoneNo,
          prefixIcon: Iconsax.call,
          maxLength: 11,
          controller: viewModel.phoneNumberController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// City & District
        Row(
          children: [
            Expanded(
              child: CorporateTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.city,
                prefixIcon: Iconsax.buildings,
                maxLength: 16,
                controller: viewModel.cityController,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: CorporateTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.district,
                prefixIcon: Iconsax.buildings,
                maxLength: 20,
                controller: viewModel.districtController,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Address
        CorporateTextFormField(
          keyboardType: TextInputType.multiline,
          labelText: TTexts.address,
          prefixIcon: Iconsax.buildings,
          maxLength: 120,
          maxLines: 4,
          showCounter: true,
          controller: viewModel.addressController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Sign Up Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _signUp();
                /*
                viewModel.profilePhoto = widget
                    .profilePhoto; // viewModel içindeki profilePhoto'ya resmi atama
                viewModel.signUp(context);
                */
                //Navigator.pushNamed(context, RouteConstant.hostDashboardRoute);
              },
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.primaryColor2)),
              child: isSignUp
                  ? const CircularProgressIndicator(
                      backgroundColor: AppColors.whiteColor,
                      color: AppColors.ratingColor,
                      strokeWidth: 3, //Kalınlığı
                      strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                    )
                  : const Text(TTexts.createAccount)),
        )
      ],
    ));
  }
}
