import 'package:comd_app/assets/colors.dart';
import 'package:comd_app/view/login/action_button.dart';
import 'package:comd_app/view/login/condo_info_sheet.dart';
import 'package:comd_app/view/login/login_page.dart';
import 'package:comd_app/view/login/photo_sheet.dart';
import 'package:comd_app/view/login/residential_sheet.dart';
import 'package:comd_app/view/login/validate_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'input_field.dart'; // Importando o InputField

late List<TextEditingController> registerControllers;

class RegisterSheet extends StatefulWidget {
  const RegisterSheet({super.key});

  @override
  _RegisterSheetState createState() => _RegisterSheetState();
}

final _formKey = GlobalKey<FormState>();
final _phoneController = MaskedTextController(mask: '(00) 9 0000-0000');
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _cpfController = MaskedTextController(mask: '000.000.000-00');
final _rgController = TextEditingController();
final _addressController = TextEditingController();

List<bool> etapaConcluida = [false, false, false, false];

class _RegisterSheetState extends State<RegisterSheet> {
  @override
  void initState() {
    registerControllers =
        createControllersFromApi(resultRegisterText['fields']);
    super.initState();
  }

  List<TextEditingController> createControllersFromApi(List apiData) {
    return apiData.map((field) => TextEditingController()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          height: 390,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                resultRegisterText['title'],
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: resultRegisterText['fields'].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InputField(
                        label: resultRegisterText['fields'][index]['label'],
                        hintText: resultRegisterText['fields'][index]
                            ['placeholder'],
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: registerControllers[index],
                        // validator: validateName,
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget actualPage() {
  if (etapaConcluida[3] == true) {
    return PhotoSheet();
  }
  if (etapaConcluida[2] == true && etapaConcluida[3] == false) {
    return ResidentialSheet();
  }
  if (etapaConcluida[1] == true && etapaConcluida[2] == false) {
    return CondoInfoSheet();
  }
  if (etapaConcluida[0] == true && etapaConcluida[1] == false) {
    return RegisterSheet();
  }

  return Container();
}

void showRegisterModal(context) {
  etapaConcluida[0] = true;
  showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 510,
            child: Column(
              children: [
                actualPage(),
                etapaConcluida[1] == true && etapaConcluida[2] == false
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              resultCondoText['paragraphs'][0].toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 131, 131, 131)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ActionButton(
                              label: 'Cadastrar condomínio',
                              onPressed: () {
                                setState(() {
                                  etapaConcluida[2] = true;
                                });
                              },
                              backgroundColor: Colors.white,
                              textColor: Color.fromARGB(255, 131, 131, 131),
                              borderColor: Color.fromARGB(255, 131, 131, 131),
                              height: 55,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setState(() {
                              if (etapaConcluida[0] == true &&
                                  etapaConcluida[1] == false) {
                                Navigator.pop(context);
                                etapaConcluida[0] = false;
                              } else if (etapaConcluida[1] == true &&
                                  etapaConcluida[2] == false) {
                                etapaConcluida[1] = false;
                              } else if (etapaConcluida[2] == true &&
                                  etapaConcluida[3] == false) {
                                etapaConcluida[2] = false;
                              } else if (etapaConcluida[3] == true) {
                                etapaConcluida[3] = false;
                                etapaConcluida[2] = false;
                              }
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[700]!),
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 40) / 2, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          etapaConcluida[0] ? 'Voltar' : 'Cancelar',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (etapaConcluida[1] || (_formKey.currentState!.validate())) {
                          setState(() {
                            etapaConcluida[0] = true;
                            if (etapaConcluida[3] == true)
                              showMyInfosModal(context);
                            if (etapaConcluida[2]) etapaConcluida[3] = true;
                            if (etapaConcluida[1]) {
                              etapaConcluida[3] = true;
                              etapaConcluida[2] = true;
                            }
                            if (etapaConcluida[0]) etapaConcluida[1] = true;
                          });
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors().greencolor,
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 40) / 2, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
}

void showFirstModal(context) {
  int selectedModel = 0;
  showModalBottomSheet(
      isDismissible: true,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 490,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    resultFirstStepText['title'].toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: resultFirstStepText['paragraphs'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resultFirstStepText['paragraphs'][index]
                                  .toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 131, 131, 131)),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedModel = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedModel == 1
                              ? Colors.grey[300]
                              : Colors.white,
                          primary: Colors.white,
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 110) / 2,
                              70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          resultFirstStepText['buttons'][0]['buttons'][0]
                              ['label'],
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedModel = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedModel == 2
                              ? Colors.grey[300]
                              : Colors.white,
                          primary: Colors.white,
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 110) / 2,
                              70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          resultFirstStepText['buttons'][0]['buttons'][1]
                              ['label'],
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setState(() {
                              Navigator.pop(context);
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[700]!),
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 40) / 2, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          resultFirstStepText['buttons'][1]['buttons'][0]
                              ['label'],
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (etapaConcluida[1] || (_formKey.currentState!.validate())) {
                          setState(() {
                            Navigator.pop(context);
                            showRegisterModal(context);
                          });
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors().greencolor,
                          minimumSize: Size(
                              (MediaQuery.of(context).size.width - 40) / 2, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          resultFirstStepText['buttons'][1]['buttons'][1]
                              ['label'],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
}

void showMyInfosModal(context) {
  showModalBottomSheet(
      isDismissible: false,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text('Minhas informações',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600))),
                  SizedBox(height: 10),
                  Center(
                      child: Text(
                          'Observe se as informações estão corretas para não ter nenhum problema indevido antes de concluir seu cadastro.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[400]))),
                ],
              ),
            ),
          );
        });
      });
}
