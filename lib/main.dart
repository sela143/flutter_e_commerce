import 'package:fetch_api/app.dart';
import 'package:fetch_api/controller/card_controller.dart';
import 'package:fetch_api/controller/favorite_controller.dart';
import 'package:fetch_api/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService.instan.init();
  Get.put(FavoriteController());
  Get.put(CardController());

  await dotenv.load(fileName: ".env");
  final url = dotenv.env['URL'];
  final anonKey = dotenv.env['ANON_KEY'];

  await Supabase.initialize(
    url: url!,
    anonKey: anonKey!,
  );
  
  runApp(const MyApp());
}

