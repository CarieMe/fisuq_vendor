import 'dart:async';
import 'package:fisuq_vendor/Widget/main/scaffold_main.dart';
import 'package:fisuq_vendor/Widget/styled/button_small.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fisuq_vendor/Helper/Color.dart';
import 'package:fisuq_vendor/Screen/SalesReport/widget/ListIteam.dart';
import 'package:fisuq_vendor/Screen/SalesReport/widget/genetalDataShower.dart';
import '../../Provider/salesReportProvider.dart';
import '../../Provider/settingProvider.dart';
import '../../Widget/appBar.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/simmerEffect.dart';
import '../../Widget/validation.dart';
import '../../Widget/noNetwork.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

SalesReportProvider? salesProvider;

class _SalesReportState extends State<SalesReport>
    with TickerProviderStateMixin {
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    salesProvider = Provider.of<SalesReportProvider>(context, listen: false);
    salesProvider!.initializaedVariableWithDefualtValue();
    salesProvider!.getSalesReportRequest(context, setStateNow, false);
    salesProvider!.controller.addListener(_scrollListener);
    salesProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    salesProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: salesProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    salesProvider!.amtC = TextEditingController();
    salesProvider!.bankDetailC = TextEditingController();
  }

  _scrollListener() {
    if (salesProvider!.controller.offset >=
            salesProvider!.controller.position.maxScrollExtent &&
        !salesProvider!.controller.position.outOfRange) {
      if (mounted) {
        setState(
          () {
            salesProvider!.isLoadingmore = true;

            if (salesProvider!.offset < salesProvider!.total)
              salesProvider!.getSalesReportRequest(context, setStateNow, false);
          },
        );
      }
    }
  }

  Future<void> _refresh() async {
    Completer<void> completer = Completer<void>();
    await Future.delayed(const Duration(seconds: 3)).then(
      (onvalue) {
        completer.complete();
        salesProvider!.offset = 0;
        salesProvider!.total = 0;
        salesProvider!.tranList.clear();
        setState(
          () {
            salesProvider!.isLoading = true;
          },
        );
        salesProvider!.tranList.clear();
        salesProvider!.getSalesReportRequest(context, setStateNow, false);
      },
    );
    return completer.future;
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: salesProvider!.startDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(
        () {
          salesProvider!.startDate = picked;
          salesProvider!.start =
              DateFormat('dd-MM-yyyy').format(salesProvider!.startDate);

          if (salesProvider!.start != null && salesProvider!.end != null) {
            // salesProvider!.scrollLoadmore = true;
            // salesProvider!.scrollOffset = 0;
            // salesProvider!.getOrder(setStateNow, context);
          }
        },
      );
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: salesProvider!.startDate,
        firstDate: salesProvider!.startDate,
        lastDate: DateTime.now());
    if (picked != null) {
      setState(
        () {
          salesProvider!.endDate = picked;
          salesProvider!.end =
              DateFormat('dd-MM-yyyy').format(salesProvider!.endDate);
          if (salesProvider!.start != null && salesProvider!.end != null) {
            salesProvider!.initializaedVariableWithDefualtValue();
            salesProvider!.getSalesReportRequest(context, setStateNow, true);

            // salesProvider!.scrollLoadmore = true;
            // salesProvider!.scrollOffset = 0;
            // salesProvider!.getOrder(setStateNow, context);
          }
        },
      );
    }
  }

  _filterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: ButtonSmall(
                data: getTranslated(context, "Start Date")!,
                onPressed: () {
                  _startDate(context);
                }),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: ButtonSmall(
                data: getTranslated(context, "End Date")!,
                onPressed: () {
                  _endDate(context);
                }),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: ButtonSmall(
                data: 'Refresh',
                onPressed: () {
                  setState(
                    () {
                      salesProvider!.start = null;
                      salesProvider!.end = null;
                      salesProvider!.startDate = DateTime.now();
                      salesProvider!.endDate = DateTime.now();
                      salesProvider!.initializaedVariableWithDefualtValue();
                      salesProvider!
                          .getSalesReportRequest(context, setStateNow, false);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MainScaffold(
      title: getTranslated(context, 'Sales Report')!,
      isBottom: false,
      body: isNetworkAvail
          ? salesProvider!.isLoading
              ? const ShimmerEffect()
              : RefreshIndicator(
                  key: salesProvider!.refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    controller: salesProvider!.controller,
                    child: Column(
                      children: [
                        const GetGeneralDataShower(),
                        const SizedBox(height: 10),
                        _filterRow(),
                        const SizedBox(height: 10),
                        salesProvider!.tranList.isEmpty
                            ? Center(
                                child: Text(
                                  getTranslated(context, "noItem")!,
                                ),
                              )
                            : MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: (salesProvider!.offset <
                                          salesProvider!.total)
                                      ? salesProvider!.tranList.length + 1
                                      : salesProvider!.tranList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return (index ==
                                                salesProvider!
                                                    .tranList.length &&
                                            salesProvider!.isLoadingmore)
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListIteam(
                                            index: index,
                                          );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                )
          : noInternet(
              context,
              setStateNoInternate,
              salesProvider!.buttonSqueezeanimation,
              salesProvider!.buttonController,
            ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await salesProvider!.buttonController!.forward();
    } on TickerCanceled {}
  }

  setStateNoInternate() async {
    _playAnimation();

    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          await salesProvider!
              .getSalesReportRequest(context, setStateNow, false);
        } else {
          await salesProvider!.buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }
}
