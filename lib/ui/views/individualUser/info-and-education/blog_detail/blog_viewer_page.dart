import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/blog_model.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

import '../../../../../core/utils/themes/background_gradient.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );
  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          dark ? AppColors.whiteColor : AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blog.posterName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${THelperFunctions.formatDateBydMMMYYYY(blog.updatedAt)} . ${THelperFunctions.calculateReadingTime(blog.content)} dk',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: dark ? AppColors.ratingColor : AppColors.darkGrey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    blog.content,
                    style: TextStyle(
                      fontSize: 16,
                      height: 2,
                      color: dark ? AppColors.grey : AppColors.darkGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
