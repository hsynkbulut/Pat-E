import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/models/corporate_model.dart';
import 'package:pat_e/core/viewmodel/corporate_viewmodel/corporate_edit_profile_viewmodel.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class CorporateEditProfileForm extends StatefulWidget {
  final Corporate corporate;
  const CorporateEditProfileForm({
    super.key,
    required this.corporate,
  });

  @override
  State<CorporateEditProfileForm> createState() =>
      _CorporateEditProfileFormState();
}

class _CorporateEditProfileFormState extends State<CorporateEditProfileForm> {
  CorporateEditProfileViewModel viewModel = CorporateEditProfileViewModel();
  bool isLoading = false; // Bayrak değişkeni tanımla

  void _handleUpdate() async {
    setState(() {
      isLoading = true; // İşlem başladığında bayrağı true yap
    });

    // ViewModel'deki güncelleme metodunu burada çağırabilirsiniz
    await viewModel.updateSignUp(context, widget.corporate);

    setState(() {
      isLoading = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  void initState() {
    super.initState();
    //userIdController.text = widget.homeOwner.userID!;
    viewModel.nameController.text = widget.corporate.name;
    viewModel.emailController.text = widget.corporate.email;
    viewModel.phoneNumberController.text = widget.corporate.phoneNumber;
    viewModel.passwordController.text = widget.corporate.password;
    viewModel.cityController.text = widget.corporate.city;
    viewModel.districtController.text = widget.corporate.district;
    viewModel.addressController.text = widget.corporate.address;
    //viewModel.profilePhoto = File(widget.corporate.profilePhoto!);
  }

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Foundation Name
            IndividualTextFormField(
              keyboardType: TextInputType.text,
              labelText: TTexts.foundationName,
              prefixIcon: Iconsax.building,
              maxLength: 20,
              controller: viewModel.nameController,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

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

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //viewModel.updateSignUp(context, widget.homeOwner);
                      _handleUpdate(); // Güncelleme işlemini başlatan metod
                    },
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor)),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            backgroundColor: AppColors.whiteColor,
                            color: AppColors.ratingColor,
                            strokeWidth: 3, //Kalınlığı
                            strokeAlign:
                                CircularProgressIndicator.strokeAlignCenter,
                          )
                        : Container(
                            width: double.infinity,
                            height: 20.0,
                            alignment: Alignment.center,
                            child: Text(TTexts.updateButton,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.titleLarge)))),
          ],
        ),
      ),
    );
  }
}
