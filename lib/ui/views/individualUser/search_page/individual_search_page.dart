import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/colors.dart';
import 'package:pat_e/common/constants/enum.dart';
import 'package:pat_e/common/helpers/helpers_functions.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/core/services/lost_animal_service.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/individual_adopt_pet_detail.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/individual_lost_detail.dart';
import 'package:pat_e/ui/widgets/custom_appbar.dart';

class IndividualSearchPage extends StatefulWidget {
  const IndividualSearchPage({super.key});
  @override
  State<IndividualSearchPage> createState() => _IndividualSearchPageState();
}

class _IndividualSearchPageState extends State<IndividualSearchPage> {
  List<dynamic> displayList = [];
  List<dynamic> allData = [];
  bool _isSearching = false;

  final AnimalAdoptionService _animalAdoptionService = AnimalAdoptionService();
  final LostAnimalService _lostAnimalService = LostAnimalService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final List<AnimalAdoption> animalAdoptions =
        await _animalAdoptionService.getAnimalAdoptions();
    final List<LostAnimal> lostAnimals =
        await _lostAnimalService.getLostAnimals();

    setState(() {
      allData = [...animalAdoptions, ...lostAnimals];
      displayList = allData;
    });
  }

  void updateList(String value) {
    setState(() {
      displayList = allData
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final height = THelperFunctions.screenHeight(context);
    //final width = THelperFunctions.screenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: const CustomAppBar(
          showBackButton: false, userType: UserType.individualUser),
      body: Container(
        padding: EdgeInsets.only(top: height * 0.02),
        decoration: dark
            ? BackgroundGradient().buildGradient()
            : BackgroundGradient().buildGradient2(),
        child: Padding(
          padding: EdgeInsets.all(height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onTap: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
                onChanged: (value) => updateList(value),
                style: const TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.bColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "örn: Pamuk",
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: AppColors.darkGrey,
                ),
              ),
              SizedBox(height: height * 0.03),
              _isSearching
                  ? Expanded(
                      child: displayList.isEmpty
                          ? Center(
                              child: Text(
                                "Hiçbir sonuç bulunamadı",
                                style: TextStyle(
                                  color: dark
                                      ? AppColors.whiteColor
                                      : AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: displayList.length,
                              itemBuilder: (context, index) => ListTile(
                                contentPadding: EdgeInsets.all(height * 0.01),
                                title: Text(
                                  displayList[index] is AnimalAdoption
                                      ? displayList[index].name
                                      : displayList[index].name,
                                  style: TextStyle(
                                    color: dark
                                        ? AppColors.whiteColor
                                        : AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  displayList[index] is AnimalAdoption
                                      ? "${displayList[index].city}, ${displayList[index].district}"
                                      : "${displayList[index].city}, ${displayList[index].district}",
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                  ),
                                ),
                                trailing: Text(
                                  displayList[index] is AnimalAdoption
                                      ? "Sahiplen"
                                      : "Kayıp Bul",
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                  ),
                                ),
                                leading: displayList[index] is AnimalAdoption
                                    ? Image.network(
                                        displayList[index].photos[0])
                                    : displayList[index] is LostAnimal
                                        ? Image.network(
                                            displayList[index].photos[0])
                                        : null,
                                onTap: () {
                                  displayList[index] is AnimalAdoption
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                IndividualAdoptPetPageDetail(
                                                    animalAdoption:
                                                        displayList[index]),
                                          ),
                                        )
                                      : displayList[index] is LostAnimal
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    IndividualSearchForLostDetail(
                                                        lostAnimal:
                                                            displayList[index]),
                                              ),
                                            )
                                          : const Placeholder();
                                },
                              ),
                            ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
