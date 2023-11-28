import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Crud {
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
  //final Crud _crud = Crud();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkSignUp, {
        //_crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        // ignore: avoid_print
        print("signup fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          hint: "username",
                          mycontroller: username,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          hint: "email",
                          mycontroller: email,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 8, 15);
                          },
                          hint: "password",
                          mycontroller: password,
                        ),
                        MaterialButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            onPressed: () async {
                              await signUp();
                            },
                            child: const Text("Sign up")),
                        Container(height: 10),
                        InkWell(
                          child: const Text("Login"),
                          onTap: () {
                            Navigator.of(context).pushNamed('login');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
