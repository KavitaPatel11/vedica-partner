import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/no_internet/no_internet_screen.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/balance/bindings/balance_binding.dart';
import '../modules/balance/views/balance_view.dart';
import '../modules/bank/bindings/bank_binding.dart';
import '../modules/bank/views/bank_view.dart';
import '../modules/ekyc/bindings/ekyc_binding.dart';
import '../modules/ekyc/views/ekyc_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invest/bindings/invest_binding.dart';
import '../modules/invest/views/invest_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/nominee/bindings/nominee_binding.dart';
import '../modules/nominee/views/nominee_view.dart';
import '../modules/offers/bindings/offers_binding.dart';
import '../modules/offers/views/offers_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/overview/bindings/overview_binding.dart';
import '../modules/overview/views/overview_view.dart';
import '../modules/portfolios/bindings/portfolios_binding.dart';
import '../modules/portfolios/views/portfolios_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW,
      page: () => const OverviewView(),
      binding: OverviewBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.OFFERS,
      page: () => const OffersView(),
      binding: OffersBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PORTFOLIOS,
      page: () => const PortfoliosView(),
      binding: PortfoliosBinding(),
    ),
    GetPage(
      name: _Paths.BALANCE,
      page: () => const BalanceView(),
      binding: BalanceBinding(),
    ),
    GetPage(
      name: _Paths.EKYC,
      page: () => EkycView(),
      binding: EkycBinding(),
    ),
    GetPage(
      name: _Paths.BANK,
      page: () => const BankView(),
      binding: BankBinding(),
    ),
    GetPage(
      name: _Paths.INVEST,
      page: () => const InvestView(),
      binding: InvestBinding(),
    ),
    GetPage(
      name: _Paths.NOMINEE,
      page: () => const NomineeView(),
      binding: NomineeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.NOINTERNET,
      page: () => NoInternetScreen(),
    ),
  ];
}
