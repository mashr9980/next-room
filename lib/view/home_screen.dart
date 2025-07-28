import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextroom8_animation/view/premium_bottom_sheet.dart';
import 'package:nextroom8_animation/view/provider_home_list_item.dart';
import '../../utils/common/db_helper.dart';
import '../controllers/home_controller.dart';
import '../generated/assets.dart';
import '../utils/common/app_colors.dart';
import '../utils/common/app_text.dart';
import '../utils/common/common_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CommonScaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: topBar(context),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: searchView(),
              ),
              SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: upgradeToPro(),
                      ),
                      SizedBox(height: 20),
                        recentLocations(),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: recentlyAdded(),
                      ),
                        providerListView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: 15,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.asset(
                      Assets.iconsUserImage,
                      height: 52,
                      width: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.appColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Pro",
                          color: Colors.white,
                          textSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Hi, John",
                      fontWeight: FontWeight.w600,
                      textSize: 16,
                    ),
                    GestureDetector(
                      child: Row(
                        spacing: 5,
                        children: [
                          Flexible(
                            child: AppText(
                              text: "St. Petersburg, FL",
                              fontWeight: FontWeight.w400,
                              textSize: 14,
                              maxLines: 1,
                            ),
                          ),
                          Image.asset(
                            Assets.iconsDropDown,
                            height: 7,
                            width: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          spacing: 10,
          children: [
            GestureDetector(
              child: ClipOval(
                child: Image.asset(
                  Assets.iconsVip,
                  height: 48,
                  width: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.asset(
                      Assets.iconsNotif,
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -2,
                    right: -5,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: AppText(
                        text: "2",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        textSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget searchView() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.lightSkyBlue,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        spacing: 10,
        children: [
          Image.asset(
            Assets.iconsSearch,
            height: 45,
            width: 45,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: "Search",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
                AppText(
                  text: "Find roommates in your area",
                  fontWeight: FontWeight.w400,
                  color: AppColor.textGrey,
                  textSize: 13,
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      Assets.iconsFiltter,
                      height: 22,
                      width: 22,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColor.lightSkyBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.appColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget upgradeToPro() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesGradientBg),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Upgrade To Pro",
                  fontWeight: FontWeight.w700,
                  textSize: 18,
                  color: AppColor.white,
                ),
                AppText(
                  text: "Subscribe to NextRoom8 and unlock premium features!",
                  fontWeight: FontWeight.w400,
                  textSize: 12,
                  color: AppColor.white,
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              height: 40,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.white,
              ),
              child: Center(
                child: AppText(text: "Upgrade", fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentlyAdded() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: "Recently Added",
          fontWeight: FontWeight.w700,
          textSize: 17,
        ),
        Row(
          spacing: 5,
          children: [
            AppText(text: "1030", fontWeight: FontWeight.w400, textSize: 15),
            AppText(
              text: "Roommates",
              fontWeight: FontWeight.w400,
              textSize: 15,
            ),
          ],
        ),
      ],
    );
  }

  Widget providerListView() {
    List<ProviderHomeModel> demoImage1 = [
      ProviderHomeModel(
        isPremium: 0,
        name: "Mike",
        ageGender: "Male • 28 Years",
        occupation: "Doctor",
        budget: "\$300",
        boosted: true,
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Dom",
        ageGender: "Male • 30 Years",
        occupation: "Chef",
        budget: "\$200",
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Rambo",
        ageGender: "Male • 22 Years",
        occupation: "Developer",
        budget: "\$100",
        location: "Tampa, FL",
        isLiked: false,
        data: ["https://randomuser.me/api/portraits/men/85.jpg"],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Michal",
        ageGender: "Male • 23 Years",
        occupation: "Designer",
        budget: "\$190",
        location: "Tampa, FL",
        isLiked: false,
        data: ["https://i.pravatar.cc/300?img=12"],
      ),
    ];
    List<ProviderHomeModel> demoImage2 = [
      ProviderHomeModel(
        isPremium: 0,
        name: "Mike",
        ageGender: "Male • 28 Years",
        occupation: "Doctor",
        budget: "\$300",
        boosted: true,
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Michal",
        ageGender: "Male • 23 Years",
        occupation: "Designer",
        budget: "\$190",
        location: "Tampa, FL",
        isLiked: false,
        data: ["https://i.pravatar.cc/300?img=12"],
      ),
    ];
    List<ProviderHomeModel> demoImages = [
      ProviderHomeModel(
        isPremium: 1,
        name: "Jenny",
        ageGender: "Female • 24 Years",
        occupation: "Model",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: [
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 1,
        name: "Jack",
        ageGender: "Male • 24 Years",
        occupation: "Engineer",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: ["https://i.pravatar.cc/300?img=68"],
      ),
      ProviderHomeModel(
        isPremium: 0,
        data1: demoImage1,
        name: "Mike",
        ageGender: "28 Years • Male",
        occupation: "Designer",
        budget: "\$250",
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 1,
        name: "Peach",
        ageGender: "Female • 25 Years",
        occupation: "Nurse",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: [
          'https://images.pexels.com/photos/712521/pexels-photo-712521.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 1,
        name: "Love",
        ageGender: "Female • 20 Years",
        occupation: "Model",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: [
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        ],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Mike",
        data1: demoImage2,
        ageGender: "28 Years • Male",
        occupation: "Designer",
        budget: "\$250",
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 1,
        name: "Jenny",
        ageGender: "Female • 24 Years",
        occupation: "Model",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: [
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 0,
        name: "Mike",
        data1: demoImage2,
        ageGender: "28 Years • Male",
        occupation: "Designer",
        budget: "\$250",
        location: "Tampa, FL",
        isLiked: false,
        data: [
          'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg',
        ],
      ),
      ProviderHomeModel(
        isPremium: 1,
        name: "Love",
        ageGender: "Female • 20 Years",
        occupation: "Model",
        budget: "\$300",
        location: "St. Petersberg, FL",
        isLiked: true,
        data: [
          "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        ],
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15),
      physics: NeverScrollableScrollPhysics(),
      itemCount: demoImages.length,
      itemBuilder: (context, index) {
        return ProviderHomeListItem(
          index: index,
          data: demoImages[index], // Pass different image sets
        );
      },
    );
  }

  Widget recentLocations() {
    final List<Map<String, String>> locations = [
      {'title': 'Sun City Center', 'count': '2', 'image': Assets.dummyMap},
      {'title': 'Tampa', 'count': '2', 'image': Assets.dummyMap},
      {'title': 'St. Augustine', 'count': '2', 'image': Assets.dummyMap},
      {'title': 'Sun City Center', 'count': '2', 'image': Assets.dummyMap},
      {'title': 'Tampa', 'count': '2', 'image': Assets.dummyMap},
      {'title': 'St. Augustine', 'count': '2', 'image': Assets.dummyMap},
    ];
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppText(
            text: "Recently Searched Locations",
            fontWeight: FontWeight.w700,
            textSize: 17,
          ),
        ),
        SizedBox(
          height: 135,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              final location = locations[index];
              return Container(
                width: 110,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            location['image'] ?? "",
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: AppText(
                              text: location['title']!,
                              fontWeight: FontWeight.w500,
                              textSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      text: location['title']!,
                      fontWeight: FontWeight.w500,
                      textSize: 11,
                    ),
                    Text(
                      '${location['count']} New listings',
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
