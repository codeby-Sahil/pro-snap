import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/auth/controllers/auth_controller.dart';
import 'package:prosnap/features/auth/views/login_screen.dart';
import 'package:prosnap/features/auth/views/registration_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  final TextEditingController emailFiled = TextEditingController();
  final TextEditingController passwordFiled = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(70),

                /// Logo
                Text(
                  "PRO SNAP",
                  style: TextStyle(
                    fontFamily: Fonts.bold,
                    fontSize: 30.sp,
                    letterSpacing: 6,
                    color: Colours.white,
                  ),
                ),

                verticalSpace(12),

                /// Subtitle
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 14.sp,
                    letterSpacing: 1.5,
                    color: Colours.white.withOpacity(0.7),
                  ),
                ),
                verticalSpace(50),
                _buildInputField(
                  "Email",
                  false,
                  isRequired: true,
                  controller: emailFiled,
                ),
                verticalSpace(18),
                _buildInputField(
                  "Password",
                  true,
                  isRequired: true,
                  controller: passwordFiled,
                ),
                verticalSpace(18),
                verticalSpace(40),

                /// Signup Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          controller
                              .signUp(
                                email: emailFiled.text,
                                password: passwordFiled.text,
                              )
                              .then((e) {
                                if (e) {
                                  Get.off(() => ProfileSetupScreen());
                                }
                              });
                        }
                      },
                      child:
                          controller.signUpisLoading.value
                              ? CircularProgressIndicator()
                              : Text("SIGN UP"),
                    ),
                  ),
                ),

                const Spacer(),

                /// Already have account
                Column(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontFamily: Fonts.light,
                        fontSize: 13.sp,
                        color: Colours.grey,
                      ),
                    ),
                    verticalSpace(8),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                      child: Text(
                        "Login",
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

  Widget _buildInputField(
    String hint,
    bool obscure, {
    isRequired = false,
    controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value == "") {
          return "Required";
        }
        return null;
      },
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: InputDecoration(
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
      ),
    );
  }
}
