import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class APIClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  Map<String, String> get mainHeaders => _mainHeaders;
  APIClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = "";
    _mainHeaders = {
      "content-type": "application/json; charset-UTF_8",
      "Authorization": "Bearer $token"
    };
  }
  void updateHeader(String token) {
    _mainHeaders = {
      "content-type": "application/json; charset-UTF_8",
      "Authorization": "Bearer $token"
    };
  }

  Future<Response> getData(String uri, Map<String, String> mainHeaders) async {
    try {
      print(uri);
      Response response = await get(uri, headers: mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      print(uri);
      Response response = await put(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, dynamic body) async {
    try {
      Response response = await delete(
        uri,
        headers: _mainHeaders,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
