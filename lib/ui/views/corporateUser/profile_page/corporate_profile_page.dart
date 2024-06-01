import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/common/styles/spacing_styles.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/core/viewmodel/corporate_viewmodel/corporate_profile_viewmodel.dart';
import 'package:pat_e/ui/views/corporateUser/edit_profile/corporate_edit_profile_page.dart';
import 'package:pat_e/ui/views/corporateUser/profile_page/widgets/corporate_profile_item.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class CorporateProfilePage extends StatefulWidget {
  const CorporateProfilePage({super.key});

  @override
  State<CorporateProfilePage> createState() => _CorporateProfilePageState();
}

class _CorporateProfilePageState extends State<CorporateProfilePage> {
  final CorporateProfileViewModel viewModel = CorporateProfileViewModel();
  late StreamSubscription<bool> _updateSubscription;
  bool isSigningOut = false; // Bayrak tanımlama

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
  }

  Future<void> _getUserInfo() async {
    await viewModel.getUserInfo();
    setState(() {}); // Veriler güncellendi, sayfayı tekrar çiz
  }

  void _signOut() async {
    setState(() {
      isSigningOut = true; // Çıkış işlemi başladığında bayrağı true yap
    });

    // İşlemi gerçekleştir
    await viewModel.signOutAccount(context);

    setState(() {
      isSigningOut = false; // İşlem tamamlandığında bayrağı false yap
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.corporateUser),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    viewModel.showFullScreenImage(context);
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: viewModel.profilePhotoUrl != null
                            ? NetworkImage(viewModel.profilePhotoUrl!)
                            : const AssetImage(ImagePaths.userMan)
                                as ImageProvider<Object>?,
                        backgroundColor: AppColors.dark,
                      ),
                      Positioned(
                        bottom: 2,
                        left: 75,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                viewModel.updateProfilePhoto(context).then((_) {
                                  viewModel
                                      .getUserInfo(); // Profil bilgilerini yeniden getir
                                });
                              },
                              icon: Icon(
                                Iconsax.camera,
                                color: dark
                                    ? AppColors.dark
                                    : AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                CorporateProfileItem(
                  title: TTexts.foundationName,
                  subtitle: viewModel.name ?? '',
                  iconData: Iconsax.user,
                ),
                SizedBox(height: height * 0.02),
                CorporateProfileItem(
                  title: TTexts.email,
                  subtitle: viewModel.email ?? '',
                  iconData: Iconsax.direct,
                ),
                SizedBox(height: height * 0.02),
                CorporateProfileItem(
                  title: TTexts.phoneNo,
                  subtitle: viewModel.phoneNumber ?? '',
                  iconData: Iconsax.call,
                ),
                SizedBox(height: height * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CorporateEditProfilePage(
                              corporate: viewModel.corporate),
                        ),
                      );

                      if (updatedUser != null) {
                        viewModel.updateUserInfo(updatedUser);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor:
                          dark ? AppColors.whiteColor : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Text(TTexts.updateButton.toUpperCase()),
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.showDeleteConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          dark ? AppColors.warning : AppColors.warning,
                      foregroundColor:
                          dark ? AppColors.black : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Text(TTexts.deleteAccountButton.toUpperCase()),
                  ),
                ),
                SizedBox(height: height * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _signOut(); // Çıkış işlemini başlatan metot
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark ? AppColors.error : AppColors.dark,
                      foregroundColor:
                          dark ? AppColors.whiteColor : AppColors.whiteColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: isSigningOut
                        ? const CircularProgressIndicator() // İşlem sırasında gösterilecek widget
                        : Text(TTexts.signOut.toUpperCase()),
                  ),
                ),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
