import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'signup_model.dart';

import 'app_text_field.dart';
import 'data_class.dart';
import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    Future<void> registration() async {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      SignUpBody signUpBody = SignUpBody(
          name: name, phone: phone, email: email, password: password);
      var provider = Provider.of<DataClass>(context, listen: false);
      await provider.postData(signUpBody);
      if (provider.isBack) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Consumer<DataClass>(builder: (context, data, child) {
          return data.loading
              ? Center(
                  child: SpinKitThreeBounce(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    },
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      //app logo
                      SizedBox(
                          height: 100,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 80,
                            ),
                          )),
                      //your email
                      AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      //your password
                      AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true),
                      const SizedBox(
                        height: 20,
                      ),
                      //your name
                      AppTextField(
                          textController: nameController,
                          hintText: "Name",
                          icon: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      //your phone
                      AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone),
                      const SizedBox(
                        height: 20 + 20,
                      ),
                      //sign up button
                      GestureDetector(
                        onTap: () {
                          registration();
                        },
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 23),
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF74beef),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //tag line
                      RichText(
                          text: TextSpan(
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 20))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      //sign up options
                      RichText(
                          text: TextSpan(
                              text:
                                  "Sign up using one of the following methods",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 16))),
                    ],
                  ),
                );
        }));
  }
}
