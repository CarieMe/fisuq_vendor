import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/Widget/routes.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_items_model.dart';
import 'package:vendor/model/orders_model/order_model.dart';
import 'package:vendor/model/person/person_model.dart';
import 'package:vendor/provider/setting_provider.dart';
import 'package:vendor/screen/home_page/home.dart';
import 'package:vendor/screen/order_details/widget/bank_proff.dart';
import 'package:vendor/screen/order_details/widget/order_basic_details.dart';
import 'package:vendor/screen/order_details/widget/order_delivery.dart';
import 'package:vendor/screen/order_details/widget/order_notes.dart';
import 'package:vendor/screen/order_details/widget/price_detail.dart';
import 'package:vendor/screen/order_details/widget/shipping_details.dart';
import 'package:vendor/widget/api.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/double_bottom_sheet.dart';
import 'package:vendor/widget/main/scaffold_main.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/parameter_string.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/shimmer_effect.dart';
import 'package:vendor/widget/snackbar.dart';
import 'package:vendor/widget/styled/button_icon.dart';
import 'package:vendor/widget/validation.dart';

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
  OrderModel? model;
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

  List<OrderModel> tempList = [];
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
          print(data);
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
                  .map((data) => OrderModel.fromJson(data))
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
    return MainScaffold(
      key: _scaffoldKey,
      title: Local.orderdetails,
      isBottom: false,
      actions: appbar(),
      body: Stack(
        children: [
          isLoading
              ? const ShimmerEffect()
              : SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 50.0,
                      left: 5.0,
                      right: 5.0,
                    ),
                    child: Column(
                      children: [
                        OrderBasicDetail(model: model),
                        const SizedBox(height: 10),
                        OrderDelivery(model: model),
                        const SizedBox(height: 10),
                        OrderNotes(model: model),
                        const SizedBox(height: 10),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model!.itemList!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              OrderItem orderItem = model!.itemList![i];
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
                        model!.itemList![0].productType == 'digital_product'
                            ? Container()
                            : ShippingDetail(tempList: tempList),
                        PriceDetail(tempList: tempList),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
          DesignConfiguration.showLoader(isProgress, context),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return DoubleBottom(
      label1: 'Send SMS',
      label2: 'Whatsapp',
      function1: () async {
        await sendSmsFunction().then((value) {
          if (value == true) {
            debugPrint('success');
          }
        });
      },
      function2: () async {
        await sendWhatsAppFunction().then((value) {
          if (value == true) {
            debugPrint('success');
          }
        });
      },
      icon1: 'sms',
      icon2: 'whatsapp',
    );
  }

  List<Widget> appbar() {
    return <Widget>[
      ButtonIcon(
        data: AppIcons.basic(icon: 'sms', size: 27),
        onPressed: () async {
          await sendSmsFunction().then((value) {
            if (value == true) {
              debugPrint('success');
            }
          });
        },
      ),
      const SizedBox(width: 20),
      ButtonIcon(
        data: AppIcons.basic(icon: 'whatsapp', size: 27),
        onPressed: () async {
          await sendWhatsAppFunction().then((value) {
            if (value == true) {
              debugPrint('success');
            }
          });
        },
      ),
      const SizedBox(width: 20),
    ];
  }

  Future<bool> sendSmsFunction() async {
    bool success = false;
    String text =
        '${Local.hello} ${tempList[0].name},\n${Local.yourorderwithid} : ${tempList[0].id} ${tempList[0].itemList![0].activeStatus}. ${Local.ifyouhavequerrycontact}';
    var androiduri = 'sms:${tempList[0].mobile}?body=$text';
    var iosuri = 'sms:${tempList[0].mobile}&body=$text';
    var androidencoded = Uri.encodeFull(androiduri);
    var iosencoded = Uri.encodeFull(iosuri);

    try {
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunchUrl(Uri.parse(iosencoded.toString()))) {
          await launchUrl(
            Uri.parse(iosencoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        } else {
          launchUrl(
            Uri.parse(iosencoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        }
      } else {
        // android , web
        if (await canLaunchUrl(Uri.parse(androidencoded.toString()))) {
          await launchUrl(
            Uri.parse(androidencoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        } else {
          launchUrl(
            Uri.parse(androidencoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        }
      }
    } catch (e) {
      debugPrint('$e');
      success = false;
    }
    return success;
  }

  Future<bool> sendWhatsAppFunction() async {
    bool success = false;
    String text =
        '${Local.hello} ${tempList[0].name},\n${Local.yourorderwithid} : ${tempList[0].id} ${tempList[0].itemList![0].activeStatus}. ${Local.ifyouhavequerrycontact}';
    var whatsapp = ("${tempList[0].countryCode!}${tempList[0].mobile!}");
    var whatsappURlAndroid = "https://wa.me/$whatsapp?text=$text";
    var whatappURLIos = "https://wa.me/$whatsapp?text=$text";
    var encoded = Uri.encodeFull(whatappURLIos);

    try {
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunchUrl(Uri.parse(encoded.toString()))) {
          await launchUrl(
            Uri.parse(
              encoded.toString(),
            ),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        } else {
          launchUrl(
            Uri.parse(
              encoded.toString(),
            ),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        }
      } else {
        // android , web
        if (await canLaunchUrl(Uri.parse(encoded.toString()))) {
          await launchUrl(
            Uri.parse(encoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        } else {
          launchUrl(
            Uri.parse(encoded.toString()),
            mode: LaunchMode.externalApplication,
          );
          success = true;
        }
      }
    } catch (e) {
      debugPrint('$e');
      success = false;
    }

    return success;
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
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(circularBorderRadius15),
                ),
              ),
              content: NeuContainer.simple(
                context: context,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.99,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Column(
                          children: [
                            BlBol(
                              data: Local.selectdelboy,
                            ),
                            const SizedBox(height: 15),
                            NeuContainer.color(
                              context: context,
                              child: TextFild(
                                controller: _controller,
                                autofocus: false,
                                enabled: true,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: primary,
                                  size: 17,
                                ),
                                hintText: Local.search,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                          color: Theme.of(context).colorScheme.outlineVariant),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                            updateOrder(
                                                status,
                                                updateOrderItemApi,
                                                model!.id,
                                                true,
                                                itemindex);
                                            setState(
                                              () {},
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextBL(
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
                ),
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
                        Local.otplabel,
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
                                  return Local.fieldrequired;
                                } else if (value.trim() != otp) {
                                  return Local.otperror;
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: Local.otpwr,
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
                    Local.cancel,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: lightBlack, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    Local.sendlbl,
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

  bool loading = false;

  productItem(
    OrderItem orderItem,
    OrderModel model,
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
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          NeuContainer.simple(
            context: context,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                          widthvalue: MediaQuery.of(context).size.width * 0.3,
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
                              BlBol(data: orderItem.name ?? ''),
                              orderItem.attr_name!.isNotEmpty
                                  ? MediaQuery.removePadding(
                                      context: context,
                                      removeBottom: true,
                                      removeTop: true,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: att.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: BsInv(
                                                    data:
                                                        att[index].trim() + ":",
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child:
                                                      BlBol(data: val[index]),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(),
                              Row(
                                children: [
                                  BsInv(data: "${Local.quantitylable}:"),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: BlBol(data: orderItem.qty!),
                                  ),
                                  BsInv(data: "${Local.amount}:"),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: BlBol(
                                      data: DesignConfiguration.getPriceFormat(
                                        context,
                                        double.parse(orderItem.price!),
                                      )!,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildUpdateStatus(orderItem, model, i),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: delPermission == '1'
                            ? buildSelectDeliveryBoy(index1, orderItem, i)
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          loading ? const CupertinoActivityIndicator() : const SizedBox.shrink()
        ],
      ),
    );
  }

  Padding buildSelectDeliveryBoy(
    int index1,
    OrderItem orderItem,
    int i,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(circularBorderRadius5),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextBL(
                    index1 != -1 ? orderItem.deliverBy! : Local.selectdelboy),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.rate1,
              )
            ],
          ),
        ),
        onTap: () {
          delboyDialog(orderItem.status!, i);
        },
      ),
    );
  }

  Padding buildUpdateStatus(
    OrderItem orderItem,
    OrderModel model,
    int i,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: DropdownButtonFormField(
        dropdownColor: Theme.of(context).colorScheme.background,
        isDense: true,
        iconEnabledColor: AppColors.rate1,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        hint: TextBL(
          Local.updatestatus,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.primary.withOpacity(.2),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        value: orderItem.status,
        onChanged: (dynamic newValue) {
          setState(
            () {
              orderItem.curSelected = newValue;
              print(orderItem.curSelected);
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
              child: TextBL(
                () {
                  if (StringValidation.capitalize(st) == "Received") {
                    return Local.receivedlbl;
                  } else if (StringValidation.capitalize(st) == "Pending") {
                    return Local.pending;
                  } else if (StringValidation.capitalize(st) == "Processed") {
                    return Local.processedlbl;
                  } else if (StringValidation.capitalize(st) == "Shipped") {
                    return Local.shipedlbl;
                  } else if (StringValidation.capitalize(st) == "Delivered") {
                    return Local.deliveredlabel;
                  } else if (StringValidation.capitalize(st) == "Awaiting") {
                    return Local.awaiting;
                  } else if (StringValidation.capitalize(st) == "Returned") {
                    return Local.returnedlbl;
                  } else if (StringValidation.capitalize(st) == "Cancelled") {
                    return Local.cancelledlabel;
                  }
                  return StringValidation.capitalize(st);
                }(),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Future<void> updateOrder(
    String? status,
    Uri api,
    String? id,
    bool item,
    int index,
  ) async {
    try {
      setState(() {
        loading = true;
      });
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
          setState(() {
            loading = false;
          });
          Allert.allert();
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
            Allert.allert();
            getOrderDetail();
            setState(() {
              loading = false;
            });
            Snacks.success('Update Success', context);
          } else {
            Allert.allert();
            Snacks.error('Cannot be updated', context);
            getOrderDetail();
            setState(() {
              loading = false;
            });
          }
        },
        onError: (error) {
          Allert.allert();
          Snack.message(error.toString(), context);
          setState(() {
            loading = false;
          });
        },
      );
    } on TimeoutException catch (_) {
      if (mounted) {
        Allert.allert();
        Snack.message("somethingMSg", context);
        setState(() {
          loading = false;
        });
      }
    }
  }
}
