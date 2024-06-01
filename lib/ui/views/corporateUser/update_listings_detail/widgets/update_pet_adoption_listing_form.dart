import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/viewmodel/corporate_viewmodel/corporate_update_pet_adoption_list_viewmodel.dart';
import 'package:pat_e/ui/views/corporateUser/update_listings_detail/widgets/corporate_pick_images_adoption_update.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class UpdatePetAdoptionListingForm extends StatefulWidget {
  final AnimalAdoption houseListing;
  final CorporateUpdatePetAdoptionListViewModel viewModel;

  const UpdatePetAdoptionListingForm({
    super.key,
    required this.houseListing,
    required this.viewModel,
  });

  @override
  State<UpdatePetAdoptionListingForm> createState() =>
      _UpdatePetAdoptionListingFormState();
}

class _UpdatePetAdoptionListingFormState
    extends State<UpdatePetAdoptionListingForm> {
  @override
  void initState() {
    super.initState();
    // İlan bilgilerini doldurma
    widget.viewModel.nameController.text = widget.houseListing.name;
    widget.viewModel.typeController.text = widget.houseListing.type;
    widget.viewModel.ageController.text = widget.houseListing.age;
    widget.viewModel.cityController.text = widget.houseListing.city;
    widget.viewModel.districtController.text = widget.houseListing.district;
    widget.viewModel.addressController.text = widget.houseListing.address;
    widget.viewModel.adoptionConditionsController.text =
        widget.houseListing.adoptionConditions;
    widget.viewModel.phoneNumberController.text =
        widget.houseListing.contactNumber;
    widget.viewModel.gender = widget.houseListing.gender;
    widget.viewModel.isAdopted = widget.houseListing.isAdopted;
    widget.viewModel.selectedImages = widget.houseListing.photos
            ?.map((photoPath) => File(photoPath))
            .toList() ??
        [];
  }

  bool _isUpdating =
      false; // Güncelleme işlemi durumunu takip etmek için bir değişken

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    //final Size screenSize = THelperFunctions.screenSize(context);

    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İLAN DETAYLARI',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.dark,
                fontFamily: 'SignikaNegative',
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(
          thickness: 2,
          color: dark ? AppColors.whiteColor : AppColors.grey,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Türü
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.animalType,
          prefixIcon: Iconsax.pet5, //textalign_center,
          maxLength: 30,
          controller: widget.viewModel.typeController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Adı
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.animalName,
          prefixIcon: Iconsax.activity5,
          maxLength: 30,
          controller: widget.viewModel.nameController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Yaşı
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.animalAge,
          prefixIcon: Icons.date_range,
          maxLength: 30,
          controller: widget.viewModel.ageController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              value: 'Dişi',
              groupValue: widget.viewModel.gender,
              onChanged: (value) {
                setState(() {
                  widget.viewModel.gender = value!;
                });
              },
            ),
            const Text(
              'Dişi',
            ),
            Radio<String>(
              value: 'Erkek',
              groupValue: widget.viewModel.gender,
              onChanged: (value) {
                setState(() {
                  widget.viewModel.gender = value!;
                });
              },
            ),
            const Text(
              'Erkek',
            ),
          ],
        ),

        /// City & District
        Row(
          children: [
            Expanded(
              child: IndividualTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.city,
                prefixIcon: Iconsax.buildings,
                maxLength: 16,
                controller: widget.viewModel.cityController,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: IndividualTextFormField(
                keyboardType: TextInputType.text,
                labelText: TTexts.district,
                prefixIcon: Iconsax.buildings,
                maxLength: 20,
                controller: widget.viewModel.districtController,
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
          controller: widget.viewModel.addressController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Sahiplendirme Koşulları
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.adoptionConditions,
          prefixIcon: Iconsax.document_text,
          maxLength: 400,
          minLines: 4,
          maxLines: 4,
          showCounter: true,
          controller: widget.viewModel.adoptionConditionsController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlan durumu
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Sahibini Bekliyor',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MaterialStateColor.resolveWith((states) =>
                      dark ? AppColors.whiteColor : AppColors.primaryColor)),
            ),
            Switch(
              value: widget.viewModel.isAdopted,
              onChanged: (value) {
                setState(() {
                  widget.viewModel.isAdopted = value;
                });
              },
              activeTrackColor: AppColors.primaryColor,
              activeColor: AppColors.whiteColor,
            ),
            Text(
              'Sahiplendirildi',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MaterialStateColor.resolveWith((states) =>
                      dark ? AppColors.whiteColor : AppColors.primaryColor)),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Text(
          'İLETİŞİM BİLGİLERİ',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: dark ? AppColors.whiteColor : AppColors.dark,
                fontFamily: 'SignikaNegative',
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(
          thickness: 2,
          color: dark ? AppColors.whiteColor : AppColors.grey,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Telefon no
        IndividualTextFormField(
          keyboardType: TextInputType.phone,
          labelText: TTexts.phoneNo,
          prefixIcon: Iconsax.call,
          maxLength: 11,
          controller: widget.viewModel.phoneNumberController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FOTOĞRAF',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: dark ? AppColors.whiteColor : AppColors.dark,
                    fontFamily: 'SignikaNegative',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Divider(
              thickness: 2,
              color: dark ? AppColors.whiteColor : AppColors.grey,
            ),
            //const SizedBox(height: TSizes.spaceBtwInputFields),
            SizedBox(
              height: height * 0.32, // İstediğiniz boyutu ayarlayabilirsiniz
              width: width * 0.9,
              child: CorporatePickImagesAdoptionUpdateScreen(
                  viewModel: widget.viewModel),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _isUpdating
                    ? null // Güncelleme işlemi sırasında butona tıklamayı engeller
                    : () {
                        setState(() {
                          _isUpdating = true; // Güncelleme işlemini başlat
                        });
                        widget.viewModel
                            .updateHouseListing(context, widget.houseListing)
                            .then((_) {
                          setState(() {
                            _isUpdating = false; // Güncelleme işlemi tamamlandı
                          });
                        });
                      },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryColor)),
                child: _isUpdating
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.whiteColor,
                        color: AppColors.ratingColor,
                        strokeWidth: 3,
                        strokeAlign:
                            CircularProgressIndicator.strokeAlignCenter,
                      )
                    : Container(
                        width: double.infinity,
                        height: 20.0, // veya istediğiniz yükseklik
                        alignment: Alignment.center,
                        child: Text(TTexts.updateAnnouncementButton,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge)))),
      ],
    ));
  }
}
