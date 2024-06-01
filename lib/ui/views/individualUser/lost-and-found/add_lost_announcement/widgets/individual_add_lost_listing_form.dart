import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/sizes.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/viewmodel/individual_viewmodel/individual_add_lost_list_viewmodel.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/add_lost_announcement/widgets/individual_pick_images_lost_screen.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_text_form_field.dart';

class IndividualAddLostListingForm extends StatefulWidget {
  const IndividualAddLostListingForm({
    super.key,
  });

  @override
  State<IndividualAddLostListingForm> createState() =>
      _IndividualAddLostListingFormState();
}

class _IndividualAddLostListingFormState
    extends State<IndividualAddLostListingForm> {
  //final viewModel = AddHouseListViewModel();
  final IndividualAddLostListViewModel viewModel =
      IndividualAddLostListViewModel();
  bool isAddListing = false;

  void _createLostListing(BuildContext context) async {
    setState(() {
      isAddListing = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.createLostListing(context);

    setState(() {
      isAddListing = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != viewModel.selectedDate) {
      setState(() {
        viewModel.selectedDate = pickedDate;
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
          controller: viewModel.typeController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Adı
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.animalName,
          prefixIcon: Iconsax.activity5,
          maxLength: 30,
          controller: viewModel.nameController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Yaşı
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.animalAge,
          prefixIcon: Icons.date_range,
          maxLength: 30,
          controller: viewModel.ageController,
          maxLines: 1, //max. 1 satır yüksekliğinde
        ),
        //const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Cinsiyeti
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              value: 'Dişi',
              groupValue: viewModel.gender,
              onChanged: (value) {
                setState(() {
                  viewModel.gender = value!;
                });
              },
            ),
            const Text(
              'Dişi',
            ),
            Radio<String>(
              value: 'Erkek',
              groupValue: viewModel.gender,
              onChanged: (value) {
                setState(() {
                  viewModel.gender = value!;
                });
              },
            ),
            const Text(
              'Erkek',
            ),
          ],
        ),
        // const SizedBox(height: TSizes.spaceBtwInputFields),

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
                  viewModel.selectedDate == null
                      ? 'Bir tarih seçin'
                      : 'Seçilen tarih: ${viewModel.selectedDate!.day}/${viewModel.selectedDate!.month}/${viewModel.selectedDate!.year}',
                  style: TextStyle(
                    color: viewModel.selectedDate == null
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

        /// Açıklama
        IndividualTextFormField(
          keyboardType: TextInputType.text,
          labelText: TTexts.description,
          prefixIcon: Iconsax.document_text,
          maxLength: 400,
          minLines: 4,
          maxLines: 4,
          showCounter: true,
          controller: viewModel.descriptionController,
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
              value: viewModel.isLost,
              onChanged: (value) {
                setState(() {
                  viewModel.isLost = value;
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
          controller: viewModel.phoneNumberController,
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
              child: IndividualPickImagesLostScreen(viewModel: viewModel),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Create Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  //viewModel.createPetAdoptionListing(context);
                  _createLostListing(context);
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryColor)),
                child: isAddListing
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
                        child: Text(TTexts.createListingTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge)))),
      ],
    ));
  }
}
