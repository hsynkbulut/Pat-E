import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/viewmodel/individual_viewmodel/individual_update_lost_list_viewmodel.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/update_listings_detail_lost/widgets/individual_pick_images_lost_update.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class IndividualUpdateLostListingForm extends StatefulWidget {
  final LostAnimal lostListing;
  final IndividualUpdateLostListViewModel viewModel;

  const IndividualUpdateLostListingForm({
    super.key,
    required this.lostListing,
    required this.viewModel,
  });

  @override
  State<IndividualUpdateLostListingForm> createState() =>
      _IndividualUpdateLostListingFormState();
}

class _IndividualUpdateLostListingFormState
    extends State<IndividualUpdateLostListingForm> {
  @override
  void initState() {
    super.initState();
    // İlan bilgilerini doldurma
    widget.viewModel.selectedDate = widget.lostListing.lostDate;
    widget.viewModel.nameController.text = widget.lostListing.name;
    widget.viewModel.typeController.text = widget.lostListing.type;
    widget.viewModel.ageController.text = widget.lostListing.age;
    widget.viewModel.cityController.text = widget.lostListing.city;
    widget.viewModel.districtController.text = widget.lostListing.district;
    widget.viewModel.addressController.text = widget.lostListing.address;
    widget.viewModel.descriptionController.text =
        widget.lostListing.description;
    widget.viewModel.phoneNumberController.text =
        widget.lostListing.contactNumber;
    widget.viewModel.gender = widget.lostListing.gender;
    widget.viewModel.isLost = widget.lostListing.isLost;
    widget.viewModel.selectedImages = widget.lostListing.photos
            ?.map((photoPath) => File(photoPath))
            .toList() ??
        [];
  }

  bool _isUpdating =
      false; // Güncelleme işlemi durumunu takip etmek için bir değişken

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.viewModel.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != widget.viewModel.selectedDate) {
      setState(() {
        widget.viewModel.selectedDate = pickedDate;
      });
    }
  }

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

        // Kaybolma Tarihi
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.darkGrey,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.viewModel.selectedDate == null
                      ? 'Bir tarih seçin'
                      : 'Seçilen tarih: ${widget.viewModel.selectedDate!.day}/${widget.viewModel.selectedDate!.month}/${widget.viewModel.selectedDate!.year}',
                  style: TextStyle(
                    color: widget.viewModel.selectedDate == null
                        ? AppColors.primaryColor
                        : AppColors.black,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
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

        /// Açıklama
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.adoptionConditions,
          prefixIcon: Iconsax.document_text,
          maxLength: 400,
          minLines: 4,
          maxLines: 4,
          showCounter: true,
          controller: widget.viewModel.descriptionController,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// İlan durumu
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Bulundu',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MaterialStateColor.resolveWith((states) =>
                      dark ? AppColors.whiteColor : AppColors.primaryColor)),
            ),
            Switch(
              value: widget.viewModel.isLost,
              onChanged: (value) {
                setState(() {
                  widget.viewModel.isLost = value;
                });
              },
              activeTrackColor: AppColors.primaryColor,
              activeColor: AppColors.whiteColor,
            ),
            Text(
              'Kayıp',
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
              child: IndividualPickImagesLostUpdateScreen(
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
                          .updateLostListing(context, widget.lostListing)
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
                      strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                    )
                  : Container(
                      width: double.infinity,
                      height: 20.0, // veya istediğiniz yükseklik
                      alignment: Alignment.center,
                      child: Text(TTexts.updateAnnouncementButton,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge))),
        ),
      ],
    ));
  }
}
