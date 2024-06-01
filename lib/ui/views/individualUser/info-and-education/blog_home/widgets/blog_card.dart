//import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/blog_model.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/blog_detail/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  //final Color color;
  final BoxDecoration decoration;
  const BlogCard({
    super.key,
    required this.blog,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: height * 0.27, //200,
        margin: EdgeInsets.all(height * 0.035).copyWith(
          bottom: 4,
        ),
        padding: EdgeInsets.all(height * 0.025),
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.subTopics
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: Chip(
                              label: Text(
                                e,
                                style:
                                    const TextStyle(color: AppColors.textWhite),
                              ),
                              backgroundColor: AppColors.dark,
                              side: BorderSide.none,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            Text(
              '${THelperFunctions.calculateReadingTime(blog.content)} dk',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
