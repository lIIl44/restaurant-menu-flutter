import 'package:get/get.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/menu/menu_page.dart';
import '../../presentation/pages/cart/cart_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/signup_page.dart';
import '../../presentation/pages/order/order_detail_page.dart';
import '../../presentation/pages/menu/menu_detail_page.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/';
  static const HOME = '/home';
  static const MENU = '/menu';
  static const CART = '/cart';
  static const PROFILE = '/profile';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const ORDER_DETAIL = '/order-detail';
  static const MENU_DETAIL = '/menu-detail';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: MENU,
      page: () => const MenuPage(),
    ),
    GetPage(
      name: CART,
      page: () => const CartPage(),
    ),
    GetPage(
      name: PROFILE,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: SIGNUP,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: ORDER_DETAIL,
      page: () => const OrderDetailPage(),
    ),
    GetPage(
      name: MENU_DETAIL,
      page: () => const MenuDetailPage(),
    ),
  ];
}