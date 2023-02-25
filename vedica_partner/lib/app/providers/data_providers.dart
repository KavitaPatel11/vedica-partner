import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/data/all_current_balance_model.dart';
import 'package:vedica_partner/app/data/default_model.dart';
import 'package:vedica_partner/app/data/invester_detail_model.dart';
import 'package:vedica_partner/app/data/kyc_detail.dart';
import 'package:vedica_partner/app/data/nomine_detail_model.dart';
import 'package:vedica_partner/app/data/portfolio_model.dart';
import 'package:vedica_partner/app/modules/ekyc/controllers/ekyc_controller.dart';
import 'package:vedica_partner/app/modules/home/views/home_view.dart';
import 'package:vedica_partner/app/modules/nominee/controllers/nominee_controller.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/app/services/remote/bank/bank_services.dart';
import 'package:vedica_partner/app/services/remote/portfolio/portfolio_services.dart';
import 'package:vedica_partner/main.dart';
import 'package:vedica_partner/utils/error_helper.dart';

enum LoadMoreStatus { LOADING, STABLE }

class DataProvider with ChangeNotifier {
  PortFolioService? _apiService;

  final BankService _bankService = BankService();
  final PortFolioService _portFolioService = PortFolioService();
  AllBalanceModel allBalanceModel = AllBalanceModel();
  final NomineeController controller = Get.put(NomineeController());
  final EkycController ekyccontroller = Get.put(EkycController());
  bool balanceLoading = false;
  InvesterDetailModel investerDetailModel = InvesterDetailModel();
  NomineeDetailModel nomineeDetailModel = NomineeDetailModel();
  AllKycModel allKycModel = AllKycModel();
  bool investLoading = false;
  bool kycLoading = false;
  bool loading = false;
  bool isLockingloading = false;
  bool isBack = false;
  bool isNominee = false;
  bool isKyc = false;

  late AllPortfolioModel _allPortfolioModel;

  int totalPages = 0;
  int pageSize = 25;
  var argu = Get.arguments;
  bool isLoading = false;

  AllPortfolioModel? get getAllPortfolio => _allPortfolioModel;
  double get totalRecords => _allPortfolioModel.items!.totalDocs!.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  DataProvider() {
    _initStreams();
  }

  void _initStreams() {
    _apiService = PortFolioService();
    _allPortfolioModel = AllPortfolioModel();
  }

  void resetStreams() {
    _initStreams();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  fetchPortfolio(pageNumber) async {
    isLoading = true;
    // notifyListeners();
    var token = LocalResourceManager().getToken();
    if ((totalPages == 0) || pageNumber <= totalPages) {
      var data = await _apiService!
          .getPortPolio(token == null ? "" : token, pageNumber);
      var itemModel = AllPortfolioModel.fromJson(data);

      print(
          "==================================alll portfolio********** ${itemModel.items == null}");
      if (itemModel.subCode == 200) {
        if (_allPortfolioModel.items == null) {
          totalPages = (itemModel.items!.totalPages!);
          print("total pages $totalPages");
          _allPortfolioModel = itemModel;
        } else {
          print("else");
          _allPortfolioModel.items!.docs!.addAll(itemModel.items!.docs!);
          _allPortfolioModel = _allPortfolioModel;

          // One load more is done will make it status as stable.
          setLoadingState(LoadMoreStatus.STABLE);
          isLoading = false;
        }
      } else {
        _allPortfolioModel = AllPortfolioModel.fromJson(data);
        setLoadingState(LoadMoreStatus.STABLE);
        isLoading = false;
      }
      isLoading = false;
      notifyListeners();
    }

    if (pageNumber > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      // isLoading=false;
      notifyListeners();
    }
  }

  getBalanceData() async {
    balanceLoading = true;
    // notifyListeners();

    var token = LocalResourceManager().getToken();
    var data = await _apiService!.getBalance(token == null ? "" : token);

    print("data=======$data");
    if (data['subCode'] == 200) {
      allBalanceModel = AllBalanceModel.fromJson(data);
    } else {
      allBalanceModel == null;
    }
    balanceLoading = false;

    notifyListeners();
  }

  @override
  getProfile() async {
    investLoading = true;
    var token = LocalResourceManager().getToken();
    investerDetailModel = InvesterDetailModel.fromJson(
        await await _apiService!.getProfile(token == null ? "" : token));
    investLoading = false;

    notifyListeners();
  }

  // create withdrawle request
  Future<void> createwithdrawlerequest(String reason, amount) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> data = {"reason": "$reason", "amount": amount};

    print("data33 $data");
    var data2 = await _bankService.addWithdrawleRequest(data);

    print("data2 $data2");

    if (data2 != null) {
      final response = DefaultModel.fromJson(data2);
      print("rsponse $response");
      if (response.subCode == 200) {
        Errorhelper.showToast(response.message.toString());
        isBack = true;
      } else {
        Errorhelper.showErrorDialog(
            title: "Error On Create Withdrawl request",
            discription: response.message!,
            onSubmit: () => Get.back());
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> addnominee(String name, String phone, String email,
      String relation, String aadhar) async {
    loading = true;
    notifyListeners();
    var data = {
      "name": name,
      "phone": phone,
      "email": email,
      "nomineeRelation": relation,
      "nomineeAadhaarNo": aadhar
    };

    print("data2 $data");
    var data2 = await _bankService.addNominee(data);

    print("data3 $data2");

    if (data2 != null) {
      final response = DefaultModel.fromJson(data2);
      print("rsponse $response");
      if (response.subCode == 200) {
        Errorhelper.showToast(response.message.toString());
        getNominee();
      } else {
        Errorhelper.showErrorDialog(
            title: "Error On Adding Nominee Detail",
            discription: response.message!,
            onSubmit: () => Get.back());
      }
    }
    loading = false;
    notifyListeners();
  }

  @override
  getNominee() async {
    investLoading = true;
    var token = LocalResourceManager().getToken();
    nomineeDetailModel = NomineeDetailModel.fromJson(
        await await _bankService.getNominee(token == null ? "" : token));
    print("investerdetail model $investerDetailModel");
    isNominee = nomineeDetailModel.status!;
    if (nomineeDetailModel.subCode == 200) {
      controller.nameController.text = nomineeDetailModel.items!.name!;
      controller.emailController.text = nomineeDetailModel.items!.email!;
      controller.phoneController.text = nomineeDetailModel.items!.phone!;
      controller.relationController.text =
          nomineeDetailModel.items!.nomineeRelation!;
      controller.aadharController.text =
          nomineeDetailModel.items!.nomineeAadhaarNo!;
    }
    investLoading = false;

    notifyListeners();
  }

  Future<void> addportfolio(String amount, String lockingperiod) async {
    loading = true;
    notifyListeners();
    var data = {"investAmount": amount, "locking": lockingperiod};

    print("data2 $data");
    var data2 = await _portFolioService.addPortFolio(data);

    print("data3 $data2");

    if (data2 != null) {
      final response = DefaultModel.fromJson(data2);
      print("rsponse $response");
      if (response.subCode == 200) {
        Errorhelper.showToast(response.message.toString());

        isBack = true;
      } else {
        Errorhelper.showErrorDialog(
            title: "Error",
            discription: response.message!,
            onSubmit: () => Get.back());
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> updatelocking(String portfolioId, String locking) async {
    isLockingloading = true;
    notifyListeners();
    var data = {"locking": locking};

    print("data2 $data");
    var data2 = await _portFolioService.updatelocking(data, portfolioId);

    print("data3 $data2");

    if (data2 != null) {
      final response = DefaultModel.fromJson(data2);
      print("rsponse $response");
      if (response.subCode == 200) {
        Errorhelper.showToast(response.message.toString());
        isBack = true;
        notifyListeners();
      } else {
        Errorhelper.showErrorDialog(
            title: "Error",
            discription: response.message!,
            onSubmit: () => Get.back());
      }
    }
    isLockingloading = false;
    notifyListeners();
  }

  // uplod image
  Future<String?> uploadImage({File? file}) async {
    final response = await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: file!.path,
        fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: "vedica/",
        fileName: '${file.path.split("/").last}',
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        }));

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
    }

    return (response.secureUrl);
  }

  // Add KYC DEtail

  Future<void> addKYC(
      String name,
      String work,
      String address,
      String gender,
      String aadhaarNumber,
      String panNumber,
      File aadhaarFront,
      File aadhaarBack,
      File panFront,
      String DateOfBirth) async {
    loading = true;
    notifyListeners();

    print("datafile1 $aadhaarFront");
    print("datafile1 $aadhaarBack");
    print("pan $panFront");

    String? image1 = await uploadImage(file: aadhaarFront);
    String? image2 = await uploadImage(file: aadhaarBack);
    String? image3 = await uploadImage(file: panFront);
    if (image1 != null && image1 != null && image3 != null) {
      debugPrint("imag3 kkk${image3.toString()}kkk");
      debugPrint("imag2 kkk${image2.toString()}ppp");
      debugPrint("imag1 kkk${image1.toString()}ooo");

      var data = {
        "name": "$name",
        "work": "$work",
        "address": "$address",
        "aadhaarNumber": "$aadhaarNumber",
        "aadhaarFront": "$image1",
        "aadhaarBack": "$image2",
        "panNumber": "$panNumber",
        "panFront": "$image3",
        "DateOfBirth": "$DateOfBirth",
        "gender": "${gender}llll"
      };

      print("data2 $data");
      var data4 = {
        "name": "$name",
        "work": "$work",
        "address": "$address",
        "aadhaarNumber": "$aadhaarNumber",
        "aadhaarFront": "$image1",
        "aadhaarBack": "$image2",
        "panNumber": "$panNumber",
        "panFront": "$image3",
        "DateOfBirth": "$DateOfBirth",
        "gender": "$gender"
      };

      print("data4 $data4");
      var data2 = await _bankService.addKyc(data4);

      print("data3 $data2");

      if (data2 != null) {
        final response = DefaultModel.fromJson(data2);
        print("rsponse $response");
        if (response.subCode == 200) {
          Errorhelper.showToast(response.message.toString());
          isBack = true;
          getKyc();
        } else {
          Errorhelper.showErrorDialog(
              title: "Error On Adding EKYC Detail",
              discription: response.message!,
              onSubmit: () => Get.back());
        }
      }
      loading = false;
      notifyListeners();
    }
  }

  // get kyc
  @override
  getKyc() async {
    kycLoading = true;
    var token = LocalResourceManager().getToken();
    allKycModel = AllKycModel.fromJson(
        await await _bankService.getKyc(token == null ? "" : token));
    print("investerdetail model $investerDetailModel");
    isKyc = allKycModel.status!;
    if (allKycModel.subCode == 200) {
      ekyccontroller.nameController.text = allKycModel.items!.name!;
      ekyccontroller.aadharNo.text = allKycModel.items!.aadhaarNumber!;
      ekyccontroller.panNo.text = allKycModel.items!.panNumber!;
      ekyccontroller.gender.text = allKycModel.items!.gender!;
      ekyccontroller.workType.text = allKycModel.items!.work!;
      ekyccontroller.address.text = allKycModel.items!.address!;
      ekyccontroller.dobController.text = allKycModel.items!.dateOfBirth!;
    }
    kycLoading = false;

    notifyListeners();
  }
}
