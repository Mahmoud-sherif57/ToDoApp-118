import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ToDoApp/view-model/data/local/shared_keys.dart';
import 'package:ToDoApp/view-model/data/network/end_points.dart';

// here we custom class DioHelper to call the endPoint (get,post,put,delete) easily ..
class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      //we make (buseUrl & headers) static with (_dio) because they are the same in all of them .
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(
          seconds:
              10), //if we had a problem with the request..the request will stop after 10s
      receiveDataWhenStatusError: true,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    ),
  )..interceptors.add(
      PrettyDioLogger(
        // this package to show the response in the terminal in a pretty way..
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

  // customising the methods of endPoints ( get/ post/ put/ patch/ delete)  .

  static const FlutterSecureStorage storage = FlutterSecureStorage();

  // 1st endPoint (get)
  static Future<Response> get({
    // we used Future<> because i don't know the time it will take to get the response..
    required String endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      if (withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token);
        _dio.options.headers.addAll({
          "Authorization": "Bearer $token",
        });
      }
      _dio.options.headers.addAll(headers ?? {});
      // we can use this line if the headers changes with every endPoint ,
      // but we can ignore here because the headers are common in all our endPoints so we wrote it in BaseOption in dio .
      return await _dio.get(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (error) {
      // to catch the error ..
      rethrow; // (rethrow) means to send the error that happens in (try& catch) to the (get) method
      // so we can show the error as DioException in the UI .
      // to throw the error to the endPoint we called . so we can show the error to the user..
    }
  }

  // 2d endPoint (post)
  static Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? params,
    Object? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      if (withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token);
        _dio.options.headers.addAll({
          "Authorization": "Bearer $token",
        });
      }
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.post(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (error) {
      rethrow;
    }
  }

  // 3d endPoint (put)
  static Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      if (withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token);
        _dio.options.headers.addAll({
          "Authorization": "Bearer$token",
        });
      }
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.put(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (error) {
      rethrow;
    }
  }

  // 4th endPoint (patch)
  static Future<Response> patch({
    required String endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      if (withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token);
        _dio.options.headers.addAll({
          "Authorization": "Bearer$token",
        });
      }
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.patch(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (error) {
      rethrow;
    }
  }

  // 5th endPoint (delete)
  static Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool? withToken = false,
  }) async {
    try {
      if (withToken ?? false) {
        String? token = await storage.read(key: SharedKeys.token);
        _dio.options.headers.addAll({
          "Authorization": "Bearer$token",
        });
      }
      _dio.options.headers.addAll(headers ?? {});
      return await _dio.delete(
        endPoint,
        queryParameters: params,
        data: body,
      );
    } catch (error) {
      rethrow;
    }
  }

// get => pokemons..
//
//   static Future<Response> getPokemons({
//     // we used Future<> because i don't know the time it will take to get the response..
//     required String endPoint,
//     Map<String, dynamic>? params,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//     bool? withToken = false,
//   }) async {
//     try {
//       if (withToken ?? false) {
//         String? token = await storage.read(key: SharedKeys.token);
//         _dio.options.headers.addAll({
//           "Authorization": "Bearer $token",
//         });
//       }
//       _dio.options.headers.addAll(headers ?? {});
//       return await _dio.get(
//         endPoint,
//         queryParameters: params,
//         data: body,
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
}
