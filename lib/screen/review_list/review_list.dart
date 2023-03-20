import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/review_list/widget/review_body.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/shimmer_effect.dart';
import 'package:vendor/widget/validation.dart';

class ReviewList extends StatefulWidget {
  final String? id;
  final Product? model;

  const ReviewList(this.id, this.model, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateRate();
  }
}

ReviewListProvider? salesProvider;

class StateRate extends State<ReviewList> {
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    salesProvider = Provider.of<ReviewListProvider>(context, listen: false);
    salesProvider!.initializeVariable();
    salesProvider!.getReview(widget.id!, setStateNow, context);
    salesProvider!.controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (salesProvider!.controller.offset >=
            salesProvider!.controller.position.maxScrollExtent &&
        !salesProvider!.controller.position.outOfRange) {
      if (mounted) {
        if (mounted) {
          setState(
            () {
              salesProvider!.isLoadingmore = true;
              if (salesProvider!.offset < salesProvider!.total) {
                salesProvider!.getReview(widget.id!, setStateNow, context);
              }
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: salesProvider!.scaffoldKey,
      body: !salesProvider!.isLoading
          ? salesProvider!.userComment != "00.00"
              ? ReviewBody(update: setStateNow)
              : Column(
                  children: [
                    GradientAppBar(
                      Local.customerreviews,
                    ),
                    SizedBox(
                      height: height * 0.9,
                      child: Center(
                        child: Text(Local.norattingfound),
                      ),
                    ),
                  ],
                )
          : const ShimmerEffect(),
    );
  }
}
