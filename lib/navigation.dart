// import 'package:finpay/bindings/init_binding.dart';
// import 'package:finpay/services/auth_guard.dart';
// import 'package:finpay/view/login/login_screen.dart';
// import 'package:finpay/view/profile/profile_view.dart';
// import 'package:finpay/view/signup/signup_screen.dart';
// import 'package:finpay/view/splash/splash.dart';
// import 'package:finpay/view/splash/welcome_screen.dart';
// import 'package:finpay/view/tab_screen.dart';
import 'package:gando/views/authentication/PreLogin/PreLogin.dart';
import 'package:gando/views/authentication/resetPassword/change_password.dart';
import 'package:gando/views/authentication/resetPassword/reset_password.dart';
import 'package:gando/views/authentication/resetPassword/forgot_password.dart';
import 'package:gando/views/authentication/signin/signin_screen.dart';
import 'package:gando/views/authentication/signup/signup_screen.dart';
import 'package:gando/views/bottom_navigation_bar.dart';
import 'package:gando/views/splashscreen/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static get INITIAL => Routes.splashScreen;

  static final appPages = [
    GetPage(
      name: Routes.preLogin,
      page: () => const PreLogin(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.forgotPwd,
      page: () => const ForgotPasswordScreen(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.resetPwd,
      page: () => ResetRecoveryOtpScreen(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.newPwd,
      page: () => const ChangePasswordScreen(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      // binding: SplashScreenBinding(),
    ),
    // GetPage(
    //   name: Routes.welcome,
    //   page: () => const WelcomeFirstScreen(),
    //   // middlewares: [
    //   //   IsFirstGuard(),
    //   //   // My middlewares here
    //   //   AuthGuard(),
    //   // ],
    // ),
    GetPage(
      name: Routes.home,
      page: () => const BottomNavigationBarPage(),
      // binding: HomeViewBinding(),
      // middlewares: [
      //   // My middlewares here
      //   // IsFirstGuard(),
      //   AuthGuard(),
      // ],
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInScreen(),
      // middlewares: [
      //   // My middlewares here
      //   IsFirstGuard(),
      //   AuthGuard(),
      // ],
    ),
    GetPage(
      name: Routes.signUp,
      page: () => SignUpScreen(),
    ),
    // GetPage(
    //   name: Routes.profile,
    //   page: () => const ProfileView(),
    //   middlewares: [
    //     AuthGuard(),
    //   ],
    // ),
  ];
}

abstract class Routes {
  Routes._();

  static const home = '/home';
  static const newPwd = '/set-new-password';
  static const resetPwd = '/reset-password';
  static const forgotPwd = '/forgot-password';
  static const welcome = '/welcome';
  static const dashboard = '/dashboard';
  static const preLogin = '/pre-login';
  static const signIn = '/login';
  static const signUp = '/register';
  static const profile = '/profile';
  static const splashScreen = '/splashScreen';
}
