import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../generated/assets.dart';
import 'app_bar.dart';
import 'app_text.dart';

class ShowMoreScreen extends StatelessWidget {
  const ShowMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final sampleText =
        "Everyone at Rent a Room was really helpful and "
        "mindful throughout the entire process. I want to give a "
        "special thanks to Carrie, who went out of her way to assist "
        "special thanks to Carrie, who went out of her way to assist "
        "special thanks to Carrie, who went out of her way to assist "
        "me during my move-in. She was incredibly supportive and "
        "even happily agreed to repaint my room, which made it feel "
        "even happily agreed to repaint my room, which made it feel "
        "much more like home. Thank you to Carrie and the entire team at "
        "Rent a Room. Repeating more text to make this overflow. "
        "Repainting the room made a huge difference! Very clean and accommodating.";

    return Scaffold(
      appBar: commonAppBar(isLeading: true,title: "Reviews",centerTitle: true),
      body: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// User Info
            Row(
              children: [
                Image.asset(Assets.iconsUserImage, height: 45, width: 45),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Leslie",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "2 weeks ago",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "3 months member",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            unratedColor: Colors.grey.shade300,
                            itemSize: 14,
                            itemBuilder:
                                (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (_) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Expandable Review Text
            Expanded(
              child: AppText(
                text: sampleText,
                textSize: 14,
                lineHeight: 1.4,
                color: Color(0xff10100e),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
