import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_flutter/utils/services.dart';
import 'package:web_socket_flutter/view/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errMssg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Color.fromARGB(255, 2, 39, 69)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(4.0),
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4.0), hintText: "Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                elevation: 0,
              ),
              onPressed: () async {
                await Services()
                    .postLogin(email.text, password.text)
                    .then((onValue) async {
                  if (onValue["status"] == 422 || onValue["status"] == 401) {
                    setState(() => errMssg = onValue['data']['message']);
                    return;
                  }

                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(
                      "access_token", onValue['data']['access_token']);

                  Navigator.of(context).pop();
                });
              },
              child: Text(
                "Submit",
                selectionColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterView()),
              ),
              child: Text(
                "register",
                selectionColor: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errMssg,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
