import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nextroom8_animation/view/premium_bottom_sheet.dart';
import '../../utils/common/app_colors.dart';
import '../../utils/common/common_scaffold.dart';
import '../../utils/common/image_view.dart';
import '../generated/assets.dart';
import '../utils/common/app_button.dart';
import '../utils/common/app_text.dart';
import '../utils/common/db_helper.dart';
import 'blur_dismissible_widget.dart';

class PersonDetailScreen extends StatefulWidget {
  final int index;
  final int? imageGridIndex;
  final List<String> images;
  final int initialImageIndex;
  final String? from;
  final int? type;
  final bool? isFlagged;

  const PersonDetailScreen({
    super.key,
    required this.index,
    this.imageGridIndex,
    required this.images,
    required this.initialImageIndex,
    this.from,
    this.type,
    this.isFlagged,
  });

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  final currentPosition = 0.obs;
  final ScrollController scrollController = ScrollController();
  final RxBool isAppBarCollapsed = false.obs;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > (465 - kToolbarHeight)) {
        if (!isAppBarCollapsed.value) {
          isAppBarCollapsed.value = true;
        }
      } else {
        if (isAppBarCollapsed.value) {
          isAppBarCollapsed.value = false;
        }
      }
    });

    currentPosition.value = widget.initialImageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Hero(
        tag:
        widget.from == "fav"
            ? "image_${widget.index}"
            : "image_${widget.index}_${widget.imageGridIndex ?? 0}",
        child: BlurDismissibleWidget(
          child: CommonScaffold(
            body: SafeArea(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 465,
                    pinned: true,
                    collapsedHeight: 65,
                    elevation: 2,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Obx((){
                          return isAppBarCollapsed.value
                              ? _buildImageSlideshow()
                              :
                          GestureDetector(
                            child: _buildImageSlideshow(),
                          );
                        })
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      detail(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(height: 1, color: Colors.grey.shade400),
                      ),
                      ownerDetail(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(height: 1.5, color: Colors.grey.shade400),
                      ),
                      if (widget.from != "findRoom" &&
                          (widget.from != "findRoomUser" ||
                              widget.type != 1)) ...{
                        const SizedBox(height: 15),
                        upgradeToContact(),
                      },

                      const SizedBox(height: 15),
                      propertyDetails(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(height: 1, color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 20),
                      description(),
                      const SizedBox(height: 15),
                      features(),
                      const SizedBox(height: 15),
                      AppButton(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        text: "Message",
                        onTap: () {},
                      ),
                      const SizedBox(height: 15),
                    ]),
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 42,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColor.black50,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        Assets.iconsArrowLeft,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (widget.from == "findRoom") ...{
                    Container(
                      padding: EdgeInsets.all(12),
                      height: 42,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColor.black50,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        Assets.iconsEditPreview,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ),
                  } else ...{
                    moreMenu(context),
                  },
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          ),
        ),
      ),
    );
  }

  Widget moreMenu(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      color: AppColor.white,
      elevation: 0.5,
      menuPadding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 210),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      itemBuilder: (context) {
        final List<Map<String, String>> menuItems = [];
        menuItems.addAll([
          if (widget.type == 1 && widget.isFlagged == true ) ...[
            {'text': 'Edit', 'icon': Assets.iconsPencil},
            {'text': 'Delete', 'icon': Assets.iconsDelete},
          ] else if (widget.from == "findRoomUser") ...[
            if (widget.type == 0) ...[
              {'text': 'Edit', 'icon': Assets.iconsPencil},
              {'text': 'End Listing', 'icon': Assets.iconsPages},
            ] else ...[
              {'text': 'Edit', 'icon': Assets.iconsPencil},
              {'text': 'Delete', 'icon': Assets.iconsDelete},
              {'text': 'Renew Listing', 'icon': Assets.iconsRename},
            ],
          ] else ...[
            {'text': 'Share', 'icon': Assets.iconsShare},
            {'text': 'Report', 'icon': Assets.iconsSpam},
          ],
        ]);
        return menuItems.map((item) {
          final isLastItem = item == menuItems.last;
          return PopupMenuItem<String>(
            value: item['text'],
            height: 35,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        item['icon']!,
                        height: 20,
                        width: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        item['text']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLastItem)
                  Divider(
                    height: 1,
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                  ),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (selectedValue) {
        if (selectedValue == 'Report') {
        } else {
        }
      },
      child: Container(
        padding: EdgeInsets.all(13),
        height: 42,
        width: 44,
        decoration: BoxDecoration(
          color: AppColor.black50,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          Assets.iconsMoreVerticle,
          fit: BoxFit.cover,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImageSlideshow() {
    return Stack(
      children: [
        ImageSlideshow(
          initialPage: widget.initialImageIndex,
          indicatorColor: Colors.transparent,
          indicatorBackgroundColor: Colors.transparent,
          height: 465,
          width: double.infinity,
          autoPlayInterval: null,
          isLoop: false,
          onPageChanged: (value) => currentPosition.value = value,
          children:
          widget.images.asMap().entries.map((entry) {
            final imageUrl = entry.value;
            return Material(
              type: MaterialType.transparency,
              child: ImageView.rect(
                width: double.infinity,
                height: double.infinity,
                image: imageUrl,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.black50,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Obx(
                  () => AppText(
                text: "${currentPosition.value + 1}/${widget.images.length}",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                textSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget detail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  text: "Jane Doe",
                  textSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.circle, color: AppColor.darkGreenColor, size: 8),
                  AppText(
                    text: "2 mins ago",
                    textSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Tempa, Florida",
                    textSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      AppText(
                        text: "Budget:",
                        textSize: 14,
                        color: AppColor.textGrey,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "\$200",
                        textSize: 14,
                        color: AppColor.appColor,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        text: "/per month",
                        textSize: 14,
                        color: AppColor.textGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(Assets.iconsRoundUnlike, height: 38, width: 38),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            spacing: 5,
            children: [
              Image.asset(Assets.iconsFilledClock,height: 12,width: 12,),
              AppText(
                text: "Just listed",
                textSize: 13,
                color: AppColor.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ownerDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.from != "findRoom" &&
                      (widget.from != "findRoomUser" || widget.type != 1)) {
                  }
                },
                child: ClipOval(
                  child: Image.asset(
                    Assets.dummyImage,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.circle,
                    color: CupertinoColors.activeGreen,
                    size: 8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 3,
                  children: [
                    AppText(
                      text: "Roommate •",
                      textSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      text: "Jane",
                      textSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 3),
                AppText(
                  text: "Joined NextRoom8 in 2025",
                  textSize: 13,
                  color: AppColor.textGrey,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 3),
                Row(
                  spacing: 5,
                  children: [
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      unratedColor: Colors.grey.shade300,
                      itemCount: 5,
                      itemSize: 16,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder:
                          (context, _) => Icon(
                        Icons.star,
                        color: CupertinoColors.systemYellow,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.from != "findRoom" &&
                            (widget.from != "findRoomUser" ||
                                widget.type != 1)) {
                        }
                      },
                      child: AppText(
                        text: "(140 reviews)",
                        textSize: 11,
                        underline: true,
                        underlineSpace: -2,
                        underlineColor: AppColor.textGrey,
                        color: AppColor.textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget upgradeToContact() {
    return Container(
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              Assets.imagesGridFrame,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(Assets.imagesLockScan, height: 80, width: 80),
                const SizedBox(height: 10),
                AppText(
                  text: "Early Bird Access",
                  fontWeight: FontWeight.w700,
                  textSize: 20,
                  color: AppColor.white,
                ),
                const SizedBox(height: 15),
                AppText(
                  text:
                  "This ad was posted less than 7 days ago. You'll need to upgrade",
                  fontWeight: FontWeight.w500,
                  textSize: 14,
                  textAlign: TextAlign.center,
                  color: AppColor.white,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      useRootNavigator: true,
                      backgroundColor: Colors.white,
                      overlayStyle: SystemUiOverlayStyle.light,
                      context: context,
                      builder: (context) => PremiumBottomSheet(),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.white,
                    ),
                    child: Center(
                      child: AppText(
                        text: "Upgrade to Contact",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget propertyDetails() {
    final List<Map<String, String>> propertyInfo = [
      {'label': 'Accommodation For:', 'value': 'Myself'},
      {'label': 'Room Wanted In:', 'value': 'Tampa, Florida'},
      {'label': 'Workplace:', 'value': 'Walmart'},
      {'label': 'Ready to Move:', 'value': 'Now'},
      {'label': 'Minimum Stay:', 'value': '6 Months'},
      {'label': 'Smoke - Drink:', 'value': 'No - Yes'},
      {'label': 'Pets:', 'value': '2 Dogs - 1 Cat'},
      {'label': 'Pets (Other):', 'value': 'Guinea Pigs'},
      {'label': 'Preferred Amenities:', 'value': 'Furnished Room'},
      {'label': 'Preferred Amenities (2):', 'value': 'Private Bathroom'},
    ];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Details",
                fontWeight: FontWeight.w700,
                textSize: 18,
              ),
              if (widget.from == "findRoom" || widget.from == "Preview")
                AppText(
                  text: "Edit",
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
            ],
          ),
          const SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: propertyInfo.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: propertyInfo[index]['label']!,
                        textSize: 14,
                        color: AppColor.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        text: propertyInfo[index]['value']!,
                        textSize: 14,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  if (index < propertyInfo.length - 1)
                    const SizedBox(height: 15),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget description() {
    final RxBool showMore = false.obs;
    final String descriptionText =
        "This is a great place to reside in, having an area with a "
        "good number of shopping places and schools. "
        "The apartment is cozy and all utility supplies readily "
        "accessible. Serene and fortified living has become a must "
        "when it comes to securing a permanent address in a busy"
        "when it comes to securing a permanent address in a busy"
        "when it comes to securing a permanent address in a busy"
        "when it comes to securing a permanent address in a busy"
        "when it comes to securing a permanent address in a busy"
        "when it comes to securing a permanent address in a busy"
        " city like Dhaka.";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "Bio", fontWeight: FontWeight.w700, textSize: 18),
              if (widget.from == "findRoom" || widget.from == "Preview")
                AppText(
                  text: "Edit",
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: descriptionText,
                  textSize: 16,
                  lineHeight: 1.3,
                  color: AppColor.textBlack,
                  fontWeight: FontWeight.w400,
                  maxLines: showMore.value ? null : 8,
                  overflow:
                  showMore.value
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                if (descriptionText.length > 300)
                  GestureDetector(
                    onTap: () => showMore.toggle(),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 18),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.lightSkyBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: AppText(
                          text: showMore.value ? "Show less" : "Show more",
                          textSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget features() {
    final List<String> interests = [
      'Gym',
      'Sports',
      'Painting',
      'Fashion',
      'Gardening',
      'Sports',
      'Gym',
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Interests",
                fontWeight: FontWeight.w700,
                textSize: 18,
              ),
              if (widget.from == "findRoom" || widget.from == "Preview")
                AppText(
                  text: "Edit",
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14.0,
          children:
          interests.map((interest) {
            return FilterChip(
              label: AppText(
                text: interest,
                fontWeight: FontWeight.w500,
                textSize: 14,
              ),
              selected: false,
              onSelected: (selected) {
                debugPrint(
                  '$interest ${selected ? 'selected' : 'deselected'}',
                );
              },
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}