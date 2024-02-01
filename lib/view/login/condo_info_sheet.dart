import 'package:comd_app/assets/colors.dart';
import 'package:comd_app/view/login/action_button.dart';
import 'package:comd_app/view/login/login_page.dart';
import 'package:comd_app/view/login/register_sheet.dart';
import 'package:flutter/material.dart';
import 'input_field.dart'; // Importando o InputField
late List<TextEditingController> condoControllers;
late List<TextEditingController> condoInfoControllers;
class CondoInfoSheet extends StatefulWidget {
  const CondoInfoSheet({Key? key}) : super(key: key);

  @override
  _CondoInfoSheetState createState() => _CondoInfoSheetState();
}

class _CondoInfoSheetState extends State<CondoInfoSheet> {
  final _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    condoControllers = createControllersFromApi(resultCondoText['fields']);
    condoInfoControllers = createControllersFromApi(resultCondoInfoText['fields']);
    super.initState();
  }

  List<TextEditingController> createControllersFromApi(List apiData) {
    return apiData.map((field) => TextEditingController()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                resultCondoText['title'],
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: resultCondoText['fields'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InputField(
                      label: resultCondoText['fields'][index]['label'],
                      hintText: resultCondoText['fields'][index]['placeholder'],
                      icon: resultCondoText['fields'][index]['icon'],
                      keyboardType: TextInputType.text,
                      controller: condoControllers[index],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print(
          "Todos os campos são válidos. Implemente a lógica para continuar o registro.");
    } else {
      print(
          "Pelo menos um campo tem erro de validação. Corrija os campos destacados.");
    }
  }
}
