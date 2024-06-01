// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/about/about_page.dart';
import 'package:pat_e/ui/views/contact/contact_page.dart';
import 'package:pat_e/ui/views/individualUser/home/individual_home_screen.dart';
import 'package:pat_e/ui/views/individualUser/profile_page/individual_profile_page.dart';
import 'package:pat_e/ui/views/individualUser/search_page/individual_search_page.dart';

class BottomNavBarYedek extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBarYedek({super.key, required this.selectedIndex});

  @override
  State<BottomNavBarYedek> createState() => _BottomNavBarYedekState();
}

class _BottomNavBarYedekState extends State<BottomNavBarYedek> {
  int currentIndex = 0;

  void onItemTapped(int index) => setState(() => currentIndex = index);

  @override
  void initState() {
    currentIndex = widget.selectedIndex;
    super.initState();
  }

  final List<Widget> pages = [
    const IndividualHomeScreen(),
    const IndividualProfilePage(),
    const IndividualSearchPage(),
    const ContactPage(),
    const AboutPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    var currentScreen = pages[currentIndex];

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        splashColor: AppColors.ratingColor,
        child: const Icon(Iconsax.search_normal_1),
        onPressed: () => setState(() {
          currentIndex = 2;
          currentScreen = const IndividualSearchPage();
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavBarItem(
                icon: Iconsax.home_2,
                label: TTexts.homePageName,
                isSelected: currentIndex == 0,
                onPressed: () => onItemTapped(0),
              ),
              NavBarItem(
                icon: Iconsax.user,
                label: TTexts.profilePageName,
                isSelected: currentIndex == 1,
                onPressed: () => onItemTapped(1),
              ),
              const Spacer(),
              NavBarItem(
                icon: Iconsax.call,
                label: TTexts.contactPageName,
                isSelected: currentIndex == 3,
                onPressed: () => onItemTapped(3),
              ),
              NavBarItem(
                icon: Iconsax.info_circle,
                label: TTexts.aboutPageName,
                isSelected: currentIndex == 4,
                onPressed: () => onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    return MaterialButton(
      minWidth: 50,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.whiteColor : AppColors.grey,
          ),
          SizedBox(height: height * 0.012),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.whiteColor : AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}

/* ESKİSİ BU AŞAĞIDA
// ignore: must_be_immutable
class BottomNavbarYedek extends StatefulWidget {
  int selectedIndex = 0;
  BottomNavbarYedek({super.key, required this.selectedIndex});

  @override
  State<BottomNavbarYedek> createState() => _BottomNavbarYedekState();
}

class _BottomNavbarYedekState extends State<BottomNavbarYedek> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    super.initState();
  }

  final List<Widget> pages = [
    const IndividualHomeScreen(),
    const IndividualProfilePage(),
    const IndividualSearchPage(),
    const ContactPage(),
    const AboutPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    Widget currentScreen = currentIndex == 0
        ? const IndividualHomeScreen()
        : currentIndex == 1
            ? const IndividualProfilePage()
            : currentIndex == 2
                ? const IndividualSearchPage()
                : currentIndex == 3
                    ? const ContactPage()
                    : const AboutPage();
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        splashColor: AppColors.ratingColor,
        child: const Icon(Iconsax.search_normal_1),
        onPressed: () {
          //print("add fab button");
          setState(() {
            currentScreen = const IndividualSearchPage();
            currentIndex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const IndividualHomeScreen();
                        currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.home_2,
                          color: currentIndex == 0
                              ? AppColors.whiteColor
                              : AppColors.grey,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Anasayfa",
                          style: TextStyle(
                            color: currentIndex == 0
                                ? AppColors.whiteColor
                                : AppColors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const IndividualProfilePage();
                        currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.user,
                          color: currentIndex == 1
                              ? AppColors.whiteColor
                              : AppColors.grey,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Profil",
                          style: TextStyle(
                            color: currentIndex == 1
                                ? AppColors.whiteColor
                                : AppColors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ContactPage();
                        currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.call,
                          color: currentIndex == 3
                              ? AppColors.whiteColor
                              : AppColors.grey,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "İletişim",
                          style: TextStyle(
                            color: currentIndex == 3
                                ? AppColors.whiteColor
                                : AppColors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const AboutPage();
                        currentIndex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          color: currentIndex == 4
                              ? AppColors.whiteColor
                              : AppColors.grey,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Hakkında",
                          style: TextStyle(
                            color: currentIndex == 4
                                ? AppColors.whiteColor
                                : AppColors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/