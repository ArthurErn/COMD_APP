import 'package:comd_app/assets/colors.dart';
import 'package:comd_app/controller/login_request.dart';
import 'package:comd_app/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'input_field.dart';
import 'action_button.dart';
import 'register_sheet.dart';

class LoginSheet extends StatefulWidget {
  @override
  _LoginSheetState createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            const Text(
              "Bem-vindo ao COMD",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            InputField(
              label: 'Nome completo',
              hintText: 'Nome',
              icon: 'icon-user',
              controller: _usernameController,
            ),
            SizedBox(height: 10),
            InputField(
              label: 'Senha',
              hintText: 'Senha',
              icon: 'icon-password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                print("Clicou em 'Esqueceu sua senha?'");
              },
              child: Text(
                'Esqueceu sua senha?',
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 15),
            ActionButton(
              label: 'Entrar',
              onPressed: () async {
                final loginRequest =
                    HttpRequest('https://lrjm6.wiremockapi.cloud');
                dynamic result = await loginRequest.performLogin(jsonData: {
                  'Login': _usernameController.text,
                  'Password': _passwordController.text,
                }, endpoint: 'login');
                if (result['Success'] == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
              backgroundColor: AppColors().greencolor,
              height: 55,
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'Ainda não tem cadastro?',
                style: TextStyle(fontSize: 11, color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            ActionButton(
              label: 'Cadastrar-se agora',
              onPressed: () {
                showFirstModal(context);
              },
              backgroundColor: Colors.white,
              textColor: AppColors().greencolor,
              borderColor: AppColors().greencolor,
              height: 55,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("Clicou em 'Facebook'");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize:
                        Size((MediaQuery.of(context).size.width - 40) / 2, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.facebook, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Facebook',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Clicou em 'Google'");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize:
                        Size((MediaQuery.of(context).size.width - 40) / 2, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.android, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Google',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
