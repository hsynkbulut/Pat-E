import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';

class CategoryInfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final BoxDecoration backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final BoxDecoration decoration;

  const CategoryInfoCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Container(
      margin: EdgeInsets.all(height * 0.01),
      //color: Colors.deepPurpleAccent,
      decoration: decoration,
      child: Padding(
        padding: EdgeInsets.all(height * 0.012),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              // Sol sütun
              SizedBox(
                width: width * 0.2,
                child: Container(
                  width: double.infinity,
                  height: height * 0.2,
                  decoration: backgroundColor,
                  child: Center(
                    child: Transform.rotate(
                      angle: 90 * (3.141592653589793 / 180),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              // Sağ sütun
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // İlk satır
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: height * 0.13,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    // İkinci satır
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.whiteColor,
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
