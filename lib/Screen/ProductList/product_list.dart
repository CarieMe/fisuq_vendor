import 'dart:async';
import 'package:fisuq_vendor/Widget/main/text_field.dart';
import 'package:fisuq_vendor/Widget/styled/button_icon.dart';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:fisuq_vendor/Helper/Color.dart';
import 'package:fisuq_vendor/Screen/EditProduct/EditProduct.dart';
import 'package:fisuq_vendor/Screen/FAQ/faq.dart';
import 'package:fisuq_vendor/Screen/ProductList/widget/getCommanButton.dart';
import '../../Helper/Constant.dart';
import '../../Model/ProductModel/Product.dart';
import '../../Provider/ProductListProvider.dart';
import '../../Provider/settingProvider.dart';
import '../../Widget/ButtonDesing.dart';
import '../../Widget/desing.dart';
import '../../Widget/routes.dart';
import '../../Widget/simmerEffect.dart';
import '../../Widget/systemChromeSettings.dart';
import '../../Widget/validation.dart';

import '../HomePage/Widget/commanWidget.dart';
import '../HomePage/home.dart';
import '../ReviewList/ReviewList.dart';

class ProductList extends StatefulWidget {
  final String? flag;
  final bool fromNavbar;
  const ProductList({
    super.key,
    this.flag,
    required this.fromNavbar,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

ProductListProvider? productListProvider;

class _ProductListState extends State<ProductList>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<ProductList> {
  setStateNow() {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
  bool serachIsEnable = false;
  int currentSelected = 0;
  @override
  void initState() {
    if (widget.flag == "sold") {
      currentSelected = 1;
    }
    if (widget.flag == "low") {
      currentSelected = 2;
    }
    super.initState();
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    SystemChromeSettings.setSystemUIOverlayStyleWithLightBrightNessStyle();
    productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);
    productListProvider!.initializaedVariableWithDefualtValue();

    productListProvider!.controller.addListener(_scrollListener);
    productListProvider!.flag = widget.flag;
    productListProvider!.getProduct("0", context, setStateNow);

    productListProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    productListProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: productListProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    productListProvider!.controllerForText.addListener(
      () {
        if (productListProvider!.controllerForText.text.isEmpty) {
          productListProvider!.productList.clear();

          if (mounted) {
            setState(
              () {
                productListProvider!.searchText = "";
              },
            );
          }
        } else {
          if (mounted) {
            setState(
              () {
                productListProvider!.searchText =
                    productListProvider!.controllerForText.text;
              },
            );
          }
        }

        if (productListProvider!.lastsearch !=
                productListProvider!.searchText &&
            (productListProvider!.searchText == '' ||
                productListProvider!.searchText.isNotEmpty)) {
          productListProvider!.lastsearch = productListProvider!.searchText;
          productListProvider!.isLoading = true;
          productListProvider!.offset = 0;
          productListProvider!.productList.clear();
          productListProvider!.getProduct(
            "0",
            context,
            setStateNow,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    productListProvider!.buttonController!.dispose();
    productListProvider!.controller.removeListener(() {});
    for (int i = 0; i < productListProvider!.controllers.length; i++) {
      productListProvider!.controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        //floatingActionButton: floatingBtn(context),
        key: productListProvider!.scaffoldKey,
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                buildAppBar(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            currentSelected = 0;
                            productListProvider!.flag = '';
                            setState(
                              () {
                                productListProvider!.isLoading = true;
                                productListProvider!.total = 0;
                                productListProvider!.offset = 0;
                                productListProvider!.productList.clear();
                              },
                            );
                            productListProvider!
                                .getProduct("0", context, setStateNow);
                          },
                          child: CommanButton(
                            selected: currentSelected == 0 ? true : false,
                            title: getTranslated(context, 'All')!,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            currentSelected = 1;
                            productListProvider!.flag = 'sold';
                            setState(() {
                              productListProvider!.isLoading = true;
                              productListProvider!.total = 0;
                              productListProvider!.offset = 0;
                              productListProvider!.productList.clear();
                            });
                            productListProvider!
                                .getProduct("0", context, setStateNow);
                          },
                          child: CommanButton(
                            selected: currentSelected == 1 ? true : false,
                            title: getTranslated(context, 'Soldout')!,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            currentSelected = 2;
                            productListProvider!.flag = 'low';
                            setState(() {
                              productListProvider!.isLoading = true;
                              productListProvider!.total = 0;
                              productListProvider!.offset = 0;
                              productListProvider!.productList.clear();
                            });
                            productListProvider!
                                .getProduct("0", context, setStateNow);
                          },
                          child: CommanButton(
                            selected: currentSelected == 2 ? true : false,
                            title: getTranslated(context, 'Low in Stock')!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: _showForm(),
                ),
              ],
            ),
            DesignConfiguration.showCircularProgress(
              productListProvider!.isProgress,
              primary,
            ),
          ],
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 56, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 0,
            child: !widget.fromNavbar
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.chevron_back,
                        color: Theme.of(context).indicatorColor,
                        size: 30,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            flex: 1,
            child: serachIsEnable
                ? TextFild(
                    controller: productListProvider!.controllerForText,
                    hintText: getTranslated(context, "Search"),
                    autofocus: true,
                  )
                : TextLL(
                    getTranslated(context, 'PRODUCT')!,
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                ButtonIcon(
                  onPressed: () {
                    if (!mounted) return;
                    setState(
                      () {
                        if (serachIsEnable == false) {
                          serachIsEnable = true;
                          _handleSearchStart();
                        } else {
                          serachIsEnable = false;
                          _handleSearchEnd();
                        }
                      },
                    );
                  },
                  data: Icon(
                    serachIsEnable
                        ? CupertinoIcons.multiply_circle_fill
                        : CupertinoIcons.search,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton(
                  color: Theme.of(context).canvasColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  icon: const Icon(
                    Icons.more_vert,
                    size: 24,
                  ),
                  onSelected: (dynamic value) {
                    switch (value) {
                      case 0:
                        return filterDialog();
                      case 1:
                        return sortDialog();
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsetsDirectional.only(
                            start: 0.0, end: 0.0),
                        leading: const Icon(
                          Icons.tune,
                          size: 25,
                        ),
                        title: TextBS(getTranslated(context, "Filter")!),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsetsDirectional.only(
                            start: 0.0, end: 0.0),
                        leading: const Icon(
                          Icons.sort,
                          size: 20,
                        ),
                        title: TextBS(getTranslated(context, "Sort")!),
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

  Container buildAppbar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [grad1Color, grad2Color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            Opacity(
              opacity: 0.17000000178813934,
              child: Container(
                  width: width * 0.9,
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xffffffff))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.fromNavbar
                    ? Container()
                    : InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 15.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: white,
                            size: 25,
                          ),
                        ),
                      ),
                Row(
                  children: [
                    serachIsEnable
                        ? Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 8.0),
                            child: SizedBox(
                              height: 60,
                              width: width * 0.7,
                              child: TextField(
                                controller:
                                    productListProvider!.controllerForText,
                                autofocus: true,
                                style: const TextStyle(
                                  color: white,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.search, color: white),
                                  hintText: getTranslated(context, "Search"),
                                  hintStyle: const TextStyle(color: white),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: white,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 36,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 9.0,
                                start: 15,
                                end: 15,
                              ),
                              child: Text(
                                getTranslated(context, 'PRODUCT')!,
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  color: Color(0xffffffff),
                                  fontSize: textFontSize16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!mounted) return;
                        setState(
                          () {
                            if (serachIsEnable == false) {
                              serachIsEnable = true;
                              _handleSearchStart();
                            } else {
                              serachIsEnable = false;
                              _handleSearchEnd();
                            }
                          },
                        );
                        // Routes.navigateToSearch(context);
                      },
                      child: Icon(
                        serachIsEnable ? Icons.close : Icons.search,
                        color: white,
                        size: 18,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 18,
                        ),
                        onSelected: (dynamic value) {
                          switch (value) {
                            case 0:
                              return filterDialog();
                            case 1:
                              return sortDialog();
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: 0,
                            child: ListTile(
                              dense: true,
                              contentPadding: const EdgeInsetsDirectional.only(
                                  start: 0.0, end: 0.0),
                              leading: const Icon(
                                Icons.tune,
                                color: primary,
                                size: 25,
                              ),
                              title: Text(getTranslated(context, "Filter")!),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              dense: true,
                              contentPadding: const EdgeInsetsDirectional.only(
                                  start: 0.0, end: 0.0),
                              leading: const Icon(
                                Icons.sort,
                                color: primary,
                                size: 20,
                              ),
                              title: Text(getTranslated(context, "Sort")!),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(int index) {
    double? price;
    if (index < productListProvider!.productList.length) {
      Product? model = productListProvider!.productList[index];
      productListProvider!.totalProduct = model.total;
      String stockType = "";
      if (model.stockType == "null") {
        stockType = "Not enabled";
      } else if (model.stockType == "1" || model.stockType == "0") {
        stockType = "Global";
      } else if (model.stockType == "2") {
        stockType = "Varient wise";
      }
      if (productListProvider!.controllers.length < index + 1) {
        productListProvider!.controllers.add(TextEditingController());
      }

      if (model.prVarientList!.isNotEmpty) {
        productListProvider!.controllers[index].text =
            model.prVarientList![model.selVarient!].cartCount!;
        double price =
            double.parse(model.prVarientList![model.selVarient!].disPrice!);
        if (price == 0) {
          price = double.parse(model.prVarientList![model.selVarient!].price!);
        }
      }
      productListProvider!.items = List<String>.generate(
          model.totalAllow != "" ? int.parse(model.totalAllow!) : 10,
          (i) => (i + 1).toString());

      return Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          left: 10.0,
          bottom: 13,
        ),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditProduct(
                  model: model,
                ),
              ),
            ).then(
              (value) => () {
                setState(
                  () {
                    productListProvider!.isLoading = true;
                    productListProvider!.offset = 0;
                    productListProvider!.total = 0;
                    productListProvider!.productList.clear();
                  },
                );
                return productListProvider!
                    .getProduct("0", context, setStateNow);
              }(),
            );
          },
          child: InkWell(
            borderRadius: BorderRadius.circular(circularBorderRadius5),
            child: NeuContainer(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 12.0,
                          start: 12.0,
                          end: 12.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 12.0,
                              ),
                              child: Hero(
                                tag: "$index${model.id}+ $index${model.name}",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      circularBorderRadius5),
                                  child:
                                      DesignConfiguration.getCacheNotworkImage(
                                    boxFit: BoxFit.cover,
                                    context: context,
                                    heightvalue: 70.0,
                                    placeHolderSize: 70.0,
                                    imageurlString: model.image!,
                                    widthvalue: 70.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: TextBL(
                                      model.name!,
                                    ),
                                  ),
                                  model.prVarientList!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            children: <Widget>[
                                              TextI(
                                                "${getTranslated(context, 'PRICE_LBL')} : ",
                                                size: 16,
                                              ),
                                              model.prVarientList!.isNotEmpty
                                                  ? TextTM(
                                                      double.parse(model
                                                                  .prVarientList![
                                                                      model
                                                                          .selVarient!]
                                                                  .disPrice!) !=
                                                              0
                                                          ? DesignConfiguration
                                                              .getPriceFormat(
                                                              context,
                                                              double.parse(model
                                                                  .prVarientList![
                                                                      model
                                                                          .selVarient!]
                                                                  .disPrice!),
                                                            )!
                                                          : "",
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Row(
                                    children: [
                                      TextI(
                                        '${getTranslated(context, 'Quantity')!} : ',
                                        size: 16,
                                      ),
                                      TextTL(
                                        model.stockType == "2"
                                            ? model.totalStock == null ||
                                                    model.totalStock! == ""
                                                ? "0"
                                                : model.totalStock!
                                            : model.stock == null ||
                                                    model.stock! == ""
                                                ? "0"
                                                : model.stock!,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 11.0,
                          start: 6.0,
                          end: 6.0,
                          bottom: 10.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<String>(
                                      builder: (context) => AddFAQs(
                                        model.id,
                                        model,
                                      ),
                                    ),
                                  );
                                },
                                child: commanBtn(
                                    getTranslated(context, "Product FAQ")!,
                                    false,
                                    model.availability == "0" ||
                                        model.availability == null,
                                    context),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute<String>(
                                      builder: (context) => ReviewList(
                                        model.id,
                                        model,
                                      ),
                                    ),
                                  );
                                },
                                child: commanBtn(
                                    getTranslated(context, "Review")!,
                                    false,
                                    model.availability == "0",
                                    context),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (model.status != "1") {
                                    productListProvider!.updateProductStatus(
                                        model.id!, "1", context, setStateNow);
                                  } else {
                                    productListProvider!.updateProductStatus(
                                        model.id!, "0", context, setStateNow);
                                  }
                                },
                                child: commanBtn(
                                    model.status == "1"
                                        ? getTranslated(context, 'Enable')!
                                        : getTranslated(context, "Disable")!,
                                    true,
                                    model.status != "1",
                                    context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 15,
                    top: 12,
                    child: InkWell(
                      onTap: () {
                        productDeletDialog(
                          model.name!,
                          model.id!,
                          context,
                        );
                      },
                      child: SvgPicture.asset(
                        DesignConfiguration.setSvgPath('delete'),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void sortDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ButtonBarTheme(
          data: const ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
          ),
          child: AlertDialog(
            elevation: 2.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  circularBorderRadius5,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 19.0, bottom: 16.0),
                    child: Text(
                      getTranslated(context, "SortBy")!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const Divider(color: lightBlack),
                  GestureDetector(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            getTranslated(context, "TopRated")!,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: lightBlack,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      productListProvider!.sortBy = '';
                      productListProvider!.orderBy = 'DESC';
                      productListProvider!.flag = '';
                      if (mounted) {
                        setState(
                          () {
                            productListProvider!.isLoading = true;
                            productListProvider!.total = 0;
                            productListProvider!.offset = 0;
                            productListProvider!.productList.clear();
                          },
                        );
                      }
                      productListProvider!
                          .getProduct("1", context, setStateNow);
                      Navigator.pop(context, 'option 1');
                    },
                  ),
                  const Divider(color: lightBlack),
                  GestureDetector(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              getTranslated(context, "NewestFirst")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        productListProvider!.sortBy = 'p.date_added';
                        productListProvider!.orderBy = 'DESC';
                        productListProvider!.flag = '';
                        if (mounted) {
                          setState(() {
                            productListProvider!.isLoading = true;
                            productListProvider!.total = 0;
                            productListProvider!.offset = 0;
                            productListProvider!.productList.clear();
                          });
                        }
                        productListProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 1');
                      }),
                  const Divider(color: lightBlack),
                  GestureDetector(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              getTranslated(context, "OldestFirst")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: lightBlack),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        productListProvider!.sortBy = 'p.date_added';
                        productListProvider!.orderBy = 'ASC';
                        productListProvider!.flag = '';
                        if (mounted) {
                          setState(() {
                            productListProvider!.isLoading = true;
                            productListProvider!.total = 0;
                            productListProvider!.offset = 0;
                            productListProvider!.productList.clear();
                          });
                        }
                        productListProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 2');
                      }),
                  const Divider(color: lightBlack),
                  GestureDetector(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              getTranslated(context, "LOWTOHIGH")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: lightBlack),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        productListProvider!.sortBy = 'pv.price';
                        productListProvider!.orderBy = 'ASC';
                        productListProvider!.flag = '';
                        if (mounted) {
                          setState(() {
                            productListProvider!.isLoading = true;
                            productListProvider!.total = 0;
                            productListProvider!.offset = 0;
                            productListProvider!.productList.clear();
                          });
                        }
                        productListProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 3');
                      }),
                  const Divider(color: lightBlack),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 5.0),
                    child: GestureDetector(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              getTranslated(context, "HIGHTOLOW")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: lightBlack),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        productListProvider!.sortBy = 'pv.price';
                        productListProvider!.orderBy = 'DESC';
                        productListProvider!.flag = '';
                        if (mounted) {
                          setState(
                            () {
                              productListProvider!.isLoading = true;
                              productListProvider!.total = 0;
                              productListProvider!.offset = 0;
                              productListProvider!.productList.clear();
                            },
                          );
                        }
                        productListProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 4');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSearchEnd() {
    if (!mounted) return;
    setState(
      () {
        serachIsEnable = false;
        productListProvider!.controllerForText.clear();
      },
    );
  }

  void _handleSearchStart() {
    if (!mounted) return;
    setState(
      () {},
    );
  }

  _scrollListener() {
    if (productListProvider!.controller.offset >=
            productListProvider!.controller.position.maxScrollExtent &&
        !productListProvider!.controller.position.outOfRange) {
      if (mounted) {
        if (mounted) {
          setState(
            () {
              isLoadingmore = true;

              if (productListProvider!.offset < productListProvider!.total)
                productListProvider!.getProduct("0", context, setStateNow);
            },
          );
        }
      }
    }
  }

  Future<void> _refresh() {
    if (mounted) {
      setState(
        () {
          productListProvider!.isLoading = true;
          isLoadingmore = true;
          productListProvider!.offset = 0;
          productListProvider!.total = 0;
          productListProvider!.productList.clear();
        },
      );
    }
    return productListProvider!.getProduct("0", context, setStateNow);
  }

  _showForm() {
    return productListProvider!.isLoading
        ? const ShimmerEffect()
        : productListProvider!.productList.isEmpty
            ? DesignConfiguration.getNoItem(context)
            : RefreshIndicator(
                key: productListProvider!.refreshIndicatorKey,
                onRefresh: _refresh,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: productListProvider!.controller,
                    itemCount: (productListProvider!.offset <
                            productListProvider!.total)
                        ? productListProvider!.productList.length + 1
                        : productListProvider!.productList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return (index ==
                                  productListProvider!.productList.length &&
                              isLoadingmore)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : listItem(index);
                    },
                  ),
                ),
              );
  }

  productDeletDialog(
    String productName,
    String id,
    BuildContext cntx,
  ) async {
    String pName = productName;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(circularBorderRadius5),
                ),
              ),
              content: Text(
                "${getTranslated(context, "sure")!} \"  $pName \" ${getTranslated(context, "PRODUCT")!}",
                style: Theme.of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: primary),
              ),
              actions: <Widget>[
                TextButton(
                    child: Text(
                      getTranslated(context, "LOGOUTNO")!,
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                              color: lightBlack, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                TextButton(
                  child: Text(
                    getTranslated(context, "LOGOUTYES")!,
                    style: Theme.of(this.context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: primary, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                    productListProvider!.deleteProductApi(
                      id,
                      cntx,
                      setStateNow,
                    );
                    setState(
                      () {
                        productListProvider!.isLoading = true;
                        isLoadingmore = true;
                        productListProvider!.offset = 0;
                        productListProvider!.total = 0;
                        productListProvider!.productList.clear();
                        productListProvider!
                            .getProduct("0", context, setStateNow);
                      },
                    );
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  void filterDialog() {
    if (productListProvider!.filterList!.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 30.0),
                    child: AppBar(
                      backgroundColor: lightWhite,
                      title: Text(
                        getTranslated(context, "Filter")!,
                        style: const TextStyle(
                          color: fontColor,
                        ),
                      ),
                      elevation: 5,
                      leading: Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: DesignConfiguration.shadow(),
                            child: Card(
                              elevation: 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    circularBorderRadius5),
                                onTap: () => Navigator.of(context).pop(),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.only(end: 4.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      actions: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 10.0),
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text(
                              getTranslated(context, "ClearFilters")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: fontColor,
                                  ),
                            ),
                            onTap: () {
                              if (mounted) {
                                setState(
                                  () {
                                    productListProvider!.selectedId.clear();
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: lightWhite,
                      padding: const EdgeInsetsDirectional.only(
                        start: 7.0,
                        end: 7.0,
                        top: 7.0,
                      ),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: lightWhite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 10.0),
                                  itemCount:
                                      productListProvider!.filterList!.length,
                                  itemBuilder: (context, index) {
                                    productListProvider!.attsubList =
                                        productListProvider!.filterList![index]
                                                ['attribute_values']
                                            .split(',');

                                    productListProvider!.attListId =
                                        productListProvider!.filterList![index]
                                                ['attribute_values_id']
                                            .split(',');

                                    if (productListProvider!.filter == "") {
                                      productListProvider!.filter =
                                          productListProvider!.filterList![0]
                                              ["name"];
                                    }

                                    return InkWell(
                                      onTap: () {
                                        if (mounted) {
                                          setState(
                                            () {
                                              productListProvider!.filter =
                                                  productListProvider!
                                                          .filterList![index]
                                                      ['name'];
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20,
                                                top: 10.0,
                                                bottom: 10.0),
                                        decoration: BoxDecoration(
                                          color: productListProvider!.filter ==
                                                  productListProvider!
                                                          .filterList![index]
                                                      ['name']
                                              ? white
                                              : lightWhite,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(
                                                circularBorderRadius7),
                                            bottomLeft: Radius.circular(
                                              7,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          productListProvider!
                                              .filterList![index]['name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                color: productListProvider!
                                                            .filter ==
                                                        productListProvider!
                                                                .filterList![
                                                            index]['name']
                                                    ? fontColor
                                                    : lightBlack,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsetsDirectional.only(top: 10.0),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    productListProvider!.filterList!.length,
                                itemBuilder: (context, index) {
                                  if (productListProvider!.filter ==
                                      productListProvider!.filterList![index]
                                          ["name"]) {
                                    productListProvider!.attsubList =
                                        productListProvider!.filterList![index]
                                                ['attribute_values']
                                            .split(',');

                                    productListProvider!.attListId =
                                        productListProvider!.filterList![index]
                                                ['attribute_values_id']
                                            .split(',');
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: productListProvider!
                                          .attListId!.length,
                                      itemBuilder: (context, i) {
                                        return CheckboxListTile(
                                          dense: true,
                                          title: Text(
                                              productListProvider!
                                                  .attsubList![i],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: lightBlack,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                          value: productListProvider!.selectedId
                                              .contains(productListProvider!
                                                  .attListId![i]),
                                          activeColor: primary,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (bool? val) {
                                            if (mounted) {
                                              setState(
                                                () {
                                                  if (val == true) {
                                                    productListProvider!
                                                        .selectedId
                                                        .add(
                                                            productListProvider!
                                                                .attListId![i]);
                                                  } else {
                                                    productListProvider!
                                                        .selectedId
                                                        .remove(
                                                            productListProvider!
                                                                .attListId![i]);
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productListProvider!.total.toString()),
                              Text(getTranslated(context, "Productsfound")!),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SimBtn(
                          size: 0.4,
                          title: getTranslated(context, "Apply")!,
                          onBtnSelected: () {
                            productListProvider!.selId =
                                productListProvider!.selectedId.join(',');

                            if (mounted) {
                              setState(
                                () {
                                  productListProvider!.isLoading = true;
                                  productListProvider!.total = 0;
                                  productListProvider!.offset = 0;
                                  productListProvider!.productList.clear();
                                },
                              );
                            }
                            productListProvider!
                                .getProduct("0", context, setStateNow);
                            Navigator.pop(context, 'Product Filter');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      );
    }
  }
}
