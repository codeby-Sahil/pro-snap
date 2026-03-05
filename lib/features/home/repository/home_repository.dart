import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:prosnap/core/network/api_client.dart';

class HomeRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  getFeed({page = 1}) async {
    try {
      final Response response = await apiClient.dio.get("/feed/?page=$page");
      return response.data;
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }
}
