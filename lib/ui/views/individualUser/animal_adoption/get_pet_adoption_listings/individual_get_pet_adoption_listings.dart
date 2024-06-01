// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualGetPetAdoptionListingScreen extends StatefulWidget {
  const IndividualGetPetAdoptionListingScreen({super.key});

  @override
  _IndividualGetPetAdoptionListingScreenState createState() =>
      _IndividualGetPetAdoptionListingScreenState();
}

class _IndividualGetPetAdoptionListingScreenState
    extends State<IndividualGetPetAdoptionListingScreen> {
  List<AnimalAdoption> _petAdoptionListings = [];

  @override
  void initState() {
    super.initState();
    getHouseListings();
  }

  Future<void> getHouseListings() async {
    try {
      List<AnimalAdoption> petAdoptionListings = await AnimalAdoptionService()
          .getUserAnimalAdoptions(TTexts.individualUsers);
      setState(() {
        _petAdoptionListings = petAdoptionListings;
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
    //final Size screenSize = THelperFunctions.screenSize(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar:
          CustomAppBar(showBackButton: true, userType: UserType.individualUser),
      body: Container(
        padding: const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: _petAdoptionListings.isEmpty
              ? Center(
                  child: Text(
                    TTexts.noMyAnnouncementbutton,
                    style: TextStyle(
                      color:
                          dark ? AppColors.whiteColor : AppColors.textSecondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _petAdoptionListings.length,
                  itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.014),
                    color: AppColors.ratingColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(height * 0.01),
                      title: Text(
                        _petAdoptionListings[index].name,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _petAdoptionListings[index].type,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        _petAdoptionListings[index].isAdopted
                            ? "Sahiplendirildi"
                            : "Bekliyor",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: _petAdoptionListings[index].isAdopted
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor2,
                            ),
                      ),
                      leading: Container(
                        width:
                            90, // İsteğinize göre boyutları ayarlayabilirsiniz
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors
                                .whiteColor, // Kenarlık rengini ayarlayabilirsiniz
                            width: 3, // Kenarlık kalınlığını ayarlayabilirsiniz
                          ),
                        ),
                        child: Image.network(
                          _petAdoptionListings[index].photos![0],
                          width:
                              50, // İsteğinize göre boyutları ayarlayabilirsiniz
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _petAdoptionListings[index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // ignore: unnecessary_string_interpolations
                                    Text(
                                        'Türü: ${_petAdoptionListings[index].type}'),
                                    SizedBox(height: 8),
                                    Text(
                                        '${_petAdoptionListings[index].age} yaşında, ${_petAdoptionListings[index].gender}'),
                                    SizedBox(height: 8),
                                    Text(
                                        'İletişim Numarası: ${_petAdoptionListings[index].contactNumber}'),
                                    Text(
                                        'Sahiplendirme Koşulları: ${_petAdoptionListings[index].adoptionConditions}'),
                                    SizedBox(height: 16),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _petAdoptionListings[index]
                                            .photos!
                                            .length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              _petAdoptionListings[index]
                                                  .photos![i],
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Tamam'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
