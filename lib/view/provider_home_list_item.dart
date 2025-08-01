import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextroom8_animation/view/person_detail_screen.dart';
import '../generated/assets.dart';
import '../utils/common/app_colors.dart';
import '../utils/common/app_text.dart';
import '../utils/common/image_view.dart';

class ProviderHomeListItem extends StatefulWidget {
  final int? index;
  final ProviderHomeModel? data;

  const ProviderHomeListItem({super.key, required this.index, this.data});

  @override
  State<ProviderHomeListItem> createState() => _ProviderHomeListItemState();
}

class _ProviderHomeListItemState extends State<ProviderHomeListItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToDetail(List<String> images, int imageIndex) {
    HapticFeedback.lightImpact();
    _animationController.forward();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PersonDetailScreen(
          index: widget.index ?? 0,
          imageGridIndex: imageIndex,
          images: images,
          initialImageIndex: 0,
          from: "home",
        ),
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));

          final scaleAnimation = Tween<double>(
            begin: 0.95,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));

          return SlideTransition(
            position: slideAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          );
        },
        opaque: false,
      ),
    ).then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 - (_slideAnimation.value * 0.05),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              color: CupertinoColors.white,
              child: Column(
                children: [
                  widget.data?.isPremium == 1
                      ? premiumSeekers(context)
                      : seekers(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget premiumSeekers(BuildContext context) {
    return Hero(
      tag: "image_${widget.index}_0",
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _navigateToDetail(widget.data?.data ?? [], 0),
                  child: ImageView.rect(
                    height: 330,
                    image: widget.data?.data[0] ?? "",
                    borderRadius: 15,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const AppText(
                    text: "Featured",
                    fontWeight: FontWeight.w600,
                    textSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: widget.data?.name ?? "",
                          fontWeight: FontWeight.w700,
                          color: AppColor.textBlack,
                          textSize: 17,
                          maxLines: 2,
                        ),
                      ),
                      Image.asset(Assets.imagesUnlike, height: 30, width: 30),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: widget.data?.ageGender ?? "",
                          fontWeight: FontWeight.w400,
                          textSize: 14,
                        ),
                      ),
                      const AppText(
                        text: "\$300",
                        fontWeight: FontWeight.w600,
                        textSize: 16,
                      ),
                      const AppText(
                        text: "/per month",
                        fontWeight: FontWeight.w400,
                        textSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppText(
                            text: "Workplace:",
                            textSize: 14,
                            color: AppColor.textGrey,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 4),
                          AppText(
                            text: widget.data?.occupation ?? "",
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Assets.iconsLocation,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 2),
                          AppText(
                            text: widget.data?.location ?? "",
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget seekers(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 2,right: 2, top: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.data?.data1?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 15,
        childAspectRatio: 0.64,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = widget.data?.data1?[index];
        return Column(
          children: [
            _buildSeekerCard(
              context: context,
              item: item,
              imageIndex: index,
              imagePath: item?.data[0] ?? "",
              name: item?.name ?? "",
              ageGender: item?.ageGender ?? "",
              occupation: item?.occupation ?? "",
              budget: item?.budget ?? "",
              location: item?.location ?? "",
              isLiked: true,
              boosted: item?.boosted ?? false,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeekerCard({
    required BuildContext context,
    required int imageIndex,
    required String imagePath,
    required String name,
    required bool? boosted,
    required String ageGender,
    required String occupation,
    required String budget,
    required String location,
    required bool isLiked,
    ProviderHomeModel? item,
  }) {
    return Hero(
      tag: "image_${widget.index}_$imageIndex",
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              type: MaterialType.transparency,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToDetail(item?.data ?? [], imageIndex),
                    child: ImageView.rect(
                      height: 130,
                      width: double.infinity,
                      image: imagePath,
                      borderRadius: 10,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (boosted == true)
                    Positioned(
                      left: -5,
                      top: -5,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const AppText(
                          text: "Boosted",
                          fontWeight: FontWeight.w600,
                          textSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: name,
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Image.asset(
                  Assets.imagesUnlike,
                  height: 28,
                  width: 28,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            AppText(text: ageGender, textSize: 12, fontWeight: FontWeight.w400),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Occupation:",
                  textSize: 12,
                  color: AppColor.textGrey,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  text: occupation,
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Budget:",
                  textSize: 12,
                  color: AppColor.textGrey,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  text: budget,
                  textSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.iconsLocation, height: 15, width: 15),
                const SizedBox(width: 2),
                Flexible(
                  child: AppText(
                    text: location,
                    textSize: 13,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderHomeModel {
  final int isPremium;
  final List<String> data;
  final String? name;
  final String? ageGender;
  final String? occupation;
  final String? budget;
  final String? location;
  final bool? boosted;
  final bool? isLiked;
  final List<ProviderHomeModel>? data1;

  ProviderHomeModel({
    required this.isPremium,
    required this.data,
    this.data1,
    this.name,
    this.ageGender,
    this.occupation,
    this.budget,
    this.location,
    this.boosted,
    this.isLiked,
  });
}