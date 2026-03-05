import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/core/router/routes.dart';
import 'package:prosnap/features/auth/controllers/auth_controller.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  String? selectedGender;
  DateTime? selectedDate;

  get birthday {
    String day = selectedDate!.day.toString().padLeft(2, "0");
    String month = selectedDate!.month.toString().padLeft(2, "0");
    String year = selectedDate!.year.toString().padLeft(4, "0");
    return "$day/$month/$year";
  }

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(40),

                /// Logo
                Text(
                  "PRO SNAP",
                  style: TextStyle(
                    fontFamily: Fonts.bold,
                    fontSize: 28.sp,
                    letterSpacing: 6,
                    color: Colours.white,
                  ),
                ),

                verticalSpace(10),

                Text(
                  "Complete Profile",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 14.sp,
                    letterSpacing: 1.5,
                    color: Colours.white.withOpacity(0.7),
                  ),
                ),

                verticalSpace(40),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 110.h,
                    width: 110.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colours.white, width: 1),
                    ),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colours.white.withOpacity(0.7),
                      size: 28.sp,
                    ),
                  ),
                ),
                verticalSpace(40),
                _buildInputField(
                  "Username",
                  controller: username,
                  isRequired: true,
                ),
                verticalSpace(18),
                _buildInputField(
                  "Full Name",
                  controller: fullname,
                  isRequired: true,
                ),
                verticalSpace(18),
                _buildGenderDropdown(),
                verticalSpace(18),
                _buildDobField(context),
                _buildBioField(bio),
                verticalSpace(40),

                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.signUpisLoading.value
                              ? null
                              : () async {
                                if (formkey.currentState!.validate()) {
                                  bool result = await controller
                                      .saveUserDetailed(
                                        name: fullname.text,
                                        username: username.text,
                                        gender: selectedGender ?? "",
                                        dob: birthday,
                                        bio: bio.text,
                                      );

                                  if (result) {
                                    Get.offAllNamed(Routes.homeScreen);
                                  }
                                }
                              },
                      child:
                          controller.signUpisLoading.value
                              ? CircularProgressIndicator()
                              : Text("CONTINUE"),
                    ),
                  ),
                ),

                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, {isRequired = false, controller}) {
    return TextFormField(
      controller: controller,
      validator:
          isRequired
              ? (value) {
                if (value == null || value == "") {
                  return "Field Required";
                }
                return null;
              }
              : null,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: _inputDecoration(hint),
    );
  }

  Widget _buildBioField(controller) {
    return TextFormField(
      controller: controller,
      maxLines: 3,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: _inputDecoration("Bio"),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colours.primary,
      value: selectedGender,
      style: TextStyle(fontFamily: Fonts.medium, color: Colours.white),
      decoration: _inputDecoration("Gender"),
      items:
          ["Male", "Female", "Other"]
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender)),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
    );
  }

  Widget _buildDobField(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colours.white,
                  onPrimary: Colours.primary,
                  surface: Colours.primary,
                  onSurface: Colours.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          style: TextStyle(
            fontFamily: Fonts.medium,
            fontSize: 14.sp,
            color: Colours.white,
          ),
          decoration: _inputDecoration(
            selectedDate == null
                ? "Date of Birth"
                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontFamily: Fonts.light, color: Colours.grey),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colours.white, width: 0.6),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colours.white, width: 1),
      ),
    );
  }
}
