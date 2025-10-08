
import 'package:fetch_api/routes/app_route.dart';
import 'package:fetch_api/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  RxString username = ''.obs;
  RxString imageUrl = ''.obs;
  final editCtl = TextEditingController();
  final _supabase = Supabase.instance.client;
  final isLoading = false.obs;
  final loadingProfile = false.obs;

  @override
void onInit() {
  super.onInit();
  loadProfile();
}

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final userId = _supabase.auth.currentUser?.id;
      if(userId == null) return;
      final response = await _supabase 
          .from('person')
          .select()
          .eq('id', userId)
          .single();
      username.value = response['username'] ?? "";

      final fileName = response['image'] as String?;
        if (fileName != null && fileName.isNotEmpty) {
      final signedUrl = await _supabase.storage
          .from('images')
          .createSignedUrl(fileName, 60 * 60); // valid 1 hour
      imageUrl.value = signedUrl;
    } else {
      imageUrl.value = "";
    }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
    
  }

  Future<void> uploadProfile() async {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        debugPrint("User not logged in!");
        return;
      }
      final ImagePicker picker = ImagePicker();
      final XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickerFile == null) return;

      final fileBytes = await pickerFile.readAsBytes();
      final fileName = 'public/image_$userId.png';

      try {
        loadingProfile.value = true;
        final profileResponse = await _supabase
            .from('person')
            .select('image')
            .eq('id', userId) // <-- check your schema!
            .single();
        final oldImage = profileResponse['image'] as String?;
        
      await _supabase.storage
            .from('images')
            .uploadBinary(
              fileName, 
              fileBytes,
              fileOptions: FileOptions(upsert: true));
      
      if(oldImage != null && oldImage != fileName){
        await _supabase.storage.from('images ').remove([oldImage],);
      }

      await _supabase
          .from('person')
          .update({'image': fileName})
          .eq('id', userId);
      
      await loadProfile();
      loadingProfile.value = false;
      } catch (e) {
        debugPrint("Error loading profile: $e");
      }
}

  Future<void> logout() async {
    await _supabase.auth.signOut();
    LocalStorageService.instan.clear("userId");
    Get.offAllNamed(AppRoute.login);
  }

  Future<void> setUsername(String newName) async {
    final userId = _supabase.auth.currentUser?.id;
    if(userId == null) return;
    isLoading.value = true;
    await _supabase.from('person').upsert({
      'id': userId,
      'username': newName,
      'updated_at': DateTime.now().toIso8601String(),
    });

    isLoading.value = false;
    username.value = newName;
    username.refresh();
    Get.back();
  }
}
