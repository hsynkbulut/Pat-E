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
import 'package:pat_e/core/viewmodel/individual_viewmodel/individual_update_lost_list_viewmodel.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/update_listings_detail_lost/individual_update_lost_listing_detail.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualUpdateLostListingScreen extends StatefulWidget {
  const IndividualUpdateLostListingScreen({super.key});

  @override
  _IndividualUpdateLostListingScreenState createState() =>
      _IndividualUpdateLostListingScreenState();
}

class _IndividualUpdateLostListingScreenState
    extends State<IndividualUpdateLostListingScreen> {
  List<LostAnimal> _lostAnimalListings = [];
  final LostAnimalService _lostListingService = LostAnimalService();
  IndividualUpdateLostListViewModel viewModel =
      IndividualUpdateLostListViewModel();

  @override
  void initState() {
    super.initState();
    getLostListings();
  }

  Future<void> getLostListings() async {
    try {
      List<LostAnimal> lostAnimalListings =
          await _lostListingService.getUserLostAnimals(TTexts.individualUsers);
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
                    TTexts.noAnnouncementUpdatebutton,
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
                  itemExtent: 120, // sabit yükseklik
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            backgroundColor: AppColors.success,
                            icon: Iconsax.information,
                            label: TTexts.detailButton,
                            onPressed: (context) => {}),
                      ]),
                      endActionPane:
                          ActionPane(motion: const BehindMotion(), children: [
                        SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            backgroundColor: AppColors.info,
                            icon: Iconsax.refresh,
                            label: TTexts.updateButton,
                            onPressed: (context) => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IndividualUpdateLostListingDetailScreen(
                                              lostListing:
                                                  _lostAnimalListings[index],
                                              viewModel: viewModel,
                                            )),
                                  ),
                                }),
                      ]),
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.014),
                        color: AppColors.ratingColor,
                        child: ListTile(
                          //dense: true,
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
                              _lostAnimalListings[index].photos![0],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            _lostAnimalListings[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            _lostAnimalListings[index].type,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: Text(
                            _lostAnimalListings[index].isLost
                                ? "Kayıp"
                                : "Bulundu",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: _lostAnimalListings[index].isLost
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
