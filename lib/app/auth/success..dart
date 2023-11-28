import 'package:flutter/material.dart';

class Seccess extends StatefulWidget {
  const Seccess({super.key});

  @override
  State<Seccess> createState() => _SeccessState();
}

class _SeccessState extends State<Seccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "تم تسجيل الحساب بنجاح الان يمكنك تسجيل الدخول",
              style: TextStyle(fontSize: 20),
            ),
          ),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: const Text("login"),
          ),
        ],
      ),
    );
  }
}
