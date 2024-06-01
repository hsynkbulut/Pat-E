import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/common/styles/spacing_styles.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    final width = THelperFunctions.screenWidth(context);
    return Scaffold(
      //backgroundColor: const Color(0xFFFFDD00).withOpacity(0.8),
      backgroundColor: AppColors.primaryColor,
      //backgroundColor: const Color(0xFFFFDD00),
      appBar: const CustomAppBar(
          showBackButton: true, userType: UserType.commonUser),
      body: Container(
        padding: TSpacingStyle
            .paddingWithAppBarHeight2, //const EdgeInsets.only(top: 33.0),
        decoration: BackgroundGradient().buildGradient3(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: width * 0.5, //350.0,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.yellow[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            ImagePaths.pawIcons,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Uygulama Hakkında',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: dark
                                  ? AppColors.dark
                                  : AppColors.primaryColor,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'OhChewy',
                              fontSize: 35,
                            ),
                        /*
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SignikaNegative',
                          fontSize: 25.0,
                          color: AppColors.primaryColor2,
                        ),
                        */
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Hayvan Dostu uygulamamıza hoş geldiniz! Amacımız, hayvanlara sevgi dolu bir yuva bulmalarında ve kaybolan hayvanların sahiplerine kavuşmalarında sizlere yardımcı olmaktır.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Misyonumuz',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    //const SizedBox(height: 5.0),
                    Text(
                      'Misyonumuz, hayvan sahiplendirme süreçlerini kolaylaştırmak, kaybolan veya bulunan hayvanların yönetimini etkinleştirmek ve toplumda hayvan refahını artırmaktır. Kullanıcılarımızın bilinçli kararlar almasını sağlayarak, daha güvenli ve sevgi dolu bir yaşam için adımlar atmalarına destek olmayı amaçlıyoruz.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Vizyonumuz',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    //const SizedBox(height: 5.0),
                    Text(
                      'Vizyonumuz, her canlının hak ettiği mutlu ve sağlıklı bir yaşama kavuşması için teknolojiyi kullanarak insanları ve hayvanları bir araya getirmektir. Uygulamamız aracılığıyla toplumda hayvanseverlik ve hayvan refahı konusunda farkındalık oluşturarak, daha iyi bir gelecek inşa etmeyi hedefliyoruz.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Neler Sunuyoruz?',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Pat-E, kullanıcı dostu bir arayüzle birlikte şu olanakları sunar:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final List<String> features = [
                          '• Hayvan Sahiplenme Kategorisi: Barınaklardaki veya sahiplendirme platformlarındaki hayvanları görüntüleyerek, kolayca sahiplenme başvurusu yapabilirsiniz.',
                          '• Kayıp ve Bulunan Hayvanlar Kategorisi: Kaybolan veya bulunan hayvanlar hakkında bilgi paylaşabilir ve kayıp hayvanların sahipleriyle buluşmalarını sağlayabilirsiniz.',
                          '• Bilgilendirme ve Eğitim Kategorisi: Hayvan bakımı, sağlık ve beslenme konularında eğitim materyallerine erişerek, bilinçli bir hayvansever topluluğun parçası olabilirsiniz.',
                          '• Kullanıcı Dostu Profil Yönetimi: Kişisel bilgileri güncelleme ve kendi ilanlarını yönetme imkanı.'
                        ];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            features[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.dark.withOpacity(0.6),
                                ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'İletişim',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                dark ? AppColors.dark : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Pat-E ile ilgili herhangi bir sorunuz veya geri bildiriminiz varsa, lütfen bizimle iletişime geçmekten çekinmeyin. Size en iyi hizmeti sunabilmek için buradayız.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Teşekkür ederiz, Pat-E Ekibi',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.dark.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
