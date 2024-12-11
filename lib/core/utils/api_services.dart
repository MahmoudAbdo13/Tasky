import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../constant.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      required Map<String, dynamic> data,
      required String userToken}) async {
    var headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    var newData = json.encode(data);
    var dio = Dio();
    var response = await dio.request(
      baseUrl + endPoint,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: newData,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete(
      {required String endPoint,
      required String userToken}) async {

    var headers = {'Accept': '*/*', 'Authorization': 'Bearer $userToken'};
    var response = await http.delete(
      Uri.parse(baseUrl + endPoint),
      headers: headers,
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String? userToken}) async {
    var response = await _dio.post(
      '$baseUrl$endPoint',
      queryParameters: query,
      data: data,
      options: Options(
          method: 'POST', headers: {'Authorization': 'Bearer $userToken'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> postImage(
      {required String endPoint, String? userToken, required File file}) async {
    // Verify if the file is an image
    String mimeType = file.path.split('.').last;
    List<String> validImageTypes = ['jpg', 'jpeg', 'png', 'gif'];

    if (!validImageTypes.contains(mimeType)) {
      return {
        'error': 'Invalid image format. Only jpg, jpeg, png, gif allowed.'
      };
    }
    try {
      var headers = {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://todo.iraqsapp.com/upload/image'));
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          contentType: MediaType('image', mimeType)));
      request.headers.addAll(headers);

      var response = await request.send();
      return json.decode(await response.stream.bytesToString());
    } on DioException catch (_) {
      return {};
    }
  }

  Future<Response> get(
      {required String endPoint, required String userToken, int? page}) async {
    var response = await _dio.get(
      page != null ? "$baseUrl$endPoint?page=$page" : baseUrl + endPoint,
      options: Options(
        method: 'GET',
        headers: {'Authorization': 'Bearer $userToken'},
      ),
    );
    return response;
  }
}
