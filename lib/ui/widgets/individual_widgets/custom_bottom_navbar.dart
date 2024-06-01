import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/about/about_page.dart';
import 'package:pat_e/ui/views/contact/contact_page.dart';
import 'package:pat_e/ui/views/individualUser/home/individual_home_screen.dart';
import 'package:pat_e/ui/views/individualUser/profile_page/individual_profile_page.dart';
import 'package:pat_e/ui/views/individualUser/search_page/individual_search_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          IndividualHomeScreen(),
          IndividualProfilePage(),
          IndividualSearchPage(),
          ContactPage(),
          AboutPage(),
        ],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style3,
        // navBarStyle: NavBarStyle.style1,
        // navBarStyle: NavBarStyle.style2,
        // navBarStyle: NavBarStyle.style3,
        // navBarStyle: NavBarStyle.style5,
        // navBarStyle: NavBarStyle.style6,
        // navBarStyle: NavBarStyle.style8,
        // navBarStyle: NavBarStyle.style9,
        // navBarStyle: NavBarStyle.style11,
        // navBarStyle: NavBarStyle.style13,
        // navBarStyle: NavBarStyle.style14,
        // navBarStyle: NavBarStyle.style17,
        // navBarStyle: NavBarStyle.style18,
        backgroundColor: dark ? AppColors.dark : AppColors.whiteColor,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final dark = THelperFunctions.isDarkMode(context);
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.home_2,
          size: 24,
        ),
        title: ("Ana Sayfa"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.user,
          size: 24,
        ),
        title: ("Profil"),
        //textStyle: TextStyle(fontSize: 10),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.search_normal_1,
          size: 24,
        ), //FontAwesomeIcons.bell
        title: ("Arama"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.call,
          size: 24,
        ), //FontAwesomeIcons.bell
        title: ("İletişim"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.info_circle,
          size: 24,
        ), //FontAwesomeIcons.bell
        title: ("Hakkında"),
        activeColorPrimary:
            dark ? AppColors.whiteColor : AppColors.primaryColor,
        inactiveColorPrimary: AppColors.darkGrey,
      ),
    ];
  }
}
