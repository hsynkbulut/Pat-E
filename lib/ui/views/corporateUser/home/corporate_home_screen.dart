import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';
import 'package:pat_e/core/viewmodel/corporate_viewmodel/corporate_profile_viewmodel.dart';

class CorporateHomeScreen extends StatefulWidget {
  const CorporateHomeScreen({super.key});

  @override
  State<CorporateHomeScreen> createState() => _CorporateHomeScreenState();
}

class _CorporateHomeScreenState extends State<CorporateHomeScreen> {
  // Creating static data in lists
  final List catNames = [
    "Hesabım",
    "Diğer İlanlar",
    "Hakkımızda",
    "Yardım",
    "Çıkış Yap",
  ];

  final List<Color> catColors = [
    AppColors.primaryColor,
    AppColors.success,
    AppColors.info,
    AppColors.warning,
    AppColors.primaryColor2,
  ];

  final List<Icon> catIcons = [
    const Icon(Icons.person, color: AppColors.whiteColor, size: 30),
    const Icon(Icons.category, color: AppColors.whiteColor, size: 30),
    const Icon(Icons.info, color: AppColors.whiteColor, size: 30),
    const Icon(Icons.question_mark, color: AppColors.whiteColor, size: 30),
    const Icon(Icons.logout, color: AppColors.whiteColor, size: 30),
  ];

  final List imgList = [
    'İlan Oluştur',
    'İlan Düzenle',
    'İlan Sil',
    'İlanlarımı Görüntüle',
  ];

  final List<Icon> imgIcons = [
    const Icon(Icons.add, color: AppColors.primaryColor, size: 40),
    const Icon(Icons.replay_outlined, color: AppColors.primaryColor, size: 40),
    const Icon(Icons.delete, color: AppColors.primaryColor, size: 40),
    const Icon(Icons.assignment, color: AppColors.primaryColor, size: 40),
  ];

  final CorporateProfileViewModel viewModel = CorporateProfileViewModel();

  bool isSigningOut = false;

  late StreamSubscription<bool> _updateSubscription;

  @override
  void initState() {
    super.initState();
    //getUserInfo();
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
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.whiteColor,
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor, //Color(0xFF674AEF)
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: AppColors.whiteColor,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 100,
                    width: 300,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    padding: EdgeInsets.only(bottom: height * 0.01),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: viewModel.profilePhotoUrl != null
                              ? NetworkImage(viewModel.profilePhotoUrl!)
                              : const AssetImage(ImagePaths.userMan)
                                  as ImageProvider<Object>?,
                          backgroundColor: AppColors.whiteColor,
                        ),
                        SizedBox(width: width * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            viewModel.name != null
                                ? Text(
                                    viewModel.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: AppColors.ratingColor,
                                    //backgroundColor: AppColors.whiteColor,
                                    //value: 0.50,
                                  ),
                            const SizedBox(height: 1),
                            const Text(
                              'Kurumsal Kullanıcı',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height *
                    0.02), //EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _handleCatNameTap(context, catNames[index]);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            catNames[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: dark
                                  ? AppColors.whiteColor
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                Divider(
                  thickness: 2,
                  color: dark ? AppColors.whiteColor : AppColors.grey,
                ),
                Text(
                  "Kategoriler",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: dark ? AppColors.whiteColor : AppColors.dark,
                  ),
                ),
                SizedBox(height: height * 0.01),
                GridView.builder(
                    itemCount: imgList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (height - 50 - 25) / (4 * 240),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _handleImgListTap(context, imgList[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors
                                .primaryColor, // Kartların arkaplan rengi
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: imgIcons[index],
                                  ),
                                ),
                                /*
                                Image.asset(
                                  "images/${imgList[index]}.png",
                                  width: 100,
                                  height: 100,
                                ),
                                */
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                imgList[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: height * 0.01),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleCatNameTap(BuildContext context, String catName) {
    switch (catName) {
      case "Hesabım":
        Navigator.pushNamed(context, RouteConstant.corporateProfileRoute);
        break;
      case "Diğer İlanlar":
        //Navigator.pushNamed(context, RouteConstant.corporateOtherRoute);
        break;
      case "Hakkımızda":
        Navigator.pushNamed(context, RouteConstant.aboutScreenRoute);
        break;
      case "Yardım":
        THelperFunctions.showAlert(
          "Yardım",
          "Yardım için hsyn.kbulut@gmail.com adresine mail atabilirsiniz.",
          context,
        );
        break;
      case "Çıkış Yap":
        _signOut(); // Çıkış işlemini başlatan metot
        break;
      default:
        // Do nothing for other categories
        break;
    }
  }

  void _handleImgListTap(BuildContext context, String catName) {
    switch (catName) {
      case "İlan Oluştur":
        Navigator.pushNamed(
            context, RouteConstant.corporateAddAnimalAdoptionRoute);
        break;
      case "İlan Düzenle":
        Navigator.pushNamed(
            context, RouteConstant.corporateUpdatePetAdoptionListingRoute);
        break;
      case "İlan Sil":
        Navigator.pushNamed(
            context, RouteConstant.corporateDeletePetAdoptionListingRoute);
        break;
      case "İlanlarımı Görüntüle":
        Navigator.pushNamed(
            context, RouteConstant.corporateGetPetAdoptionListingRoute);
        break;
      default:
        // Do nothing for other categories
        break;
    }
  }
}
