import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/common/styles/spacing_styles.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/explore_carousel_slider.dart';

class IndividualSearchForLostDetail extends StatefulWidget {
  final LostAnimal lostAnimal;

  const IndividualSearchForLostDetail({super.key, required this.lostAnimal});

  @override
  State<IndividualSearchForLostDetail> createState() =>
      _IndividualSearchForLostDetailState();
}

class _IndividualSearchForLostDetailState
    extends State<IndividualSearchForLostDetail> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(height * 0.006),
                child: ExploreCarouselSlider(
                  images: widget.lostAnimal.photos!,
                ),
              ),
              SizedBox(height: height * 0.005),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //adding and Rating function
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.lostAnimal.name,
                              style: TextStyle(
                                color: dark
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: height * 0.003),
                            Row(
                              children: [
                                const Icon(
                                  Icons.info,
                                  color: AppColors.darkGrey,
                                  size: 21,
                                ),
                                SizedBox(width: width * 0.01),
                                Text(
                                  widget.lostAnimal.isLost
                                      ? 'Kayıp'
                                      : 'Bulundu',
                                  style: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(height * 0.011),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Iconsax.heart,
                            size: 26,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColors.grey,
                      height: height * 0.04,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: dark ? AppColors.dark : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.grey, width: 2)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Açıklama',
                              style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.lostAnimal.description,
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    dark ? AppColors.grey : AppColors.darkGrey,
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              'Adres',
                              style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.lostAnimal.address,
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    dark ? AppColors.grey : AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //const SizedBox(height: 25.0),
                    Divider(
                      thickness: 2,
                      color: AppColors.grey,
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pets_outlined,
                                size: 26,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                widget.lostAnimal.type,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 26,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                widget.lostAnimal.age,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.transgender_outlined,
                                size: 26,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                widget.lostAnimal.gender,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.buildings,
                                size: 26,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                widget.lostAnimal.city,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.buildings_2,
                                size: 26,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              Text(
                                widget.lostAnimal.district,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.11,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Kaybolma Tarihi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                THelperFunctions.formatDateBydMMMYYYY2(
                                    widget.lostAnimal.lostDate),
                                style: TextStyle(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColors.grey,
                      height: height * 0.04,
                    ),
                    // const SizedBox(height: 25.0),
                    Container(
                      height: height * 0.23,
                      //width: width * 0.9,
                      decoration: BoxDecoration(
                          color: dark ? AppColors.dark : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.grey, width: 2)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: height * 0.11,
                                  height: height * 0.11,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.9),
                                      width: 3,
                                    ),
                                    shape: BoxShape.circle,
                                    color: AppColors.whiteColor,
                                    //borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      ImagePaths.animalShelter,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.023),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'İlan Sahibi',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: dark
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Telefon no: ',
                                          style: TextStyle(
                                              color: dark
                                                  ? AppColors.grey
                                                  : AppColors.darkerGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          widget.lostAnimal.contactNumber,
                                          style: TextStyle(
                                              color: dark
                                                  ? AppColors.grey
                                                  : AppColors.darkerGrey,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await THelperFunctions.launchPhoneNumber(
                                      widget.lostAnimal.contactNumber);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  'İletişim',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPetFeature(String value, String feature) {
    return Expanded(
      child: Container(
        height: 75,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              feature,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
