import 'dart:async';

import 'package:comd_app/assets/colors.dart';
import 'package:comd_app/controller/get_request.dart';
import 'package:comd_app/view/login/register_sheet.dart';
import 'package:flutter/material.dart';
import 'login_sheet.dart';

dynamic resultRegisterText;
dynamic resultCondoText;
dynamic resultFirstStepText;
dynamic resultCondoInfoText;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void capturarTextos()async{
    resultRegisterText = await GetRequest('https://lrjm6.wiremockapi.cloud').fetchData(endpoint: 'register/user');
    resultCondoText = await GetRequest('https://lrjm6.wiremockapi.cloud').fetchData(endpoint: 'register/user/condominium');
    resultFirstStepText = await GetRequest('https://lrjm6.wiremockapi.cloud').fetchData(endpoint: 'register/step1');
    resultCondoInfoText = await GetRequest('https://lrjm6.wiremockapi.cloud').fetchData(endpoint: 'register/condominium');
  }

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        etapaConcluida;
      });
    });
    capturarTextos();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSheet(context);
    });
    super.initState();
  }

  int checarFlex(){
    
    if(!etapaConcluida[0] && !etapaConcluida[1] && !etapaConcluida[2] && !etapaConcluida[3])return 0;
    if(etapaConcluida[0] && !etapaConcluida[1] && !etapaConcluida[2] && !etapaConcluida[3])return 1;
    if(etapaConcluida[0] && etapaConcluida[1] && !etapaConcluida[2] && !etapaConcluida[3])return 2;
    if(etapaConcluida[0] && etapaConcluida[1] && etapaConcluida[2] && !etapaConcluida[3])return 3;
    if(etapaConcluida[0] && etapaConcluida[1] && etapaConcluida[2] && etapaConcluida[3])return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'lib/assets/app-logo.png',
            filterQuality: FilterQuality.high,
            height: 80,
            width: 130,
          ),
          Stack(
            children: [
              Center(
                  child: Image.asset(
                'lib/assets/background-cellphone.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitWidth,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                    child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white,
                  ),
                  child: Container(
                    width: 230,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: checarFlex(),
                            child: Container(height: 4,decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)), color: AppColors().greencolor),),),
                          Expanded(
                            flex: (4 - checarFlex()),
                            child: Container(height: 4, decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32)), color: Colors.grey),))
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab",
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 3,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
        onPressed: () {
          _showSheet(context);
        },
      ),
    );
  }

  void _showSheet(context) {
    showModalBottomSheet(
      // isDismissible: false,
      isDismissible: true,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return LoginSheet();
      },
    );
  }
}
