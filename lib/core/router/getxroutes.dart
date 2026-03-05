import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:prosnap/core/router/routes.dart';
import 'package:prosnap/features/auth/views/login_screen.dart';
import 'package:prosnap/features/auth/views/registration_screen.dart';
import 'package:prosnap/features/auth/views/sign_up_screen.dart';
import 'package:prosnap/features/auth/views/splash_screen.dart';
import 'package:prosnap/features/navbar/bindings/home_bindings.dart';
import 'package:prosnap/features/navbar/views/Nav_Screen.dart';

class GetRoutes {
  static final List<GetPage> routes = [
    GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.signUp, page: () => SignupScreen()),
    GetPage(
      name: Routes.homeScreen,
      page: () => MainNavScreen(),
      binding: HomeBindings(),
    ),
    GetPage(name: Routes.profileSetupScreen, page: () => ProfileSetupScreen()),
    GetPage(name: Routes.profileSetupScreen, page: () => ProfileSetupScreen()),
  ];
}
