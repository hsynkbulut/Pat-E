import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/viewmodel/authentication/individual/register_viewmodel_individual.dart';
import 'package:pat_e/ui/views/individualUser/auth/signup/widgets/individual_signup_form.dart';

class IndividualSignupScreen extends StatefulWidget {
  const IndividualSignupScreen({super.key});

  @override
  State<IndividualSignupScreen> createState() => _IndividualSignupScreenState();
}

class _IndividualSignupScreenState extends State<IndividualSignupScreen> {
  RegisterViewModelIndividual viewModel = RegisterViewModelIndividual();

  File? _profilePhoto;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _selectProfilePhoto() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);

        // Burada viewModel.profilePhoto'ya da atama yapılmalı:
        viewModel.profilePhoto = _profilePhoto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.whiteColor,
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 5), //TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _profilePhoto != null
                      ? CircleAvatar(
                          radius: 65,
                          backgroundImage: FileImage(_profilePhoto!),
                          child: GestureDetector(
                            onTap: _selectProfilePhoto,
                            child: Container(
                              width: width * 0.1,
                              height: height * 0.045,
                              margin: const EdgeInsets.only(
                                left: 80,
                                top: 70,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Iconsax.gallery_edit,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 65,
                          backgroundColor:
                              dark ? AppColors.black : AppColors.primaryColor,
                          child: GestureDetector(
                            onTap: _selectProfilePhoto,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Iconsax.gallery_add,
                                    color: dark
                                        ? Colors.white
                                        : AppColors.whiteColor,
                                    size: 65,
                                  ),
                                ),
                                Container(
                                  width: width * 0.1,
                                  height: height * 0.045,
                                  margin: const EdgeInsets.only(
                                    left: 90,
                                    top: 85,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    Iconsax.gallery_edit,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),

                  /// Title
                  Text(TTexts.signUpTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dark
                                  ? AppColors.whiteColor
                                  : AppColors.darkerGrey)),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),
                ],
              ),

              /// Form
              IndividualSignupForm(profilePhoto: _profilePhoto),
            ],
          ),
        ),
      ),
    );
  }
}
