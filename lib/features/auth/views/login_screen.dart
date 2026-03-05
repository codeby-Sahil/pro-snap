import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/auth/controllers/auth_controller.dart';
import 'package:prosnap/features/auth/views/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  final AuthController controller = Get.find<AuthController>();

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(100),

                /// Logo
                Text(
                  "PRO SNAP",
                  style: TextStyle(
                    fontFamily: Fonts.bold,
                    fontSize: 32.sp,
                    letterSpacing: 6,
                    color: Colours.white,
                  ),
                ),

                verticalSpace(12),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 14.sp,
                    letterSpacing: 1.5,
                    color: Colours.white.withOpacity(0.7),
                  ),
                ),

                verticalSpace(60),

                /// Email Field
                _buildInputField(
                  hint: "Email",
                  obscure: false,
                  controller: emailField,
                  isRequired: true,
                ),

                verticalSpace(20),

                /// Password Field
                _buildInputField(
                  hint: "Password",
                  obscure: true,
                  controller: passwordField,
                  isRequired: true,
                ),

                verticalSpace(40),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.signUpisLoading.value
                              ? null
                              : () {
                                if (formKey.currentState!.validate()) {
                                  controller.signIn(
                                    email: emailField.text,
                                    password: passwordField.text,
                                  );
                                }
                              },
                      child:
                          controller.signUpisLoading.value
                              ? CircularProgressIndicator()
                              : Text("LOGIN"),
                    ),
                  ),
                ),

                const Spacer(),

                /// Create Account
                Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: Fonts.light,
                        fontSize: 13.sp,
                        color: Colours.grey,
                      ),
                    ),
                    verticalSpace(8),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: Fonts.semiBold,
                          fontSize: 14.sp,
                          letterSpacing: 1.2,
                          color: Colours.white,
                        ),
                      ),
                    ),
                  ],
                ),

                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required bool obscure,
    isRequired = false,
    controller,
  }) {
    return TextFormField(
      controller: controller,
      validator:
          isRequired
              ? (value) {
                if (value == null || value == "") {
                  return "Required";
                }
                return null;
              }
              : null,
      obscureText: obscure,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontFamily: Fonts.light, color: Colours.grey),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colours.white, width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colours.white, width: 1),
        ),
      ),
    );
  }
}
