import 'package:dio/dio.dart';
import 'package:rogo/core/configs/constants/api.dart';
import 'package:rogo/core/error/exceptions.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    BaseOptions baseOptions =
        BaseOptions(receiveTimeout: 3500, connectTimeout: 3500, baseUrl: k_API_END_POINT_BASE, maxRedirects: 2);
    _dio = Dio(baseOptions);
    // adding logging interceptor.
    _dio.interceptors.add(LogInterceptor(
        requestBody: true, error: true, request: true, requestHeader: true, responseBody: true, responseHeader: true));
  }

  // for HTTP.GET Request.
  Future<Response> get(String url, {Map<String, String>? params, Options? options}) async {
    Response response;
    try {
      response = await _dio.get(
        url,
        queryParameters: params,
        options: options?.copyWith(responseType: ResponseType.json) ?? Options(responseType: ResponseType.json),
      );
    } on DioError catch (exception) {
      if (exception.response?.data != null && exception.response?.data['message'] != null) {
        throw ServerException(message: exception.response?.data['message']);
      } else {
        throw ServerException(message: exception.error);
      }
    }
    return response;
  }

  // for HTTP.POST Request.
  Future<Response> post(String url, {dynamic data, Map<String, String>? params, Options? options}) async {
    Response response;
    try {
      response = await _dio.post(
        url,
        data: data,
        queryParameters: params,
        options: options?.copyWith(responseType: ResponseType.json) ?? Options(responseType: ResponseType.json),
      );
    } on DioError catch (exception) {
      if (exception.response?.data != null && exception.response?.data['message'] != null) {
        throw ServerException(message: exception.response?.data['message']);
      } else {
        throw ServerException(message: exception.error);
      }
    }
    return response;
  }

  // for HTTP.PATCH Request.
  Future<Response> patch(String url, {Map<String, String>? params, Options? options}) async {
    Response response;

    try {
      response = await _dio.patch(
        url,
        data: params,
        options: options?.copyWith(responseType: ResponseType.json) ?? Options(responseType: ResponseType.json),
      );
    } on DioError catch (exception) {
      if (exception.response?.data != null && exception.response?.data['message'] != null) {
        throw ServerException(message: exception.response?.data['message']);
      } else {
        throw ServerException(message: exception.error);
      }
    }
    return response;
  }
}
