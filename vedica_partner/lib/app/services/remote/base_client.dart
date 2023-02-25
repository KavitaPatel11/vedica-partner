import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vedica_partner/app/services/exceptions/exception_handling.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/utils/endpoints.dart';

class BaseClient {
  Future<dynamic> get(String endpoint, [Map<String, String>? header]) async {
    try {
      if (header != null) {
        print("withtoken $header");
        print(Endpoint.baseUrl + endpoint);
        var response = await http.get(
          Uri.parse(Endpoint.baseUrl + endpoint),
          headers: {
            "Authorization": "Bearer ${LocalResourceManager().getToken()}"
          },
        ).timeout(Duration(seconds: Endpoint.timeout));

        print("response data $response");
        print(response.statusCode);
        return _getResponse(response);
      } else {
        print("without $header");
        var response = await http
            .get(Uri.parse(Endpoint.baseUrl + endpoint))
            .timeout(Duration(seconds: Endpoint.timeout));
        print(response.statusCode);
        return _getResponse(response);
      }
    } on SocketException {
      return Get.offAllNamed("/no-internet");

      // throw FetchDataException("No Internet Connection", endpoint);
    } on TimeoutException {
      throw ApiNotRespondingException("Take to longer to response", endpoint);
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      [Map<String, String>? header]) async {
    print(
        "*******url************************${Endpoint.baseUrl + endpoint}**************************************");
    try {
      if (header != null) {
        print("withtoken $header");
        print(
            "===================url ${Endpoint.baseUrl + endpoint}==================");
        print("data base cline  $body");
        var response = await http.post(
          Uri.parse(Endpoint.baseUrl + endpoint),
          body: body,
          headers: {
            "Authorization": "Bearer ${LocalResourceManager().getToken()}"
          },
        ).timeout(Duration(seconds: Endpoint.timeout));
        print("response data $response");
        print("response.statusCode ${response.statusCode}");
        print("response.body ${response.body}");

        return _getResponse(response);
      } else {
        var response = await http.post(
          Uri.parse(Endpoint.baseUrl + endpoint),
          body: body,
          headers: {
            // "Content-Type": "application/json"
          },
        ).timeout(Duration(seconds: Endpoint.timeout));
        print("Response StatusCode:");
        print(response);
        print(response.statusCode);

        return _getResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet Connection", endpoint);
    } on TimeoutException {
      throw ApiNotRespondingException("Take to longer to response", endpoint);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        print("response===${json.decode(response.body)}");
        //var responseJson = utf8.decode(response.bodyBytes);
        return json.decode(response.body);
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw PageNotFound("Not Found", response.request!.url.toString());
      case 500:
      case 502:
      default:
        throw FetchDataException("Error occured ${response.statusCode}",
            response.request!.url.toString());
    }
  }
}
