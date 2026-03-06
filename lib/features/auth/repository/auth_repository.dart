import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:prosnap/core/network/api_client.dart';
import 'package:prosnap/core/services/current_user.dart';
import 'package:prosnap/core/services/tokens.dart';

class AuthRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  signUp({required String email, required String password}) async {
    try {
      final payload = {
        "email": email,
        "password": password,
        "deviceId": "s-1",
        "deviceType": "mobile",
      };

      final Response response = await apiClient.dio.post(
        "/auth/sign-up",
        data: payload,
      );

      final String accessToken = response.data['data']['accessToken'];
      final String refreshToken = response.data['data']['refreshToken'];
      final userDetails = response.data['data']['user'];

      await Future.wait([
        CurrentUser().save(userDetails),
        Tokens.save(accessToken: accessToken, refreshToken: refreshToken),
      ]);
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  signIn({required String email, required String password}) async {
    try {
      final payload = {
        "email": email,
        "password": password,
        "deviceId": "s-1",
        "deviceType": "mobile",
      };

      final Response response = await apiClient.dio.post(
        "/auth/sign-in",
        data: payload,
      );

      final String accessToken = response.data['data']['accessToken'];
      final String refreshToken = response.data['data']['refreshToken'];
      final userDetails = response.data['data']['user'];

      await Future.wait([
        CurrentUser().save(userDetails),
        Tokens.save(accessToken: accessToken, refreshToken: refreshToken),
      ]);
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  refreshToken() async {
    try {
      final payload = {"refreshToken": await Tokens.refreshToken};

      final Response response = await apiClient.dio.post(
        "/auth/refresh-token", // ✅ FIXED ROUTE
        data: payload,
      );

      final accessToken = response.data['data']['accessToken'];
      final refreshToken = response.data['data']['refreshToken'];

      await Tokens.save(accessToken: accessToken, refreshToken: refreshToken);
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  getCurrentUsers() async {
    try {
      final Response response = await apiClient.dio.get("/auth/me");

      final user = response.data['data']['user'];
      await CurrentUser().save(user);
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  saveUserDetailed({
    required String name,
    required String username,
    required String gender,
    required String dob,
    required String bio,
  }) async {
    try {
      final payload = {
        "name": name,
        "userName": username,
        "bio": bio,
        "gender": gender,
        "dob": dob,
        "profilePicture": "",
      };

      final Response response = await apiClient.dio.patch(
        "/registration/profile",
        data: payload,
      );

      final userDetails = response.data['data'];
      CurrentUser().save(userDetails);
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }

  signOut() async {
    try {
      await apiClient.dio.get("/auth/sign-out");

      await Tokens.clear();
      await CurrentUser().delete();
    } on DioException catch (e) {
      throw e.error as Exception;
    }
  }
}
