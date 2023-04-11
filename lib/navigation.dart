// import 'package:finpay/bindings/init_binding.dart';
// import 'package:finpay/services/auth_guard.dart';
// import 'package:finpay/view/login/login_screen.dart';
// import 'package:finpay/view/profile/profile_view.dart';
// import 'package:finpay/view/signup/signup_screen.dart';
// import 'package:finpay/view/splash/splash.dart';
// import 'package:finpay/view/splash/welcome_screen.dart';
// import 'package:finpay/view/tab_screen.dart';
import 'package:gando/controllers/car_controller.dart';
import 'package:gando/views/admin/articles_list_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:gando/bindings/profile_binding.dart';
import 'package:gando/views/admin/verify_owner_screen.dart';
import 'package:gando/views/authentication/PreLogin/PreLogin.dart';
import 'package:gando/views/authentication/resetPassword/change_password.dart';
import 'package:gando/views/authentication/resetPassword/reset_password.dart';
import 'package:gando/views/authentication/resetPassword/forgot_password.dart';
import 'package:gando/views/authentication/signin/signin_screen.dart';
import 'package:gando/views/authentication/signup/signup_screen.dart';
import 'package:gando/views/bottom_navigation_bar.dart';
import 'package:gando/views/onboarding.dart';
import 'package:gando/views/products/booking/payment/payment_stripe_screen.dart';
import 'package:gando/views/settings/notification_screen.dart';
import 'package:gando/views/settings/pages/coordonates/edit_phone_coordonates_screen.dart';
import 'package:gando/views/settings/pages/coordonates/home_coordonates_screen.dart';
import 'package:gando/views/settings/pages/coordonates/my_contact_detail_screen.dart';
import 'package:gando/views/settings/pages/coordonates/summary_coordonate_screen.dart';
import 'package:gando/views/settings/pages/coordonates/verify_phone_coordonate_screen.dart';
import 'package:gando/views/settings/pages/edit_profile_screen.dart';
import 'package:gando/views/settings/pages/profile_screen.dart';
import 'package:gando/views/settings/pages/verify_mail_screen.dart';
import 'package:gando/views/settings/pages/wallet/verify_identity_user_screen.dart';
import 'package:gando/views/settings/pages/wallet/wallet_screen.dart';
import 'package:gando/views/settings/settings_account.dart';
import 'package:gando/views/products/detail/components/car_detail.dart';
import 'package:gando/views/splashscreen/splash_screen.dart';
import 'package:get/get.dart';

import 'bindings/init_bindings.dart';
import 'middlewares/auth_middlewares.dart';

class AppPages {
  AppPages._();

  static get INITIAL => Routes.splashScreen;

  static final appPages = [
    GetPage(
      name: Routes.preLogin,
      page: () => PreLogin(),
      binding: InitBindings(),
      middlewares: [RequireVisitor()],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.forgotPwd,
      page: () => ForgotPasswordScreen(),
      middlewares: [RequireVisitor()],
    ),
    GetPage(
      name: Routes.resetPwd,
      page: () => ResetRecoveryOtpScreen(),
      middlewares: [RequireVisitor()],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.newPwd,
      page: () => ChangePasswordScreen(),
      middlewares: [RequireVisitor()],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      // binding: InitBindings(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.CAR_DETAIL,
      page: () => CarDetailPage(
        car: Get.arguments,
      ),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => OnboardingScreen(),
      binding: InitBindings(),
      // middlewares: [
      //   IsFirstGuard(),
      //   // My middlewares here
      //   AuthGuard(),
      // ],
    ),
    GetPage(
      name: Routes.home,
      page: () => const BottomNavigationBarPage(),
      binding: InitBindings(),
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: Routes.MY_ANNONCE,
      page: () => ArticleListScreen(),
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignInScreen(),
      middlewares: [IsFirstOpen(), RequireVisitor()],
    ),
    GetPage(
      name: Routes.signUp,
      middlewares: [IsFirstOpen(), RequireVisitor()],
      page: () => SignUpScreen(),
    ),
    GetPage(
        name: Routes.profile,
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
      name: Routes.editProfil,
      page: () => EditProfileScreen(),
      binding: InitBindings(),
    ),
    GetPage(
        name: Routes.verifyPhoneCoordonate,
        page: () => VerifyPhoneCoordonateScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.editPhoneCoordonate,
        page: () => EditPhoneCoordonateScreen(),
        binding: ProfileBinding()),
    GetPage(
      name: Routes.summaryCoordonate,
      page: () => const SummaryCoordonateView(),
      binding: InitBindings(),
    ),
    GetPage(name: Routes.homeCordonate, page: () => HomeCordonatesView()),
    GetPage(
      name: Routes.detailCordonate,
      page: () => MyContactDetailScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.verifyOwner,
      page: () => VerifyOwnerScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.settingAccount,
      page: () => SettingsAccountScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.verifyMail,
      page: () => VerifyMailOtpScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.paymentStripe,
      page: () => const PaymentStripeScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.wallet,
      page: () => const WalletScreen(),
      binding: InitBindings(),
    ),
    GetPage(
      name: Routes.verifyIdentity,
      page: () => const VerifyIdentityUserScreen(),
      binding: InitBindings(),
    ),
  ];
}

abstract class Routes {
  Routes._();

  static const home = '/home';
  static const newPwd = '/set-new-password';
  static const CAR_DETAIL = '/car-detail';
  static const MY_ANNONCE = '/user/annonce';
  static const resetPwd = '/reset-password';
  static const forgotPwd = '/forgot-password';
  static const welcome = '/welcome';
  static const dashboard = '/dashboard';
  static const preLogin = '/pre-login';
  static const signIn = '/login';
  static const signUp = '/register';
  static const profile = '/profile';
  static const editProfil = '/edit-profil';
  static const splashScreen = '/splashScreen';
  static const homeCordonate = "/home-coordonate";
  static const detailCordonate = "/detail-coordonate";
  static const editPhoneCoordonate = "/edit-phone-coordonate";
  static const verifyPhoneCoordonate = "/verify-phone-coordonate";
  static const summaryCoordonate = "/summary-coordonate";
  static const verifyOwner = "/verify-owner";
  static const notification = "/notification";
  static const settingAccount = "/setting-account";
  static const verifyMail = "/verify-mail";
  static const paymentStripe = "/payment-stripe";
  static const wallet = "/wallet";
  static const verifyIdentity = "/verify_identity_user";
}
