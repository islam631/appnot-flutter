import 'package:appnote/components/crud.dart';
import 'package:appnote/components/customtextform.dart';
import 'package:appnote/components/valid.dart';
import 'package:appnote/constant/linkapi.dart';
import 'package:appnote/main.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with Crud{
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  bool isLoading = false;
  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(
        linkLogin,
        {
          "email": email.text,
          "password": password.text,
        },
      );
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPre.setString("id", response['data']['id'].toString());
        sharedPre.setString("username", response['data']['username']);
        sharedPre.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                context: context,
                title: "Attention",
                body: const Text(
                    "votre email ou bien mot de passe est incorrect , ou bien ce compte n'esxite pas"))
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          hint: "email",
                          mycontroller: email,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 5, 40);
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
                              await login();
                            },
                            child: const Text("Login")),
                        Container(height: 10),
                        InkWell(
                          child: const Text("sign up"),
                          onTap: () {
                            Navigator.of(context).pushNamed('signup');
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
