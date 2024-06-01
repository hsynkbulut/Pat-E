// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/services/lost_animal_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualGetLostListingScreen extends StatefulWidget {
  const IndividualGetLostListingScreen({super.key});

  @override
  _IndividualGetLostListingScreenState createState() =>
      _IndividualGetLostListingScreenState();
}

class _IndividualGetLostListingScreenState
    extends State<IndividualGetLostListingScreen> {
  List<LostAnimal> _lostAnimalListings = [];

  @override
  void initState() {
    super.initState();
    getLostListings();
  }

  Future<void> getLostListings() async {
    try {
      List<LostAnimal> lostAnimalListings =
          await LostAnimalService().getUserLostAnimals(TTexts.individualUsers);
      setState(() {
        _lostAnimalListings = lostAnimalListings;
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
          child: _lostAnimalListings.isEmpty
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
                  itemCount: _lostAnimalListings.length,
                  itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.014),
                    color: AppColors.ratingColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(height * 0.01),
                      title: Text(
                        _lostAnimalListings[index].name,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _lostAnimalListings[index].type,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        _lostAnimalListings[index].isLost ? "Kayıp" : "Bulundu",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: _lostAnimalListings[index].isLost
                                  ? AppColors.primaryColor2
                                  : AppColors.primaryColor,
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
                          _lostAnimalListings[index].photos![0],
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
                                      _lostAnimalListings[index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // ignore: unnecessary_string_interpolations
                                    Text(
                                        'Türü: ${_lostAnimalListings[index].type}'),
                                    SizedBox(height: 8),
                                    Text(
                                        '${_lostAnimalListings[index].age} yaşında, ${_lostAnimalListings[index].gender}'),
                                    SizedBox(height: 8),
                                    Text(
                                        'İletişim Numarası: ${_lostAnimalListings[index].contactNumber}'),
                                    Text(
                                        'Açıklama: ${_lostAnimalListings[index].description}'),
                                    SizedBox(height: 16),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _lostAnimalListings[index]
                                            .photos!
                                            .length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              _lostAnimalListings[index]
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
