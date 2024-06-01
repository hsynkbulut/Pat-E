import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/viewmodel/authentication/individual/register_viewmodel_individual.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class IndividualSignupForm extends StatefulWidget {
  final File? profilePhoto; // Profil fotoğrafı parametresi eklendi

  const IndividualSignupForm({
    super.key,
    this.profilePhoto,
  });

  @override
  State<IndividualSignupForm> createState() => _IndividualSignupFormState();
}

class _IndividualSignupFormState extends State<IndividualSignupForm> {
  RegisterViewModelIndividual viewModel = RegisterViewModelIndividual();
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
        /// Name
        IndividualTextFormField(
          keyboardType: TextInputType.name,
          labelText: TTexts.nameSurname,
          prefixIcon: Iconsax.user,
          maxLength: 20,
          controller: viewModel.nameController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Email
        IndividualTextFormField(
          keyboardType: TextInputType.emailAddress,
          labelText: TTexts.email,
          prefixIcon: Iconsax.direct,
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
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Phone Number
        IndividualTextFormField(
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
              child: IndividualTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.city,
                prefixIcon: Iconsax.buildings,
                maxLength: 16,
                controller: viewModel.cityController,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: IndividualTextFormField(
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
        IndividualTextFormField(
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
                      (states) => AppColors.primaryColor)),
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
