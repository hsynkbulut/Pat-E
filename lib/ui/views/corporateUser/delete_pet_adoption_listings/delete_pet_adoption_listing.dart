// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class DeletePetAdoptionListingScreen extends StatefulWidget {
  const DeletePetAdoptionListingScreen({super.key});

  @override
  _DeletePetAdoptionListingScreenState createState() =>
      _DeletePetAdoptionListingScreenState();
}

class _DeletePetAdoptionListingScreenState
    extends State<DeletePetAdoptionListingScreen> {
  List<AnimalAdoption> _petAdoptionListings = [];
  final AnimalAdoptionService _petAdoptionListingService =
      AnimalAdoptionService();

  @override
  void initState() {
    super.initState();
    getPetAdoptionListings();
  }

  Future<void> getPetAdoptionListings() async {
    try {
      List<AnimalAdoption> petAdoptionListings =
          await _petAdoptionListingService
              .getUserAnimalAdoptions(TTexts.corporateUsers);
      setState(() {
        _petAdoptionListings = petAdoptionListings;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePetAdoptionListing(int index) async {
    try {
      AnimalAdoption deletedPetAdoptionListing = _petAdoptionListings[index];

      await _petAdoptionListingService.deleteAnimalAdoption(
          deletedPetAdoptionListing.animalID!, TTexts.corporateUsers);

      await _petAdoptionListingService.deletePhotos(
          deletedPetAdoptionListing.animalID!, TTexts.corporateUsers);

      setState(() {
        _petAdoptionListings.removeAt(index);
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
          CustomAppBar(showBackButton: true, userType: UserType.corporateUser),
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
                  itemCount: _petAdoptionListings.length,
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
                            label: 'Delete',
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
                              _petAdoptionListings[index].photos![0],
                              width:
                                  50, // İsteğinize göre boyutları ayarlayabilirsiniz
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            _petAdoptionListings[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: _petAdoptionListings[index].isAdopted
                                      ? AppColors.primaryColor
                                      : AppColors.primaryColor2,
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
