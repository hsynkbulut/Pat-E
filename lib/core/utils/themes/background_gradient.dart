import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';

class BackgroundGradient {
  BoxDecoration buildGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.dark, AppColors.dark],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        topRight: Radius.circular(45),
      ),
    );
  }

  BoxDecoration buildGradient2() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.whiteColor, AppColors.bColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        topRight: Radius.circular(45),
      ),
    );
  }

  BoxDecoration buildGradient3() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFDD00), Color(0xFFFFD000)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(45),
        topRight: Radius.circular(45),
      ),
    );
  }

  BoxDecoration buildGradient4() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [Color(0xFF7C4CF7), AppColors.primaryColor, Color(0xFF230470)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration buildGradient5() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [Color(0xFFF61B3F), AppColors.primaryColor2, Color(0xFF56010F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration buildGradient6() {
    return BoxDecoration(
      border: Border.all(color: Colors.white, width: 3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      gradient: const LinearGradient(
        colors: [Color(0xFFF61B3F), AppColors.primaryColor2, Color(0xFF56010F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration buildGradient7() {
    return BoxDecoration(
      border: Border.all(color: AppColors.whiteColor, width: 3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      gradient: const LinearGradient(
        colors: [Color(0xFFFDD536), AppColors.gold, Color(0xFFE6AD00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration buildGradient8() {
    return BoxDecoration(
      border: Border.all(color: AppColors.whiteColor, width: 3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      gradient: const LinearGradient(
        colors: [Color(0xFF27B72F), AppColors.success, Color(0xFF0F6113)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration buildGradient9() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [Color(0xFF7C4CF7), AppColors.primaryColor, Color(0xFF4218AC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
