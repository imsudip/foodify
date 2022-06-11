import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../Controllers/auth_controller.dart';
import '../Widgets/button.dart';
import '../Widgets/card.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';
import 'onboarding/diet_filter.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  final AuthController authController = Get.find();
  final divider = const Divider(
    color: AppColors.textSecondaryColor,
  );
  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extremely Active'
  ];
  final ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Iconsax.personalcard5,
              color: AppColors.primaryColor,
              size: 28,
            ),
            Text(
              ' Account Details',
              style: AppTextStyle.headline2.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                      child: authController.userData.value['userPhotoUrl'] == null ||
                              authController.userData.value['userPhotoUrl'] == ''
                          ? Image.asset((authController.userData.value['gender'] ?? 'Male') == "Male"
                              ? "images/male_placeholder.png"
                              : "images/female_placeholder.png")
                          : AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: authController.userData.value['userPhotoUrl'] ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          showUploadSheet();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Iconsax.edit,
                            color: AppColors.primaryWhiteColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                authController.userData.value['userName'] ?? '',
                style: AppTextStyle.headline3.copyWith(color: AppColors.textPrimaryColor),
              ),
              Text(
                authController.firebaseUser.value?.email ?? '',
                style: AppTextStyle.bodytext2,
              ),
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerLeft, child: Text(" Personal Details", style: AppTextStyle.headline3)),
              const SizedBox(height: 6),
              CustomCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(children: [
                    _rowBulder('Food Preference', '${authController.userData.value['diet'] ?? 'None'}'),
                    divider,
                    _rowBulder('Calories Intake', '${authController.userData.value['calorie'] ?? 'None'} cal'),
                    divider,
                    _rowBulder('Weight', '${authController.userData.value['weight'] ?? 'None'} kg'),
                    divider,
                    _rowBulder('Height', '${authController.userData.value['height'] ?? 'None'} cm'),
                    divider,
                    _rowBulder('Age', '${authController.userData.value['age'] ?? 'None'}'),
                    divider,
                    _rowBulder('Gender', '${authController.userData.value['gender'] ?? 'None'}'),
                    divider,
                    _rowBulder('Activity Level', activityLevels[authController.userData.value['activityLevel'] ?? 0]),
                    const SizedBox(height: 12),
                    Button(
                      text: 'Change Personal Details',
                      height: 52,
                      color: AppColors.backgroundColor,
                      border: Border.all(color: AppColors.accentColor),
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        Get.to(() => const DietFilterScreen());
                      },
                    ),
                  ])),
              const SizedBox(height: 12),
              Button(
                text: 'Logout',
                height: 52,
                onPressed: () {
                  authController.signOut();
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Row _rowBulder(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.bodytext2.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.bodytext2.copyWith(color: AppColors.textPrimaryColor),
        ),
      ],
    );
  }

  void showUploadSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(10),
        height: 132,
        child: Column(
          children: [
            TextButton(
                onPressed: () => pickImage(fromGallery: true), child: Text("Gallery", style: AppTextStyle.subHeading)),
            const Divider(
              color: AppColors.accentColor,
              height: 1,
            ),
            TextButton(onPressed: () => pickImage(), child: Text("Camera", style: AppTextStyle.subHeading)),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryWhiteColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      enableDrag: true,
    );
  }

  void pickImage({
    bool fromGallery = false,
  }) async {
    final XFile? image = await imagePicker.pickImage(source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    Get.back();
    if (image == null) {
      Get.snackbar(
        "No Image Selected",
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
      );
      return;
    }
    var imageSize = await image.length();
    if (imageSize > 1000000) {
      Get.snackbar(
        "Image must be less than 2MB",
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
      );
      return;
    }
    var url = await uploadImage(image.path, authController.firebaseUser.value!.uid);
    authController.updateUserDocument({
      'userPhotoUrl': url,
    });
  }

  Future<String> uploadImage(String path, String uid) async {
    try {
      String ext = path.split(".").last;
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref("userImages/$uid/${DateTime.now().microsecondsSinceEpoch}.$ext")
          .putFile(File(path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) {
        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white60,
        );
        return "";
      }
      if (snapshot.state == TaskState.success) {
        return snapshot.ref.getDownloadURL();
      }
      return "";
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
      );
      return "";
    }
  }
}
