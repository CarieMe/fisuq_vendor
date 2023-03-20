import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/screen/product_preview/product_preview.dart';
import 'package:vendor/screen/review_gallery/review_gallery.dart';
import 'package:vendor/screen/review_list/review_list.dart';
import 'package:vendor/screen/review_preview/review_preview.dart';
import 'package:vendor/widget/design.dart';

class ReviwImageWidgetIndex extends StatelessWidget {
  int i;
  ReviwImageWidgetIndex({
    Key? key,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: salesProvider!.reviewList[i].Images!.isNotEmpty ? 100 : 0,
      child: ListView.builder(
        itemCount: salesProvider!.reviewList[i].Images!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsetsDirectional.only(end: 10, bottom: 5.0, top: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ProductPreview(
                      pos: index,
                      secPos: 0,
                      index: 0,
                      id: "$index${salesProvider!.reviewList[i].id}",
                      imgList: salesProvider!.reviewList[i].Images,
                      list: true,
                      from: false,
                      screenSize: MediaQuery.of(context).size,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: '$index${salesProvider!.reviewList[i].id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(circularBorderRadius5),
                  child: DesignConfiguration.getCacheNotworkImage(
                    boxFit: BoxFit.cover,
                    context: context,
                    heightvalue: 100,
                    placeHolderSize: 50,
                    imageurlString: salesProvider!.reviewList[i].Images![index],
                    widthvalue: 100,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
