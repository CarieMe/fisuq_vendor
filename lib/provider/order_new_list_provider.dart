import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';

class OrderListNewProvider extends ChangeNotifier {
  final _controller = StreamController<List<OrderModel>>();
  final _shippedController = StreamController<List<OrderModel>>();
  Stream<List<OrderModel>> get newOrdersStream => _controller.stream;
  Stream<List<OrderModel>> get shippedStream => _shippedController.stream;

  int scrollOffset = 0;
  List<OrderModel> tempList = [];
  List<OrderModel> newOrderList = [];
  List<OrderModel> shippedOrderList = [];
  late Timer _timer;

  Future<void> getNewOrder() async {
    // context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);
    // CUR_USERNAME = await getPrefrence(Username);
    var parameter = {
      SellerId: PrivateString.sellerId,
      LIMIT: perPage.toString(),
      OFFSET: scrollOffset.toString(),
      SEARCH: "".trim(),
    };
    // parameter[ActiveStatus] = 'received';
    // parameter[ActiveStatus] = 'shipped';
    var result = await OrderListRepository.getOrders(parameter: parameter);
    bool error = result["error"];
    List<OrderModel> list = [];
    List<OrderModel> shipped = [];

    if (!error) {
      tempList.clear();
      var data = result["data"];
      if (data.length != 0) {
        list = (data as List)
            .map((data) => OrderModel.fromJson(data))
            .where((order) => order.itemList![0].activeStatus == 'received')
            .toList();
        shipped = (data)
            .map((data) => OrderModel.fromJson(data))
            .where((order) => order.itemList![0].activeStatus == 'shipped')
            .toList();
        newOrderList.clear();
        shippedOrderList.clear();
        newOrderList.addAll(list);
        shippedOrderList.addAll(shipped);
        if (!_controller.isClosed) {
          _controller.sink.add(newOrderList);
        }
        if (!_shippedController.isClosed) {
          _shippedController.sink.add(shippedOrderList);
        }
      }
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getNewOrder();
    });
  }

  @override
  void dispose() {
    _controller.close();
    _shippedController.close();
    _timer.cancel();
    super.dispose();
  }
}
