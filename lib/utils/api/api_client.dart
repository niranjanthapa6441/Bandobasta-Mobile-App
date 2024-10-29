import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class APIClient extends GetConnect implements GetxService {
  String? token;
  final String appBaseUrl;
  final AuthService _authService = AuthService();
  Map<String, String> _mainHeaders = {
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> get mainHeaders => _mainHeaders;

  APIClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    initializeTokenAndHeaders();
  }

  Future<void> initializeTokenAndHeaders() async {
    token = await _authService.getToken();
    _updateHeaders();
  }

  void _updateHeaders() {
    if (token != null) {
      _mainHeaders["Authorization"] = "Bearer $token";
    } else {
      _mainHeaders.remove(
          "Authorization");
    }
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri, headers: _mainHeaders);
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
      Response response = await put(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri) async {
    try {
      Response response = await delete(uri, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
