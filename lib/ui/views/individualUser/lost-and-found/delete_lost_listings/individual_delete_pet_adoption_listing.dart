// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/services/lost_animal_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualDeleteLostListingScreen extends StatefulWidget {
  const IndividualDeleteLostListingScreen({super.key});

  @override
  _IndividualDeleteLostListingScreenState createState() =>
      _IndividualDeleteLostListingScreenState();
}

class _IndividualDeleteLostListingScreenState
    extends State<IndividualDeleteLostListingScreen> {
  List<LostAnimal> _lostListings = [];
  final LostAnimalService _lostListingService = LostAnimalService();

  @override
  void initState() {
    super.initState();
    getPetAdoptionListings();
  }

  Future<void> getPetAdoptionListings() async {
    try {
      List<LostAnimal> petAdoptionListings =
          await _lostListingService.getUserLostAnimals(TTexts.individualUsers);
      setState(() {
        _lostListings = petAdoptionListings;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePetAdoptionListing(int index) async {
    try {
      LostAnimal deletedPetAdoptionListing = _lostListings[index];

      await _lostListingService.deleteLostAnimal(
          deletedPetAdoptionListing.lostAnimalID!, TTexts.individualUsers);

      await _lostListingService.deletePhotos(
          deletedPetAdoptionListing.lostAnimalID!, TTexts.individualUsers);

      setState(() {
        _lostListings.removeAt(index);
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İlan silindi.'),
        ),
      );
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
          child: _lostListings.isEmpty
              ? Center(
                  child: Text(
                    TTexts.noAnnouncementDeletebutton,
                    style: TextStyle(
                      color:
                          dark ? AppColors.whiteColor : AppColors.textSecondary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _lostListings.length,
                  itemExtent: 120, // sabit yükseklik
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            backgroundColor: AppColors.success,
                            icon: Iconsax.information,
                            label: 'Detay',
                            onPressed: (context) => {}),
                      ]),
                      endActionPane:
                          ActionPane(motion: const BehindMotion(), children: [
                        SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            backgroundColor: AppColors.error,
                            icon: Iconsax.trash,
                            label: 'Sil',
                            onPressed: (context) => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('İlanı Sil'),
                                        content: const Text(
                                            'Bu ilanı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Vazgeç'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deletePetAdoptionListing(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Sil'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                })
                      ]),
                      child: Card(
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
                              _lostListings[index].photos![0],
                              width:
                                  50, // İsteğinize göre boyutları ayarlayabilirsiniz
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            _lostListings[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            _lostListings[index].type,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: Text(
                            _lostListings[index].isLost ? "Kayıp" : "Bulundu",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: _lostListings[index].isLost
                                          ? AppColors.primaryColor2
                                          : AppColors.primaryColor,
                                    ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
