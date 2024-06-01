import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/blog_model.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/blog_home/widgets/blog_card.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class BlogPage extends StatefulWidget {
  final String mainTopic;

  const BlogPage({super.key, required this.mainTopic});

  static Route<dynamic> route(String mainTopic) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => BlogPage(mainTopic: mainTopic),
    );
  }

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late List<Blog> _filteredBlogs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFilteredBlogs();
  }

  List<BoxDecoration> gradients = [
    BackgroundGradient().buildGradient4(),
    BackgroundGradient().buildGradient5(),
  ];

  Future<void> _fetchFilteredBlogs() async {
    try {
      setState(() {
        _filteredBlogs =
            blogs.where((blog) => blog.mainTopic == widget.mainTopic).toList();
        _isLoading = false;
      });
    } catch (e) {
      THelperFunctions.showSnackBar2(
          context, 'Blogları getirme başarısız oldu');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.individualUser),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.09, vertical: height * 0.004),
                    child: Text(
                      widget.mainTopic,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              color: dark
                                  ? AppColors.whiteColor
                                  : AppColors.darkerGrey),
                    ),
                  ),
                  _filteredBlogs.isEmpty
                      ? const Center(
                          child: Text('Gösterilecek blog bulunamadı'))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _filteredBlogs.length,
                            itemBuilder: (context, index) {
                              final blog = _filteredBlogs[index];
                              return BlogCard(
                                blog: blog,
                                decoration: gradients[index % gradients.length],
                              );
                            },
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
