import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/ui/views/individualUser/info-and-education/blog_home/blog_page.dart';

class InfoAndEducationData {
  final List<Widget> pages = [
    const BlogPage(mainTopic: 'Bakım'),
    const BlogPage(mainTopic: 'Beslenme'),
    const BlogPage(mainTopic: 'Sağlık'),
  ];

  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'BAKIM';
      case 1:
        return 'BESLENME';
      case 2:
        return 'SAĞLIK';
      default:
        return '';
    }
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return ImagePaths.petCareImage;
      case 1:
        return ImagePaths.petNutritionImage;
      case 2:
        return ImagePaths.petHealthImage;
      default:
        return '';
    }
  }

  String getDescription(int index) {
    switch (index) {
      case 0:
        return 'Evcil hayvan bakımı hakkında detaylı bilgi için tıklayınız.';
      case 1:
        return 'Evcil hayvan beslemek hakkında detaylı bilgi için tıklayınız.';
      case 2:
        return 'Evcil hayvan sağlığı hakkında detaylı bilgi için tıklayınız.';
      default:
        return '';
    }
  }
}
