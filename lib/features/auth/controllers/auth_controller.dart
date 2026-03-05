import 'package:get/get.dart';
import 'package:prosnap/core/network/api_exception.dart';
import 'package:prosnap/core/router/routes.dart';
import 'package:prosnap/core/services/current_user.dart';
import 'package:prosnap/core/services/tokens.dart';
import 'package:prosnap/features/auth/repository/auth_repository.dart';
import 'package:prosnap/features/auth/views/login_screen.dart';
import 'package:prosnap/features/auth/views/registration_screen.dart';
import 'package:prosnap/features/profile/views/profile_screen.dart';

class AuthController extends GetxController {
  final AuthRepository repository = AuthRepository();
  RxBool signUpisLoading = false.obs;

  // 🔹 When app opens
  handleAppOpen() async {
    try {
      final refreshToken = await Tokens.refreshToken;

      if (refreshToken == null) {
        Get.offAll(() => LoginScreen());
      } else {
        refreshToken != null;
        await repository.refreshToken();
        await repository.getCurrentUsers();

        if (CurrentUser().registration) {
          Get.offAllNamed(Routes.homeScreen);
        } else {
          Get.offAll(() => ProfileSetupScreen());
        }
      }
    } catch (e) {
      CurrentUser().delete();
      Tokens.clear();
      Get.offAll(() => LoginScreen());
      print("HANDLE APP OPEN ERROR: $e");
    }
  }

  // 🔹 Signup
  Future<bool> signUp({required String email, required String password}) async {
    signUpisLoading.value = true;

    try {
      await repository.signUp(email: email, password: password);

      Get.offAll(() => ProfileSetupScreen());
      return true;
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar("Error", e.message);
      }
      return false;
    } finally {
      signUpisLoading.value = false;
    }
  }

  signIn({required String email, required String password}) async {
    signUpisLoading.value = true;
    try {
      await repository.signIn(email: email, password: password);
      if (CurrentUser().registration) {
        Get.offAllNamed(Routes.homeScreen);
      } else {
        Get.offAll(() => ProfileScreen());
      }
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar("Error", e.message);
      }
      return false;
    } finally {
      signUpisLoading.value = false;
    }
  }

  // 🔹 Save Profile Details
  Future<bool> saveUserDetailed({
    required String name,
    required String username,
    required String gender,
    required String dob,
    required String bio,
  }) async {
    signUpisLoading.value = true;

    try {
      await repository.saveUserDetailed(
        name: name,
        username: username,
        gender: gender,
        dob: dob,
        bio: bio,
      );

      return true;
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar("Error", e.message);
      }
      return false;
    } finally {
      signUpisLoading.value = false;
    }
  }

  signOut() async {
    signUpisLoading.value = true;
    try {
      await repository.signOut();
      Get.off(() => LoginScreen());
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar("Error..!!", e.message);
      }
      if (e is NoInternetException) {
        Get.snackbar("Error..!!", e.message);
      }
    } finally {
      signUpisLoading.value = false;
    }
  }
}
