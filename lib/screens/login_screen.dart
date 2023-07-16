import 'package:flutter/material.dart';
import 'package:nbsms/constant/constant_colors.dart';
import 'package:nbsms/constant/constant_fonts.dart';
import 'package:nbsms/constant/constant_images.dart';
import 'package:nbsms/constant/constant_mediaquery.dart';
import 'package:nbsms/model/provider.dart';
import 'package:nbsms/navigators/goto_helper.dart';
import 'package:nbsms/screens/home_screen.dart';
import 'package:nbsms/screens/register_screen.dart';
import 'package:nbsms/screens/splash_screen.dart';
import 'package:nbsms/widgets/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      goToPush(context, const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                      height: screenHeight(context) * 0.70,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.elliptical(150, 50),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              nbPrimarydarker,
                              nbPrimarycolor,
                            ],
                          ))),
                  Center(
                    child: Container(
                      width: screenWidth(context) * 0.90,
                      margin: EdgeInsets.only(top: screenHeight(context) * 0.1),
                      height: screenHeight(context) * 0.88,
                      child: Column(
                        children: [
                          Image.asset(
                            textlogo,
                            scale: 1,
                          ),
                          Text(
                            "The Most Used Nigerian SMS Site!",
                            style: TextStyle(color: nbSecondarycolor),
                          ),
                          SizedBox(height: screenHeight(context) * 0.10),
                          Container(
                            height: screenHeight(context) * 0.5,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              color: nbSecondarycolor,
                              boxShadow: [
                                BoxShadow(
                                  color: nbshadowcolor,
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                                bottom: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login -",
                                      style: TextStyle(
                                          color: fontcolor, fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: screenHeight(context) * 0.05,
                                    ),
                                    TextFormField(
                                        // onChanged: (value) =>
                                        //     loginModel.setUsername(value),
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          hintText: "Username | Email",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        }),
                                    SizedBox(
                                      height: screenHeight(context) * 0.02,
                                    ),
                                    TextFormField(
                                      // onChanged: (value) =>
                                      //     loginModel.setPassword(value),
                                      controller: _passwordController,
                                      obscureText: true,
                                      //obscuringCharacter: '',
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: screenHeight(context) * 0.03,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        goToReplace(
                                            context, const SplashScreen());
                                      },
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Forgot Password",
                                          style:
                                              TextStyle(color: nbshadowcolor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight(context) * 0.06,
                                    ),
                                    SubmitButton(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          String username =
                                              _emailController.text;
                                          String password =
                                              _passwordController.text;
                                          loginProvider.login(
                                              context, username, password);
                                        }
                                      },
                                      text: 'Login',
                                      bgcolor: nbPrimarycolor,
                                      fgcolor: nbSecondarycolor,
                                      width: screenWidth(context) * 0.95,
                                      textStyle: TextStyle(
                                          fontWeight: fnt500, fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context) * 0.06),
                              child: TextButton(
                                  onPressed: () {
                                    goToPush(context, const RegisterAccount());
                                  },
                                  child: const Text("Register Account"))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pageRoute(String status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", status);
    goToPush(context, const HomeScreen());
  }
}
