// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/individual_adopt_pet_detail.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualAdoptPetPage extends StatefulWidget {
  const IndividualAdoptPetPage({super.key});

  @override
  State<IndividualAdoptPetPage> createState() => _IndividualAdoptPetPageState();
}

class _IndividualAdoptPetPageState extends State<IndividualAdoptPetPage> {
  List<AnimalAdoption> _animals = [];

  @override
  void initState() {
    super.initState();
    getAnimals();
  }

  Future<void> getAnimals() async {
    try {
      List<AnimalAdoption> animals =
          await AnimalAdoptionService().getAnimalAdoptions();
      setState(() {
        _animals = animals;
      });
    } catch (e) {
      print(e.toString());
    }
  }

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
        padding: const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: _animals.isEmpty
              ? const Center(
                  child: Text(
                    TTexts.noAnnouncementbutton,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _animals.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.014),
                      color: AppColors.ratingColor,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(height * 0.01),
                        leading: Container(
                          width:
                              90, // İsteğinize göre boyutları ayarlayabilirsiniz
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors
                                  .whiteColor, // Kenarlık rengini ayarlayabilirsiniz
                              width:
                                  3, // Kenarlık kalınlığını ayarlayabilirsiniz
                            ),
                          ),
                          child: Image.network(
                            _animals[index].photos![0],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          _animals[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        subtitle: Text(
                          _animals[index].type,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        trailing: Text(
                          _animals[index].isAdopted
                              ? 'Sahiplendirildi'
                              : 'Bekliyor',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: _animals[index].isAdopted
                                        ? AppColors.primaryColor
                                        : AppColors.primaryColor2,
                                  ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  IndividualAdoptPetPageDetail(
                                animalAdoption: _animals[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
