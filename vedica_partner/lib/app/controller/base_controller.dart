import 'package:get/get.dart';
import 'package:vedica_partner/app/services/exceptions/exception_handling.dart';
import 'package:vedica_partner/utils/error_helper.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      Errorhelper.showErrorDialog(
          onSubmit: () => Get.back(),
          title: error.prefix.toString(),
          discription: error.message.toString());
    } else if (error is FetchDataException) {
      Errorhelper.showErrorDialog(
          onSubmit: () => Get.back(),
          title: error.prefix.toString(),
          discription: error.message.toString());
    } else if (error is ApiNotRespondingException) {
      Errorhelper.showErrorDialog(
          onSubmit: () => Get.back(),
          title: error.prefix.toString(),
          discription: error.message.toString());
    } else if (error is UnAuthorizedException) {
      Errorhelper.showErrorDialog(
          onSubmit: () => Get.back(),
          title: error.prefix.toString(),
          discription: error.message.toString());
    } else {
      Errorhelper.showErrorDialog(
          onSubmit: () => Get.back(),
          title: "Error",
          discription: "Somthing went Wrong, Please Try Again");
    }
  }
}
