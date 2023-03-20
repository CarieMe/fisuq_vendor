import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/snackbar.dart';
import 'package:vendor/widget/validation.dart';

class ReviewListProvider extends ChangeNotifier {
  bool isLoading = true;
  List<ProductRatting> reviewList = [];
  List<imgModel> revImgList = [];
  bool isLoadingmore = true;
  ScrollController controller = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPhotoVisible = true;
  var star1 = '0',
      star2 = '0',
      star3 = '0',
      star4 = '0',
      star5 = '0',
      averageRating = '0';
  String? userComment = '', userRating = '0.0';
  int offset = 0;
  int total = 0;
  initializeVariable() {
    isLoading = true;
    reviewList = [];
    revImgList = [];
    isLoadingmore = true;
    isPhotoVisible = true;
    star1 = '0';
    star2 = '0';
    star3 = '0';
    star4 = '0';
    star5 = '0';
    averageRating = '0';
    userComment = '';
    userRating = '0.0';
    offset = 0;
    total = 0;
  }

  Future<void> getReview(
    String id,
    Function update,
    BuildContext context,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var parameter = {
          ProductId: id,
          LIMIT: perPage.toString(),
          OFFSET: offset.toString(),
        };

        var result =
            await ReviewListRepository.getReviewList(parameter: parameter);

        bool error = result['error'];
        String? msg = result['message'];

        if (!error) {
          star1 = result['star_1'];
          star2 = result['star_2'];
          star3 = result['star_3'];
          star4 = result['star_4'];
          star5 = result['star_5'];
          averageRating = result['product_rating'];

          total = int.parse(result['total']);
          offset = offset;
          if (offset < total) {
            var data = result['data'];
            reviewList = (data as List)
                .map(
                  (data) => ProductRatting.fromJson(data),
                )
                .toList();
            offset = offset + perPage;
          }
          isLoadingmore = false;
          update();
        } else {
          if (msg != 'No ratings found !') {
            setSnackbar(
              msg!,
              context,
            );
          }
          isLoadingmore = false;
          userComment = "00.00";
        }
        isLoading = false;
        update();
      } on TimeoutException catch (_) {
        setSnackbar(Local.somethingmessahe, context);
        isLoading = false;
        update();
      }
    } else {
      isNetworkAvail = false;
      update();
    }
  }
}
