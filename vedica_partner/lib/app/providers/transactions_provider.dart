import 'package:flutter/cupertino.dart';
import 'package:vedica_partner/app/data/all_transaction_model.dart';
import 'package:vedica_partner/app/data/all_withdrawl_transactions_model.dart';

import 'package:vedica_partner/app/services/local/local_resource_manager.dart';

import 'package:vedica_partner/app/services/remote/transaction/transaction_services.dart';

enum LoadMoreStatus { LOADING, STABLE }

class TrasactionsProvider with ChangeNotifier {
  TransactionsService? _apiService;

  AllWithdrawlTransactionModel withdrawltrans = AllWithdrawlTransactionModel();

  late AllTransactionModel _allTransactionsModel;
  late AllWithdrawlTransactionModel _allwithdrawlTransactionsModel;

  int totalPages = 0;
  int pageSize = 25;

  bool isLoading = false;
  bool iswLoading = false;

  AllTransactionModel? get getAllTransactions => _allTransactionsModel;
  double get totalRecords => _allTransactionsModel.items!.totalDocs!.toDouble();

  AllWithdrawlTransactionModel? get allwithdrawlTransactionsModel =>
      _allwithdrawlTransactionsModel;
  double get totalRecords2 =>
      _allwithdrawlTransactionsModel.items!.totalDocs!.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  TrasactionsProvider() {
    _initStreams();
  }

  void _initStreams() {
    _apiService = TransactionsService();
    _allTransactionsModel = AllTransactionModel();
    _allwithdrawlTransactionsModel = AllWithdrawlTransactionModel();
  }

  void resetStreams() {
    _initStreams();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  fetchTransactions(pageNumber) async {
    var token = LocalResourceManager().getToken();
    if ((totalPages == 0) || pageNumber <= totalPages) {
      var data = await _apiService!.getAllTransaction(token!, pageNumber);
      var itemModel = AllTransactionModel.fromJson(data);

      print(
          "==================================alll Transactions********** ${itemModel.items == null}");
      if (itemModel.subCode == 200) {
        if (_allTransactionsModel.items == null) {
          totalPages = (itemModel.items!.totalPages!);
          print("total pages $totalPages");
          _allTransactionsModel = itemModel;
        } else {
          print("else");
          // _allTransactionsModel.items!.docs!.addAll(itemModel.items!.docs!);
          _allTransactionsModel = _allTransactionsModel;

          // One load more is done will make it status as stable.
          setLoadingState(LoadMoreStatus.STABLE);
        }
      } else {
        _allTransactionsModel = AllTransactionModel.fromJson(data);
        setLoadingState(LoadMoreStatus.STABLE);
      }
      notifyListeners();
    }

    if (pageNumber > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);

      notifyListeners();
    }
  }

  fetchwithdrawleTransactions(pageNumber) async {
    var token = LocalResourceManager().getToken();
    if ((totalPages == 0) || pageNumber <= totalPages) {
      var data = await _apiService!.getwithdrawlTransaction(token!, pageNumber);
      var itemModel = AllWithdrawlTransactionModel.fromJson(data);

      print(
          "==================================alll Transactions********** ${itemModel.items == null}");
      if (itemModel.subCode == 200) {
        if (_allwithdrawlTransactionsModel.items == null) {
          totalPages = (itemModel.items!.totalPages!);
          print("total pages $totalPages");
          _allwithdrawlTransactionsModel = itemModel;
          setLoadingState(LoadMoreStatus.STABLE);
        } else {
          print("else");
          // _allwithdrawlTransactionsModel.items!.docs!
          //     .addAll(itemModel.items!.docs!);
          _allwithdrawlTransactionsModel = _allwithdrawlTransactionsModel;

          // One load more is done will make it status as stable.
          setLoadingState(LoadMoreStatus.STABLE);
        }
      } else {
        _allwithdrawlTransactionsModel =
            AllWithdrawlTransactionModel.fromJson(data);
        setLoadingState(LoadMoreStatus.STABLE);
      }

      notifyListeners();
    }

    if (pageNumber > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);

      notifyListeners();
    }
  }

  getwithdrawlTransaction() async {
    iswLoading = true;
    notifyListeners();
    var token = LocalResourceManager().getToken();
    var data = await _apiService!.getwithdrawlTransaction(token!, 1);
    if (data['subCode'] == 200) {
      withdrawltrans = AllWithdrawlTransactionModel.fromJson(data);
    } else {}
    iswLoading = false;

    notifyListeners();
  }
}
