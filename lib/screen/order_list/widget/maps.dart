import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';

final statusColors = {
  DELIVERD: AppColors.green,
  SHIPED: AppColors.orange,
  CANCLED: AppColors.red,
  RETURNED: AppColors.red,
  PROCESSED: AppColors.purple,
  PLACED: AppColors.teal,
  "awaiting": AppColors.gray,
};

final statusMap = {
  'Received': Local.receivedlbl,
  'Processed': Local.processedlbl,
  'Shipped': Local.shipedlbl,
  'Delivered': Local.deliveredlabel,
  'Awaiting': Local.awaiting,
  'Cancelled': Local.cancel,
  'Returned': Local.returnedlbl,
};
