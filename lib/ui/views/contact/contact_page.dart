import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';
import 'package:pat_e/ui/widgets/social_media_item.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      //drawer: const SideMenu(),
      appBar: const CustomAppBar(
          showBackButton: false, userType: UserType.commonUser),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.ratingColor, AppColors.whiteColor],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -height * 0.14, //-100,
                right: -width * 0.2, //-90,
                child: Container(
                  width: width * 0.7, // 360,
                  height: height * 0.35, //230,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF7A4DFF),
                  ),
                ),
              ),
              Positioned(
                bottom: -height * 0.27, // -218
                left: width * 0,
                right: width * 0,
                child: Center(
                  child: Container(
                    width: width, // 530,
                    height: height * 0.48, // 420,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.ratingColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*
                    const Text(
                      'Iletisim Sayfası',
                      style: TextStyle(
                        fontFamily: 'OhChewy',
                        fontSize: 40.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    */
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.01),
                      child: Column(
                        children: [
                          const SocialMediaItem(
                            title: TTexts.webSite,
                            subtitle: TTexts.webSiteName,
                            image: ImagePaths.websiteLogo,
                            link: TTexts.webSiteLink,
                          ),
                          SizedBox(height: height * 0.01),
                          const SocialMediaItem(
                            title: TTexts.email,
                            subtitle: TTexts.emailName,
                            image: ImagePaths.gmailLogo,
                            link: TTexts.emailLink,
                          ),
                          SizedBox(height: height * 0.01),
                          const SocialMediaItem(
                            title: TTexts.linkedIn,
                            subtitle: TTexts.linkedInName,
                            image: ImagePaths.linkedInLogo,
                            link: TTexts.linkedInLink,
                          ),
                          SizedBox(height: height * 0.01),
                          const SocialMediaItem(
                            title: TTexts.gitHub,
                            subtitle: TTexts.gitHubName,
                            image: ImagePaths.gitHubLogo,
                            link: TTexts.gitHubLink,
                          ),
                          SizedBox(height: height * 0.01),
                          const SocialMediaItem(
                            title: TTexts.youtube,
                            subtitle: TTexts.youtubeName,
                            image: ImagePaths.youTubeLogo,
                            link: TTexts.youtubeLink,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    SizedBox(
                      height: height * 0.2, //180,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          ImagePaths.contactPersonImages,
                          width: width * 0.4, //180,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
