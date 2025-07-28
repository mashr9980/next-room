import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../generated/assets.dart';

class HomeController extends GetxController {
  void toggleLike(int index) {
    likedList[index] = !likedList[index];
  }

  final List<List<String>> demoImages = [
    [Assets.dummyDummy2, Assets.dummyDummy2, Assets.dummyDummy2],
    [Assets.dummyImage3],
    [Assets.dummyDummy3],
    [Assets.dummyDummy2],
    [Assets.dummyImage3],
    [Assets.dummyImage3],
    [Assets.dummyDummy3],
    [Assets.dummyDummy2],
    [Assets.dummyImage3],
    [Assets.dummyDummy2],
  ];

  List<HomeRoom> buildCombinedFavorites() {
    return [
      HomeRoom(
        images: demoImages[0],
        title: "Beautiful large room with private bathroom",
        location: "Brooklyn, New York",
        type: "Room in · Apartment",
        price: 850,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[1],
        title:
            "Cozy and affordable studio apartment close to downtown amenities",
        location: "Austin, Texas",
        type: "Room in · Townhouse",
        price: 700,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[2],
        title:
            "Modern luxury suite with private pool, gym access, and ocean view",
        location: "Miami Beach, Florida",
        type: "Room in · Condo",
        price: 1500,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[3],
        title:
            "Industrial-style loft with high ceilings, large windows, and workspace",
        location: "Seattle, Washington",
        type: "Room in · Apartment",
        price: 1200,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[4],
        title: "Beautiful large room with private bathroom",
        location: "Madison, Wisconsin",
        type: "Room in · House",
        price: 500,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[5],
        title:
            "Shared flat with young professionals near central shopping district",
        location: "Chicago, Illinois",
        type: "Room in · Apartment",
        price: 600,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[6],
        title:
            "Creative studio in artsy neighborhood with garden and reading nook",
        location: "Portland, Oregon",
        type: "Room in · House",
        price: 650,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[7],
        title:
            "Premium villa room facing the beach with private terrace and lounge",
        location: "Santa Monica, California",
        type: "Room in · Condo",
        price: 1800,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[8],
        title:
            "Bright and clean room in a modern apartment close to public transit",
        location: "Denver, Colorado",
        type: "Room in · Apartment",
        price: 750,
        isLike: true.obs,
      ),
      HomeRoom(
        images: demoImages[9],
        title:
            "Elegant and fully furnished room ideal for remote working professionals",
        location: "Atlanta, Georgia",
        type: "Room in · House",
        price: 680,
        isLike: true.obs,
      ),
    ];
  }

  RxList<bool> likedList = List.generate(10, (_) => false).obs;

  @override
  void onInit() {
    demoImages;
    super.onInit();
  }

  ///location
  final locationController = TextEditingController();

  ///Boost
  int boostSelectedIndex = 0;

  final List<BoostOption> boostOptions = [
    BoostOption(duration: "01 Day", price: "\$0.99"),
    BoostOption(duration: "03 Days", price: "\$1.99"),
    BoostOption(duration: "07 Days", price: "\$3.99"),
    BoostOption(duration: "30 Days", price: "\$8.99"),
  ];

  ///upgrade
  int premiumSelectedIndex = 0;

  final List<PricingOption> premiumOptions = [
    PricingOption(
      duration: "03 Days",
      pricePerDay: "\$1.66",
      totalPrice: "\$4.99",
    ),
    PricingOption(
      duration: "01 Week",
      pricePerDay: "\$1.43 ",
      totalPrice: "\$9.99",
      isRecommended: true,
    ),
    PricingOption(
      duration: "02 Weeks",
      pricePerDay: "\$1.07",
      totalPrice: "\$14.99",
    ),
    PricingOption(
      duration: "01 Month",
      pricePerDay: "\$0.83",
      totalPrice: "\$24.99",
    ),
  ];

  final List<String> premiumFeatures = [
    "Get first access to new profiles",
    "Ad-free experience",
    "Appear on top of the feed every day",
    "Make more than one listing",
    "Send unlimited messages and requests",
  ];

  /// Home filter options



  final RxList<String> roomType =
      <String>["Furnished", "Unfurnished", "Private Bathroom"].obs;
  final RxList<String> selectedRoomTypes = <String>[].obs;

  final RxList<String> propertyType =
      <String>["House", "Condo", "Townhouse", "Apartment"].obs;
  final RxList<String> selectedPropertyTypes = <String>[].obs;

  final RxList<String> availableFrom = <String>["Now", "Next Month"].obs;
  final RxString selectedAvailableFrom = ''.obs;

  final RxSet<String> selectedSort = <String>{}.obs;
  final RxList<String> sort = <String>["No Deposit", "Free to Contact"].obs;

  final RxSet<String> selectedSort2 = <String>{}.obs;
  final RxList<String> sort2 =
      <String>["Free to Contact", "Pets", "No Pets"].obs;




  final RxList<String> facilities =
      <String>[
        "Children Friendly",
        "In-Unit Laundry",
        "Cat Friendly",
        "Dog Friendly",
        "Street Parking",
        "Private Entry",
        "Pool",
        "Gated Community",
        "Cannabis Friendly",
        "Couples Welcomed",
        "Driveway Parking",
      ].obs;

  final RxSet<String> selectedFacilities = <String>{}.obs;
}

class BoostOption {
  final String duration;
  final String price;

  BoostOption({required this.duration, required this.price});
}

class PricingOption {
  final String duration;
  final String pricePerDay;
  final String totalPrice;
  final bool isRecommended;

  PricingOption({
    required this.duration,
    required this.pricePerDay,
    required this.totalPrice,
    this.isRecommended = false,
  });
}

class HomeRoom {
  final List<String> images;
  final String title;
  final String location;
  final String type;
  final int price;
  RxBool isLike = false.obs;

  HomeRoom({
    required this.images,
    required this.title,
    required this.location,
    required this.type,
    required this.price,
    required this.isLike,
  });
}
