
import 'package:fetch_api/auth/login_screen.dart';
import 'package:fetch_api/auth/register_screen.dart';
import 'package:fetch_api/auth/splash_screen.dart';
import 'package:fetch_api/view/card_screen.dart';
import 'package:fetch_api/view/edit_profile_screen.dart';
import 'package:fetch_api/view/favorite_screen.dart';
import 'package:fetch_api/view/home_screen.dart';
import 'package:fetch_api/view/main_screen.dart';
import 'package:fetch_api/view/profile_screen.dart';
import 'package:fetch_api/view/search_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static const splash = "/splash";
  static const login = "/login";
  static const register = "/register";
  static const main = '/main';
  static const home = '/home';
  static const favorite = "/favorite";
  static const card = "/card";
  static const profile = "/profile";
  static const editProfile = "/editProfile";
  static const search = "/search";

  static final pages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: main, page: () => MainScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: favorite, page: () => FavoriteScreen()),
    GetPage(name: card, page: () => CardScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: search, page: () => SearchScreen()),
  ];

}