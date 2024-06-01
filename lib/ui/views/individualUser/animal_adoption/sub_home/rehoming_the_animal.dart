import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/add_adoption_announcement/individual_add_pet_adoption_listings.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/delete_pet_adoption_listings/individual_delete_pet_adoption_listing.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/get_pet_adoption_listings/individual_get_pet_adoption_listings.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/update_pet_adoption_listings/individual_update_pet_adoption_listing.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/individual_widgets/individual_item_dashboard.dart';

class RehomingTheAnimal extends StatefulWidget {
  const RehomingTheAnimal({super.key});

  @override
  State<RehomingTheAnimal> createState() => _RehomingTheAnimalState();
}

class _RehomingTheAnimalState extends State<RehomingTheAnimal> {
  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.bColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.03),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.07),
                  title: const Text(TTexts.petAdoptPage,
                      style: TextStyle(
                          fontFamily: 'OhChewy',
                          fontSize: 40,
                          color: AppColors.ratingColor)),
                  subtitle: const Text(TTexts.currentPage,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.bColor)),
                ),
                SizedBox(height: height * 0.03)
              ],
            ),
          ),
          Container(
            color: AppColors.primaryColor,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.07, vertical: height * 0.04),
              decoration: const BoxDecoration(
                  color: AppColors.bColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                children: [
                  IndividualItemDashboard(
                    context: context,
                    title: TTexts.createAnnouncementButton,
                    iconData: CupertinoIcons.add,
                    background: AppColors.primaryColor,
                    page:
                        const IndividualAddPetAdoptionListingsScreen(), //AddPetAdoptionAnnouncement(),
                  ),
                  IndividualItemDashboard(
                    context: context,
                    title: TTexts.updateAnnouncementButton,
                    iconData: CupertinoIcons.arrow_clockwise,
                    background: AppColors.primaryColor,
                    page:
                        const IndividualUpdatePetAdoptionListingScreen(), //const UpdateAdoptionList(),
                  ),
                  IndividualItemDashboard(
                    context: context,
                    title: TTexts.deleteAnnouncementButton,
                    iconData: CupertinoIcons.delete,
                    background: AppColors.primaryColor,
                    page:
                        const IndividualDeletePetAdoptionListingScreen(), // const DeleteAdoptionAnnouncement(),
                  ),
                  IndividualItemDashboard(
                    context: context,
                    title: TTexts.getMyAnnouncementsButton,
                    iconData: CupertinoIcons.doc_text_fill,
                    background: AppColors.primaryColor,
                    page:
                        const IndividualGetPetAdoptionListingScreen(), // const ViewMyAdoptionAnnouncement(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.bColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Spacer(flex: 2),
          ),
          SizedBox(height: height * 0.01),
          Container(
            color: AppColors.bColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.01),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: height * 0.005,
                mainAxisSpacing: 30,
                children: const [Spacer(flex: 2)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
