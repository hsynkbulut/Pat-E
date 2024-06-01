import 'package:pat_e/common/constants/image_paths.dart';

class CategoryModules {
  String thumbnail;
  String name;
  String description;

  CategoryModules({
    required this.name,
    required this.description,
    required this.thumbnail,
  });
}

List<CategoryModules> categoryModulesList = [
  CategoryModules(
      name: 'Hayvan Sahiplenme',
      description:
          'Hayvan sahiplendirmek yada hayvan sahiplenmek isteyenler buraya',
      thumbnail: ImagePaths.animalAdoptionImage //animalAdoptionImage,
      ),
  CategoryModules(
      name: 'Kayıp İlanı',
      description:
          'Kayıp ilanı açmak ve kayıp ilanlarına göz atmak için buraya',
      thumbnail: ImagePaths.lostAndFoundImage //lostAndFoundImage,
      ),
  CategoryModules(
      name: 'Bilgi & Eğitim',
      description: 'Bağış ihtiyacı olanlar ve bağış yapmak isteyenler buraya',
      thumbnail: ImagePaths.infoAndEducationImage //donationImage,
      ),
];
