import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/pages/main_page.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController? emailCtrl;
  TextEditingController? passwordCtrl;

  _init() {
    emailCtrl = TextEditingController(text: 'doctor.capstone@gmail.com');
    passwordCtrl = TextEditingController(text: 'thestrongestpassword');
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel auth = Provider.of<AuthViewModel>(context, listen: false);
    final key = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: paddingOnly(
              left: 20.0,
              right: 20.0,
              top: 41.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 42,
                ),
                Text(
                  "Sign In",
                  style: kSubtitle.copyWith(
                    color: kBlack,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Hi Doc!",
                  style: kSubtitle.copyWith(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Enter your email and password to sign in",
                  style: kSubtitle.copyWith(
                    color: kGreey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextfieldCustom(
                        lable: "Email",
                        icon: Icons.email,
                        controller: emailCtrl ?? TextEditingController(),
                      ),
                      TextfieldCustom(
                        lable: "Password",
                        obscureText: true,
                        icon: Icons.lock,
                        controller: passwordCtrl ?? TextEditingController(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<AuthViewModel>(
                  builder: ((context, value, child) {
                    if (value.state == RequestState.LOADING) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (key.currentState!.validate()) {
                            auth
                                .signIn(
                              emailCtrl?.text.trim() ?? "",
                              passwordCtrl?.text.trim() ?? "",
                            )
                                .then((value) {
                              if (auth.state == RequestState.LOADED) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const MainPage()),
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    auth.errMsg,
                                    style: kBodyText.copyWith(
                                      color: kwhite,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ));
                              }
                            });
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: kBodyText.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
