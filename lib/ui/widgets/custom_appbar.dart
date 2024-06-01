import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/views/corporateUser/home/corporate_home_screen.dart';
import 'package:pat_e/ui/widgets/individual_widgets/bottom_navbar_yedek.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  //final bool isDark;
  final bool showBackButton;
  final Function()? onFilterPressed;
  final UserType userType;

  const CustomAppBar({
    super.key,
    required this.showBackButton,
    this.onFilterPressed,
    required this.userType,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final width = THelperFunctions.screenWidth(context);
    final height = THelperFunctions.screenHeight(context);
    return AppBar(
      // automaticallyImplyLeading: false olursa BackButton çalışmaz, kaybolur!
      automaticallyImplyLeading: widget.showBackButton ? true : false,
      backgroundColor: AppColors.primaryColor,
      elevation: 3.0, //AppBar'ın altına gölgelik verir
      shadowColor: AppColors.dark, //AppBar'ın gölgelik rengi
      leading: widget.showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.whiteColor,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: InkWell(
        onTap: () {
          switch (widget.userType) {
            case UserType.corporateUser:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CorporateHomeScreen()),
              );
              break;
            case UserType.individualUser:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const BottomNavBarYedek(selectedIndex: 0)),
              );
              break;
            case UserType.commonUser:
              break;
          }
        },
        child: Text(
          TTexts.appName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColors.ratingColor, fontFamily: "ErasBold"),
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.06), //30
          child: Text(
            TTexts.appSubTitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.ratingColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
      flexibleSpace: SafeArea(
          child: InkWell(
        onTap: () {
          switch (widget.userType) {
            case UserType.corporateUser:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CorporateHomeScreen()),
              );
              break;
            case UserType.individualUser:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const BottomNavBarYedek(selectedIndex: 0)),
              );
              break;
            case UserType.commonUser:
              break;
          }
        },
        child: Image.asset(
          ImagePaths.appLogo,
          width: width * 0.09, //60
          height: height * 0.09, //60
        ),
      )),
    );
  }
}
