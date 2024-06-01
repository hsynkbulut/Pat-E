// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';
import 'package:pat_e/ui/views/onboard/onboarding_screen.dart';
import 'package:pat_e/ui/views/chooseProfile/choose_profile.dart';
import 'package:pat_e/ui/views/about/about_page.dart';
import 'package:pat_e/ui/views/corporateUser/add_adoption_announcement/add_pet_adoption_listings.dart';
import 'package:pat_e/ui/views/corporateUser/auth/corporate_tabbar_auth_screen.dart';
import 'package:pat_e/ui/views/corporateUser/delete_pet_adoption_listings/delete_pet_adoption_listing.dart';
import 'package:pat_e/ui/views/corporateUser/get_pet_adoption_listings/get_pet_adoption_listings.dart';
import 'package:pat_e/ui/views/corporateUser/home/corporate_home_screen.dart';
import 'package:pat_e/ui/views/corporateUser/profile_page/corporate_profile_page.dart';
import 'package:pat_e/ui/views/corporateUser/update_pet_adoption_listings/update_pet_adoption_listing.dart';
import 'package:pat_e/ui/views/individualUser/auth/individual_tabbar_auth_screen.dart';
import 'package:pat_e/ui/widgets/individual_widgets/bottom_navbar_yedek.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.onBoardScreenRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteConstant.chooseProfileRoute:
        return MaterialPageRoute(builder: (_) => const ChooseProfile());
      case RouteConstant.tabbarIndividualAuthRoute:
        return MaterialPageRoute(
            builder: (_) => const IndividualTabbarAuthScreen());
      case RouteConstant.tabbarCorporateAuthRoute:
        return MaterialPageRoute(
            builder: (_) => const CorporateTabbarAuthScreen());
      case RouteConstant.corporateDashboardRoute:
        return MaterialPageRoute(builder: (_) => CorporateHomeScreen());
      case RouteConstant.corporateProfileRoute:
        return MaterialPageRoute(builder: (_) => CorporateProfilePage());
      case RouteConstant.aboutScreenRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case RouteConstant.corporateAddAnimalAdoptionRoute:
        return MaterialPageRoute(
            builder: (_) => AddPetAdoptionListingsScreen());
      case RouteConstant.corporateGetPetAdoptionListingRoute:
        return MaterialPageRoute(builder: (_) => GetPetAdoptionListingScreen());
      case RouteConstant.corporateUpdatePetAdoptionListingRoute:
        return MaterialPageRoute(
            builder: (_) => UpdatePetAdoptionListingScreen());
      case RouteConstant.corporateDeletePetAdoptionListingRoute:
        return MaterialPageRoute(
            builder: (_) => DeletePetAdoptionListingScreen());
      case RouteConstant.individualBottomNavbarRoute:
        return MaterialPageRoute(
            builder: (_) => BottomNavBarYedek(selectedIndex: 0));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Ters giden birşeyler oldu'),
            ),
          ),
        );
    }
  }
}
