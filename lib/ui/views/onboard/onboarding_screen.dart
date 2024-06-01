import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';
import 'package:pat_e/core/models/onboards_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: constraints.maxHeight * 0.75,
                color: AppColors.bColor,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardData.length,
                  itemBuilder: (context, index) => OnboardContent(
                    onBoard: onBoardData[index],
                    screenHeight: THelperFunctions.screenHeight(context),
                    screenWidth: THelperFunctions.screenWidth(context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstant.chooseProfileRoute,
                  );
                },
                child: Container(
                  height: 50,
                  width: THelperFunctions.screenWidth(context) * 0.6,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        color: AppColors.primaryColor,
                        spreadRadius: 0,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      currentPage == onBoardData.length - 1
                          ? 'Giriş Yap'
                          : 'Devam Et',
                      style: AppColors.poppins.copyWith(
                        color: AppColors.bColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    onBoardData.length,
                    (index) => indicator(index: index),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }

  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentPage == index ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentPage == index
            ? AppColors.primaryColor
            : AppColors.black.withOpacity(0.6),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final OnBoards onBoard;
  final double screenHeight;
  final double screenWidth;

  const OnboardContent({
    super.key,
    required this.onBoard,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenHeight * 0.5,
            width: screenWidth - 40,
            decoration: const BoxDecoration(
              color: AppColors.bColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 200,
                      width: screenWidth - 40,
                      color: AppColors.tertiaryColor,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 70,
                            left: -45,
                            height: 150,
                            width: 150,
                            child: Transform.rotate(
                              angle: -11.5,
                              child: SvgPicture.asset(
                                'assets/Paw_Print.svg',
                                color: AppColors.tertiaryColor.shade400,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 77,
                            right: -30,
                            height: 150,
                            width: 150,
                            child: Transform.rotate(
                              angle: 67,
                              child: SvgPicture.asset(
                                'assets/Paw_Print.svg',
                                color: AppColors.tertiaryColor.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: Image.asset(
                    onBoard.image,
                    height: 340,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                    style: AppColors.poppins.copyWith(
                      height: 1.2,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    children: [
                      TextSpan(
                          text: 'Hayalinizdeki ', style: AppColors.poppins),
                      TextSpan(
                        text: 'Evcil',
                        style: AppColors.poppins.copyWith(
                          color: AppColors.ratingColor,
                        ),
                      ),
                      TextSpan(
                        text: ' Hayvanı Burada Bulun',
                        style: AppColors.poppins,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  onBoard.text,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: AppColors.poppins.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
