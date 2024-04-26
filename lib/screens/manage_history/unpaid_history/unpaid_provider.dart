import 'package:flutter/cupertino.dart';

class UnpaidProvider with ChangeNotifier {
  String _totalUnpaidAmount = '0.00';

  String get totalUnpaidAmount => _totalUnpaidAmount;

  void setTotalUnpaidAmount(String amount) {
    _totalUnpaidAmount = amount;
    notifyListeners();
  }
}
