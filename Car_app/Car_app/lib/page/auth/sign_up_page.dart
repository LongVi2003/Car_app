import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = ["f.png", "g.png"];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnachBar("Hãy nhập tên của bạn", title: "Tên");
      } else if (phone.isEmpty) {
        showCustomSnachBar("Hãy nhập số điện thoại", title: "Số điện thoại");
      } else if (email.isEmpty) {
        showCustomSnachBar("Hãy nhập email", title: "Địa chỉ email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnachBar("Type your valid email address ",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnachBar("Hãy nhập mật khẩu", title: "Mật khẩu");
      } else if (password.length < 6) {
        showCustomSnachBar("Mật khẩu không thể nhỏ hơn 6 kí tự ",
            title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success");
          } else {
            showCustomSnachBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
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
                      AppTextField(
                        textController: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                        labelText: 'Email',
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
                      AppTextField(
                        textController: nameController,
                        hintText: "Name",
                        icon: Icons.person,
                        labelText: 'Name',
                        isObscure: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: phoneController,
                        hintText: "Phone",
                        icon: Icons.phone,
                        labelText: 'Phone',
                        isObscure: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //Sign up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Đăng Ký",
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
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Bạn đã có sẵn tài khoản?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ))),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //Sign up option
                      RichText(
                          text: TextSpan(
                              text: "Đăng ký theo phương thức",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ))),
                      Wrap(
                        children: List.generate(
                            2,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                      radius: Dimensions.radius30,
                                      backgroundImage: AssetImage(
                                          "assets/image/" +
                                              signUpImage[index])),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
