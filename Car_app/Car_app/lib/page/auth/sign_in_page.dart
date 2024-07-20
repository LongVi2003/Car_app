import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/page/auth/sign_up_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

// sign_in_page.dart

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) async {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnachBar("Hãy nhập số điện thoại", title: "Số điện thoại");
      } else if (password.isEmpty) {
        showCustomSnachBar("Nhập mật khẩu", title: "password");
      } else if (password.length < 6) {
        showCustomSnachBar("Mật khẩu không thể nhỏ hơn 6 ", title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnachBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/image/logo.jpg"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        child: Column(
                          children: [
                            Text(
                              "Ứng dụng bán mô hình xe",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      AppTextField(
                        textController: phoneController,
                        hintText: "Phone",
                        icon: Icons.email,
                        labelText: 'Phone',
                        isObscure: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp,
                        isObscure: true,
                        labelText: 'Password',
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Sign in button
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Đăng Nhập",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //Sign up option
                      RichText(
                          text: TextSpan(
                              text: "Bạn chưa có tài khoản?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: "Tạo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.font20,
                                ))
                          ])),
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}
