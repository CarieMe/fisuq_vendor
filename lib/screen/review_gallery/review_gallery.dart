import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/review_preview/review_preview.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/design.dart';

class ReviewGallary extends StatefulWidget {
  final List<dynamic>? imageList;

  const ReviewGallary({Key? key, this.imageList}) : super(key: key);

  @override
  _ReviewImageState createState() => _ReviewImageState();
}

class _ReviewImageState extends State<ReviewGallary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        Local.review,
        context,
      ),
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(20),
        children: List.generate(
          widget.imageList!.length,
          (index) {
            return InkWell(
              child: DesignConfiguration.getCacheNotworkImage(
                boxFit: BoxFit.cover,
                context: context,
                heightvalue: null,
                placeHolderSize: double.maxFinite,
                imageurlString: widget.imageList![index],
                widthvalue: null,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ReviewPreview(
                      index: index,
                      imageList: widget.imageList,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
