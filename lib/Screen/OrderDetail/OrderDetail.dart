import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Helper/Color.dart';
import 'package:sellermultivendor/Widget/parameterString.dart';
import 'package:sellermultivendor/Model/OrdersModel/OrderItemsModel.dart';
import 'package:sellermultivendor/Model/OrdersModel/OrderModel.dart';
import 'package:sellermultivendor/Model/Person/PersonModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/ApiBaseHelper.dart';
import '../../Helper/Constant.dart';
import '../../Provider/settingProvider.dart';
import '../../Widget/api.dart';
import '../../Widget/appBar.dart';
import '../../Widget/desing.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/routes.dart';
import '../../Widget/sharedPreferances.dart';
import '../../Widget/simmerEffect.dart';
import '../../Widget/snackbar.dart';
import '../../Widget/validation.dart';
import '../EmailSend/email.dart';
import '../HomePage/home.dart';
import '../../Widget/noNetwork.dart';
import 'Widget/PriceDetail.dart';
import 'Widget/bankProff.dart';
import 'Widget/orderBasicDetail.dart';
import 'Widget/shippingDetail.dart';

class OrderDetail extends StatefulWidget {
  final String? id;

  const OrderDetail({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateOrder();
  }
}

List<PersonModel> delBoyList = [];

class StateOrder extends State<OrderDetail> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController? courierAgencyController, urlController;
  Order_Model? model;
  String? pDate,
      prDate,
      sDate,
      dDate,
      cDate,
      rDate,
      url,
      courierAgency,
      trackingId;
  List<String> statusList = [
    PLACED,
    PROCESSED,
    SHIPED,
    DELIVERD,
    CANCLED,
    RETURNED,
  ];

  List<String> digitalList = [
    PLACED,
    DELIVERD,
  ];
  bool isLoading = true;

  List<Order_Model> tempList = [];
  bool isProgress = false;
  String? curStatus;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController? otpC;
  final List<DropdownMenuItem> items = [];
  List<PersonModel> searchList = [];
  int? selectedDelBoy;
  final TextEditingController _controller = TextEditingController();
  late StateSetter delBoyState;
  bool fabIsVisible = true;

  @override
  void initState() {
    getDeliveryBoy();
    Future.delayed(Duration.zero, getOrderDetail);
    super.initState();
    controller = ScrollController();
    controller.addListener(
      () {
        setState(
          () {
            fabIsVisible = controller.position.userScrollDirection ==
                ScrollDirection.forward;
          },
        );
      },
    );
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    _controller.addListener(
      () {
        searchOperation(_controller.text);
      },
    );
  }

//==============================================================================
//========================= getDeliveryBoy API =================================

  Future<void> getDeliveryBoy() async {
    context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);
    var parameter = {
      SellerId: context.read<SettingProvider>().CUR_USERID,
    };

    ApiBaseHelper().postAPICall(getDeliveryBoysApi, parameter).then(
      (getdata) async {
        bool error = getdata["error"];
        String? msg = getdata["message"];

        if (!error) {
          delBoyList.clear();
          var data = getdata["data"];
          delBoyList =
              (data as List).map((data) => PersonModel.fromJson(data)).toList();
        } else {
          setSnackbar(
            msg!,
            context,
          );
        }
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }

  Future<void> getOrderDetail() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);
      var parameter = {
        SellerId: context.read<SettingProvider>().CUR_USERID,
        Id: widget.id,
      };
      ApiBaseHelper().postAPICall(getOrdersApi, parameter).then(
        (getdata) async {
          bool error = getdata["error"];
          if (!error) {
            var data = getdata["data"];
            if (data.length != 0) {
              tempList = (data as List)
                  .map((data) => Order_Model.fromJson(data))
                  .toList();

              for (int i = 0; i < tempList[0].itemList!.length; i++) {
                tempList[0].itemList![i].curSelected =
                    tempList[0].itemList![i].status;
              }
              searchList.clear();
              searchList.addAll(delBoyList);
              if (tempList[0].itemList![0].deliveryBoyId != null) {
                selectedDelBoy = delBoyList.indexWhere(
                    (f) => f.id == tempList[0].itemList![0].deliveryBoyId);
              }
              if (selectedDelBoy == -1) selectedDelBoy = null;

              if (tempList[0].payMethod == "Bank Transfer") {
                statusList.removeWhere((element) => element == PLACED);
              }
              curStatus = tempList[0].itemList![0].activeStatus!;
              if (tempList[0].listStatus!.contains(PLACED)) {
                pDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(PLACED)];

                if (pDate != null) {
                  List d = pDate!.split(" ");
                  pDate = d[0] + "\n" + d[1];
                }
              }
              if (tempList[0].listStatus!.contains(PROCESSED)) {
                prDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(PROCESSED)];
                if (prDate != null) {
                  List d = prDate!.split(" ");
                  prDate = d[0] + "\n" + d[1];
                }
              }
              if (tempList[0].listStatus!.contains(SHIPED)) {
                sDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(SHIPED)];
                if (sDate != null) {
                  List d = sDate!.split(" ");
                  sDate = d[0] + "\n" + d[1];
                }
              }
              if (tempList[0].listStatus!.contains(DELIVERD)) {
                dDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(DELIVERD)];
                if (dDate != null) {
                  List d = dDate!.split(" ");
                  dDate = d[0] + "\n" + d[1];
                }
              }
              if (tempList[0].listStatus!.contains(CANCLED)) {
                cDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(CANCLED)];
                if (cDate != null) {
                  List d = cDate!.split(" ");
                  cDate = d[0] + "\n" + d[1];
                }
              }
              if (tempList[0].listStatus!.contains(RETURNED)) {
                rDate = tempList[0]
                    .listDate![tempList[0].listStatus!.indexOf(RETURNED)];
                if (rDate != null) {
                  List d = rDate!.split(" ");
                  rDate = d[0] + "\n" + d[1];
                }
              }
              model = tempList[0];
              emailController.text = tempList[0].email ?? '';
              messageController.text =
                  'Hello Dear ${tempList[0].name},\nYou have purchase our digital product and we are happy to share the product with you, you can get product with this mail attachment.\nThank You ...!';
            } else {}
            setState(
              () {
                isLoading = false;
              },
            );
          } else {}
        },
        onError: (error) {
          setSnackbar(
            error.toString(),
            context,
          );
        },
      );
    } else {
      if (mounted) {
        setState(
          () {
            isNetworkAvail = false;
          },
        );
      }
    }

    return;
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => super.widget));
        } else {
          await buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightWhite,
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: fabIsVisible ? 1 : 0,
        child: customerViewPermission
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.small(
                    backgroundColor: white,
                    onPressed: () async {
                      String text =
                          '${getTranslated(context, "Hello")!} ${tempList[0].name},\n${getTranslated(context, "Your order with id")!} : ${tempList[0].id} ${getTranslated(context, "is")!} ${tempList[0].itemList![0].activeStatus}. ${getTranslated(context, "If you have further query feel free to contact us.Thank you")!}';
                      var androiduri = 'sms:${tempList[0].mobile}?body=$text';
                      var iosuri = 'sms:${tempList[0].mobile}&body=$text';
                      var androidencoded = Uri.encodeFull(androiduri);
                      var iosencoded = Uri.encodeFull(iosuri);

                      if (Platform.isIOS) {
                        // for iOS phone only
                        if (await canLaunchUrl(
                            Uri.parse(iosencoded.toString()))) {
                          await launchUrl(
                            Uri.parse(iosencoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          launchUrl(
                            Uri.parse(iosencoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      } else {
                        // android , web
                        if (await canLaunchUrl(
                            Uri.parse(androidencoded.toString()))) {
                          await launchUrl(
                            Uri.parse(androidencoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          launchUrl(
                            Uri.parse(androidencoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                      //await launch(uri);
                    },
                    heroTag: null,
                    child: const Icon(
                      Icons.message,
                      color: primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  FloatingActionButton.small(
                    backgroundColor: white,
                    onPressed: () async {
                      String text =
                          '${getTranslated(context, "Hello")!} ${tempList[0].name} \n${getTranslated(context, "Your order with id")!} : ${tempList[0].id} ${getTranslated(context, "is")!} ${tempList[0].itemList![0].activeStatus}. ${getTranslated(context, "If you have further query feel free to contact us.Thank you")!}.';

                      var whatsapp =
                          ("${tempList[0].countryCode!}${tempList[0].mobile!}");
                      var whatsappURlAndroid =
                          "https://wa.me/$whatsapp?text=$text";
                      var whatappURLIos = "https://wa.me/$whatsapp?text=$text";
                      var encoded = Uri.encodeFull(whatappURLIos);

                      if (Platform.isIOS) {
                        // for iOS phone only
                        if (await canLaunchUrl(Uri.parse(encoded.toString()))) {
                          await launchUrl(
                            Uri.parse(
                              encoded.toString(),
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          launchUrl(
                            Uri.parse(
                              encoded.toString(),
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      } else {
                        // android , web
                        if (await canLaunchUrl(Uri.parse(encoded.toString()))) {
                          await launchUrl(
                            Uri.parse(encoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          launchUrl(
                            Uri.parse(encoded.toString()),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    heroTag: null,
                    child: Image.asset(
                      DesignConfiguration.setPngPath('whatsapp'),
                      width: 20,
                      height: 20,
                      color: primary,
                    ),
                  ),
                ],
              )
            : Container(),
      ),
      body: isNetworkAvail
          ? Stack(
              children: [
                isLoading
                    ? const ShimmerEffect()
                    : Column(
                        children: [
                          GradientAppBar(
                            getTranslated(context, "ORDER_DETAIL")!,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: controller,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Column(
                                  children: [
                                    OrderBasicDetail(model: model),
                                    model!.delDate != null &&
                                            model!.delDate!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        circularBorderRadius5)),
                                                color: white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: blarColor,
                                                      offset: Offset(0, 0),
                                                      blurRadius: 4,
                                                      spreadRadius: 0),
                                                ],
                                              ),
                                              height: 52,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 6.0,
                                                  left: 10.0,
                                                  right: 10.0,
                                                  bottom: 6.0,
                                                ),
                                                child: Text(
                                                  "${getTranslated(context, "PREFER_DATE_TIME")!}: ${model!.delDate!} - ${model!.delTime!}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                        fontFamily:
                                                            'PlusJakartaSans',
                                                        color: grey3,
                                                        fontSize:
                                                            textFontSize13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    //iteam's here
                                    MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: model!.itemList!.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          OrderItem orderItem =
                                              model!.itemList![i];
                                          return productItem(
                                            orderItem,
                                            model!,
                                            i,
                                          );
                                        },
                                      ),
                                    ),
                                    //complete
                                    model!.payMethod == "Bank Transfer"
                                        ? BankProof(model: model!)
                                        : Container(),
                                    model!.itemList![0].productType ==
                                            'digital_product'
                                        ? Container()
                                        : ShippingDetail(tempList: tempList),
                                    PriceDetail(tempList: tempList),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                DesignConfiguration.showCircularProgress(isProgress, primary),
              ],
            )
          : noInternet(
              context,
              setStateNoInternate,
              buttonSqueezeanimation,
              buttonController,
            ),
    );
  }

  // emailSendButtomSheet(
  //   BuildContext context,
  //   Function setState,
  //   String? name,
  // ) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //         ),
  //         child: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setStater) {
  //             return Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(circularBorderRadius25),
  //                   topRight: Radius.circular(circularBorderRadius25),
  //                 ),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
  //                     child: Center(
  //                       child: Text(
  //                         'Send Mail',
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .subtitle1!
  //                             .copyWith(color: primary),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
  //                     child: Text(
  //                       "Email",
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(vertical: 5),
  //                       child: TextField(
  //                         controller: emailController,
  //                         style: Theme.of(context).textTheme.subtitle2,
  //                         decoration: InputDecoration(
  //                           contentPadding:
  //                               const EdgeInsets.symmetric(horizontal: 10),
  //                           border: InputBorder.none,
  //                           filled: true,
  //                           fillColor: primary.withOpacity(0.1),
  //                           hintText: 'Enter Email Id',
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
  //                     child: Text(
  //                       "Message",
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(vertical: 5),
  //                       child: TextField(
  //                         controller: messageController,
  //                         maxLines: 5,
  //                         style: Theme.of(context).textTheme.subtitle2,
  //                         decoration: InputDecoration(
  //                           contentPadding:
  //                               const EdgeInsets.symmetric(horizontal: 10),
  //                           border: InputBorder.none,
  //                           filled: true,
  //                           fillColor: primary.withOpacity(0.1),
  //                           hintText: 'Enter Email Id',
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 10),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         InkWell(
  //                           onTap: () async {
  //                             print("we are here ");
  //                             Navigator.push(
  //                               context,
  //                               CupertinoPageRoute(
  //                                 builder: (context) => SendMail(
  //                                   email: ,
  //                                   productName:   orderItem.name ?? "",
  //                                 ),
  //                               ),
  //                             );
  //                             // final Email email = Email(
  //                             //   body: messageController.text,
  //                             //   subject:
  //                             //       "Attachment for Download Product : $name",
  //                             //   recipients: [emailController.text],
  //                             //   isHTML: false,
  //                             // );
  //                             // await FlutterEmailSender.send(email);
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                 color: primary,
  //                               ),
  //                               borderRadius: const BorderRadius.all(
  //                                 Radius.circular(circularBorderRadius5),
  //                               ),
  //                             ),
  //                             height: 40,
  //                             width: MediaQuery.of(context).size.width * 0.5,
  //                             child: const Center(
  //                               child: Text(
  //                                 "Send Mail",
  //                                 style: TextStyle(
  //                                   color: primary,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> searchOperation(String searchText) async {
    searchList.clear();
    for (int i = 0; i < delBoyList.length; i++) {
      PersonModel map = delBoyList[i];
      if (map.name!.toLowerCase().contains(searchText)) {
        searchList.add(map);
      }
    }
    if (mounted) delBoyState(() {});
  }

  Future<void> delboyDialog(String status, int index) async {
    int itemindex = index;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            delBoyState = setStater;
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    circularBorderRadius5,
                  ),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                    child: Text(
                      getTranslated(context, "SELECTDELBOY")!,
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: primary),
                    ),
                  ),
                  TextField(
                    controller: _controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                      prefixIcon:
                          const Icon(Icons.search, color: primary, size: 17),
                      hintText: getTranslated(context, "Search")!,
                      hintStyle: TextStyle(color: primary.withOpacity(0.5)),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: white),
                      ),
                    ),
                  ),
                  const Divider(color: lightBlack),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: () {
                          return searchList
                              .asMap()
                              .map(
                                (index, element) => MapEntry(
                                  index,
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      isLoading = true;
                                      if (mounted) {
                                        selectedDelBoy = index;
                                        updateOrder(status, updateOrderItemApi,
                                            model!.id, true, itemindex);
                                        setState(
                                          () {},
                                        );
                                      }
                                    },
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          searchList[index].name!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .values
                              .toList();
                        }(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> getLngList() {
    return searchList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                if (mounted) {
                  setState(
                    () {
                      selectedDelBoy = index;
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    searchList[index].name!,
                  ),
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  otpDialog(String? curSelected, String? otp, String? id, bool item,
      int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    circularBorderRadius5,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                      child: Text(
                        getTranslated(context, "OTP_LBL")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: primary),
                      ),
                    ),
                    const Divider(color: lightBlack),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, "FIELD_REQUIRED")!;
                                } else if (value.trim() != otp) {
                                  return getTranslated(context, "OTPERROR")!;
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: getTranslated(context, "OTP_ENTER")!,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: otpC,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    getTranslated(context, "CANCEL")!,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: lightBlack, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    getTranslated(context, "SEND_LBL")!,
                    style: Theme.of(this.context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: primary, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final form = _formkey.currentState!;
                    if (form.validate()) {
                      form.save();
                      setState(
                        () {
                          Routes.pop(context);
                        },
                      );
                      updateOrder(
                          curSelected, updateOrderItemApi, id, item, index);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  productItem(
    OrderItem orderItem,
    Order_Model model,
    int i,
  ) {
    List att = [], val = [];
    if (orderItem.attr_name!.isNotEmpty) {
      att = orderItem.attr_name!.split(',');
      val = orderItem.varient_values!.split(',');
    }
    final index1 = searchList
        .indexWhere((element) => element.id == orderItem.deliveryBoyId);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(circularBorderRadius5)),
          color: white,
          boxShadow: [
            BoxShadow(
              color: blarColor,
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: DesignConfiguration.getCacheNotworkImage(
                      boxFit: BoxFit.cover,
                      context: context,
                      heightvalue: 94,
                      widthvalue: 64,
                      imageurlString: orderItem.image!,
                      placeHolderSize: 150,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              orderItem.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PlusJakartaSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: textFontSize13,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          orderItem.attr_name!.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: att.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              att[index].trim() + ":",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: grey3,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        "PlusJakartaSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: textFontSize13,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              val[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: black,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        "PlusJakartaSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: textFontSize13,
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  "${getTranslated(context, "QUANTITY_LBL")!}:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: lightBlack2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    orderItem.qty!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: lightBlack),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            DesignConfiguration.getPriceFormat(
                              context,
                              double.parse(orderItem.price!),
                            )!,
                            style: const TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w700,
                              fontFamily: "PlusJakartaSans",
                              fontStyle: FontStyle.normal,
                              fontSize: textFontSize13,
                            ),
                          ),
                          orderItem.productType == 'digital_product'
                              ? orderItem.downloadAllowed == "0"
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => SendMail(
                                                email: tempList[0].email ?? '',
                                                productName:
                                                    orderItem.name ?? '',
                                                orderId: model.id ?? '',
                                                orderIteamId:
                                                    orderItem.id ?? '',
                                                userName: model.username ?? '',
                                              ),
                                            ),
                                          );
                                          // emailSendButtomSheet(context,
                                          //     setState, orderItem.name);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: primary,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                  circularBorderRadius5),
                                            ),
                                          ),
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Center(
                                            child: Text(
                                              "Send Mail",
                                              style: TextStyle(
                                                color: primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
//==============================================================================
//============================ Status of Order =================================

                          orderItem.productType == 'digital_product'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: DropdownButtonFormField(
                                            dropdownColor: lightBlack,
                                            isDense: true,
                                            iconEnabledColor: primary,
                                            hint: Text(
                                              getTranslated(
                                                  context, "UpdateStatus")!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              isDense: true,
                                              fillColor: white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: primary),
                                              ),
                                            ),
                                            value: orderItem.status,
                                            onChanged: (dynamic newValue) {
                                              setState(
                                                () {
                                                  orderItem.curSelected =
                                                      newValue;
                                                  updateOrder(
                                                    orderItem.curSelected,
                                                    updateOrderItemApi,
                                                    model.id,
                                                    true,
                                                    i,
                                                  );
                                                },
                                              );
                                            },
                                            items: digitalList.map(
                                              (String st) {
                                                return DropdownMenuItem<String>(
                                                  value: st,
                                                  child: Text(
                                                    () {
                                                      if (StringValidation
                                                              .capitalize(st) ==
                                                          "Received") {
                                                        return getTranslated(
                                                            context,
                                                            "RECEIVED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Delivered") {
                                                        return getTranslated(
                                                            context,
                                                            "DELIVERED_LBL")!;
                                                      }
                                                      return StringValidation
                                                          .capitalize(st);
                                                    }(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                            color: primary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: DropdownButtonFormField(
                                            dropdownColor: lightBlack,
                                            isDense: true,
                                            iconEnabledColor: primary,
                                            hint: Text(
                                              getTranslated(
                                                  context, "UpdateStatus")!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              isDense: true,
                                              fillColor: white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: primary),
                                              ),
                                            ),
                                            value: orderItem.status,
                                            onChanged: (dynamic newValue) {
                                              setState(
                                                () {
                                                  orderItem.curSelected =
                                                      newValue;
                                                  updateOrder(
                                                    orderItem.curSelected,
                                                    updateOrderItemApi,
                                                    model.id,
                                                    true,
                                                    i,
                                                  );
                                                },
                                              );
                                            },
                                            items: statusList.map(
                                              (String st) {
                                                return DropdownMenuItem<String>(
                                                  value: st,
                                                  child: Text(
                                                    () {
                                                      if (StringValidation
                                                              .capitalize(st) ==
                                                          "Received") {
                                                        return getTranslated(
                                                            context,
                                                            "RECEIVED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Processed") {
                                                        return getTranslated(
                                                            context,
                                                            "PROCESSED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Shipped") {
                                                        return getTranslated(
                                                            context,
                                                            "SHIPED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Delivered") {
                                                        return getTranslated(
                                                            context,
                                                            "DELIVERED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Awaiting") {
                                                        return getTranslated(
                                                            context,
                                                            "AWAITING_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Returned") {
                                                        return getTranslated(
                                                            context,
                                                            "RETURNED_LBL")!;
                                                      } else if (StringValidation
                                                              .capitalize(st) ==
                                                          "Cancelled") {
                                                        return getTranslated(
                                                            context,
                                                            "CANCELLED_LBL")!;
                                                      }
                                                      return StringValidation
                                                          .capitalize(st);
                                                    }(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                            color: primary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
//==============================================================================
//============================ Select Delivery Boy =============================
                          orderItem.productType == 'digital_product'
                              ? Container()
                              : delPermission == '1'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: InkWell(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primary,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(
                                                          circularBorderRadius5),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          index1 != -1
                                                              ? orderItem
                                                                  .deliverBy!
                                                              : getTranslated(
                                                                  context,
                                                                  "SELECTDELBOY",
                                                                )!,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                    color:
                                                                        primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: primary,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  delboyDialog(
                                                      orderItem.status!, i);
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                showTrackingDialog(
                                                    orderItem, i);
                                              },
                                              child: const Icon(
                                                Icons.add_location_alt_sharp,
                                                size: 30,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showTrackingDialog(OrderItem model, int index) async {
    String? urlDetails, couriourDetails, trackingDetails;
    if (model.trackingId != "") {
      urlDetails = model.url;
      couriourDetails = model.courierAgency;
      trackingDetails = model.trackingId;
    }
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    circularBorderRadius5,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                        child: Text(
                          getTranslated(context, "Tracking Detail")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: primary),
                        )),
                    const Divider(color: lightBlack),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: validateField,
                              initialValue: couriourDetails,
                              decoration: InputDecoration(
                                hintText:
                                    getTranslated(context, "Courier Agency"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              controller: courierAgencyController,
                              onSaved: (value) {
                                courierAgency = value;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: validateField,
                              initialValue: trackingDetails,
                              decoration: InputDecoration(
                                hintText: getTranslated(context, "Tracking ID"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              onSaved: (value) {
                                trackingId = value;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: validateField,
                              initialValue: urlDetails,
                              decoration: InputDecoration(
                                hintText: "URL",
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              controller: urlController,
                              onSaved: (value) {
                                url = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    getTranslated(context, 'CANCEL')!,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                          color: lightBlack,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    getTranslated(context, "SAVE_LBL")!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    final form = _formkey.currentState!;
                    if (form.validate()) {
                      form.save();
                      setState(
                        () {
                          isLoading = true;
                          Routes.pop(context);
                        },
                      );
                      editTrackingDetails(
                          model, courierAgency, trackingId, url);
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> editTrackingDetails(
    OrderItem model,
    String? courierAgency,
    String? trackingId,
    String? url,
  ) async {
    isNetworkAvail = await isNetworkAvailable();

    if (isNetworkAvail) {
      try {
        var parameter = {
          "order_item_id": model.id,
          courier_agency: courierAgency,
          tracking_id: trackingId,
          Url: url,
        };
        ApiBaseHelper().postAPICall(editOrderTrackingApi, parameter).then(
          (getdata) async {
            bool error = getdata["error"];
            String msg = getdata["message"];
            setSnackbar(
              msg,
              context,
            );
            if (!error) {
              getOrderDetail();
            } else {
              getOrderDetail();
            }
          },
          onError: (error) {
            setSnackbar(
              error.toString(),
              context,
            );
          },
        );
      } on TimeoutException catch (_) {
        setSnackbar(
          getTranslated(
            context,
            "somethingMSg",
          )!,
          context,
        );
      }
    } else {
      setState(
        () {
          isNetworkAvail = false;
        },
      );
    }
  }

  String? validateField(
    String? value,
  ) {
    if (value!.isEmpty) {
      return getTranslated(context, "This Field is required");
    } else {
      return null;
    }
  }

  Future<void> updateOrder(
    String? status,
    Uri api,
    String? id,
    bool item,
    int index,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (true) {
      if (isNetworkAvail) {
        try {
          var parameter = {
            STATUS: status,
          };
          if (item) {
            parameter[ORDERITEMID] = tempList[0].itemList![index].id;
          }
          if (selectedDelBoy != null) {
            parameter[DEL_BOY_ID] = searchList[selectedDelBoy!].id;
          }
          ApiBaseHelper().postAPICall(updateOrderItemApi, parameter).then(
            (getdata) async {
              bool error = getdata["error"];
              String msg = getdata["message"];
              setSnackbar(
                msg,
                context,
              );
              if (!error) {
                if (item) {
                  tempList[0].itemList![index].status = status;
                } else {
                  tempList[0].itemList![0].activeStatus = status;
                }
                if (selectedDelBoy != null) {
                  tempList[0].itemList![0].deliveryBoyId =
                      searchList[selectedDelBoy!].id;
                }
                getOrderDetail();
              } else {
                getOrderDetail();
              }
            },
            onError: (error) {
              setSnackbar(
                error.toString(),
                context,
              );
            },
          );
        } on TimeoutException catch (_) {
          setSnackbar(
            getTranslated(context, "somethingMSg")!,
            context,
          );
        }
      } else {
        setState(
          () {
            isNetworkAvail = false;
          },
        );
      }
    }
  }
}
