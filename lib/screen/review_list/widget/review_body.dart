import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/review_list/review_list.dart';
import 'package:vendor/screen/review_list/widget/common_widget.dart';
import 'package:vendor/screen/review_list/widget/review_image.dart';
import 'package:vendor/screen/review_list/widget/review_image_index.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/design.dart';

class ReviewBody extends StatelessWidget {
  Function update;
  ReviewBody({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GradientAppBar(
            Local.customerreviews,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Text(
                        salesProvider!.averageRating,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: textFontSize30),
                      ),
                      Text(
                          "${salesProvider!.reviewList.length}   ${Local.ratings}")
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        getRatingBarIndicator(5.0, 5),
                        getRatingBarIndicator(4.0, 4),
                        getRatingBarIndicator(3.0, 3),
                        getRatingBarIndicator(2.0, 2),
                        getRatingBarIndicator(1.0, 1),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getRatingIndicator(
                            int.parse(salesProvider!.star5), context),
                        getRatingIndicator(
                            int.parse(salesProvider!.star4), context),
                        getRatingIndicator(
                            int.parse(salesProvider!.star3), context),
                        getRatingIndicator(
                            int.parse(salesProvider!.star2), context),
                        getRatingIndicator(
                            int.parse(salesProvider!.star1), context),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTotalStarRating(salesProvider!.star5),
                      getTotalStarRating(salesProvider!.star4),
                      getTotalStarRating(salesProvider!.star3),
                      getTotalStarRating(salesProvider!.star2),
                      getTotalStarRating(salesProvider!.star1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          salesProvider!.revImgList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            Local.imagesbycustomers,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        const ReviewImageWidget(),
                      ],
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${salesProvider!.reviewList.length} ${Local.review}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textFontSize23,
                      ),
                    ),
                  ],
                ),
                salesProvider!.revImgList.isNotEmpty
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              salesProvider!.isPhotoVisible =
                                  !salesProvider!.isPhotoVisible;
                            },
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: salesProvider!.isPhotoVisible
                                    ? primary
                                    : white,
                                borderRadius: BorderRadius.circular(
                                    circularBorderRadius3),
                                border: Border.all(
                                  color: primary,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: salesProvider!.isPhotoVisible
                                    ? const Icon(
                                        Icons.check,
                                        size: 15.0,
                                        color: white,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            Local.withphoto,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            controller: salesProvider!.controller,
            itemCount: (salesProvider!.offset < salesProvider!.total)
                ? salesProvider!.reviewList.length + 1
                : salesProvider!.reviewList.length,
            itemBuilder: (context, index) {
              if (index == salesProvider!.reviewList.length &&
                  salesProvider!.isLoadingmore) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                salesProvider!.reviewList[index].username!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RatingBarIndicator(
                                    rating: double.parse(salesProvider!
                                        .reviewList[index].rating!),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 12.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const Spacer(),
                                  Text(
                                    salesProvider!.reviewList[index].date!,
                                    style: const TextStyle(
                                        color: lightBlack2,
                                        fontSize: textFontSize10),
                                  )
                                ],
                              ),
                              salesProvider!.reviewList[index].comment != '' &&
                                      salesProvider!
                                          .reviewList[index].comment!.isNotEmpty
                                  ? Text(
                                      salesProvider!
                                              .reviewList[index].comment ??
                                          '',
                                      textAlign: TextAlign.left,
                                    )
                                  : Container(),
                              salesProvider!.isPhotoVisible
                                  ? ReviwImageWidgetIndex(i: index)
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(circularBorderRadius25),
                        child: DesignConfiguration.getCacheNotworkImage(
                          boxFit: BoxFit.fill,
                          context: context,
                          heightvalue: 36,
                          placeHolderSize: 36,
                          imageurlString:
                              salesProvider!.reviewList[index].userProfile!,
                          widthvalue: 36,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
