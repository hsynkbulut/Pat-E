// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/core/viewmodel/individual_viewmodel/individual_profile_viewmodel.dart';
import 'package:pat_e/ui/views/individualUser/home/widgets/category_grid.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/individual_widgets/custom_carousel_slider.dart';

class IndividualHomeScreen extends StatefulWidget {
  const IndividualHomeScreen({super.key});

  @override
  State<IndividualHomeScreen> createState() => _IndividualHomeScreenState();
}

class _IndividualHomeScreenState extends State<IndividualHomeScreen> {
  final searchInput = TextEditingController();
  final searchFocus = FocusNode();
  final IndividualProfileViewModel viewModel = IndividualProfileViewModel();
  late StreamSubscription<bool> _updateSubscription;

  @override
  void initState() {
    super.initState();
    _getUserInfo();

    // Stream'i dinle
    _updateSubscription = viewModel.updateStream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Aboneliği iptal et ve StreamController'ı temizle
    _updateSubscription.cancel();
    viewModel.dispose();
    searchInput.dispose();
    searchFocus.dispose();
  }

  Future<void> _getUserInfo() async {
    await viewModel.getUserInfo();
    setState(() {}); // Veriler güncellendi, sayfayı tekrar çiz
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: false, userType: UserType.individualUser),
      body: Container(
        padding: EdgeInsets.only(top: height * 0.02),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.045),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                const CustomCarouselSlider(
                  images: [
                    "https://images.unsplash.com/photo-1477884213360-7e9d7dcc1e48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    "https://images.unsplash.com/photo-1517331156700-3c241d2b4d83?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    "https://plus.unsplash.com/premium_photo-1661961347317-41f7a010a441?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                  ],
                  captions: [
                    "Yüzlerce sevimli dost arasından birini sahiplenin ve onlara ömür boyu bir yuva sunun.",
                    "Kaybolan dostlarımızı bulmaya yardımcı olun veya bulunan hayvanları sahiplerine kavuşturun.",
                    "Hayvan bakımı, sağlık ve beslenme konularında bilgi sahibi olun ve sevimli dostlarınızın sağlığına katkıda bulunun"
                  ],
                ),
                SizedBox(height: height * 0.02),
                const CategoryGrid(),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
