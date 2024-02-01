import 'package:comd_app/controller/login_request.dart';
import 'package:comd_app/view/login/condo_info_sheet.dart';
import 'package:comd_app/view/login/input_field.dart';
import 'package:comd_app/view/login/login_page.dart';
import 'package:flutter/material.dart';

class ResidentialSheet extends StatefulWidget {
  const ResidentialSheet({Key? key}) : super(key: key);

  @override
  _ResidentialSheetState createState() => _ResidentialSheetState();
}

class _ResidentialSheetState extends State<ResidentialSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMoradia;
  final List<String> _moradiaOptions = [];

  

  @override
  void initState() {
    
    resultCondoInfoText['fields'][2]['options'].forEach((field) {
      _moradiaOptions.add(field['description']);
    });
    super.initState();
  }

  List<TextEditingController> createControllersFromApi(List apiData) {
    return apiData.map((field) => TextEditingController()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  resultCondoInfoText['title'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: resultCondoInfoText['fields'].length,
                    itemBuilder: (context, index) {
                      return (index != 1 && index != 2)?InputField(
                        label: resultCondoInfoText['fields'][index]['label'],
                        hintText: resultCondoInfoText['fields'][index]['placeholder'],
                        icon: resultCondoInfoText['fields'][index]['icon'],
                        keyboardType: TextInputType.text,
                        controller: condoInfoControllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      )
                      :Row(
                    children: [
                      index==1?Expanded(
                        child: InputField(
                          label: resultCondoInfoText['fields'][index]['label'],
                          hintText: resultCondoInfoText['fields'][index]['placeholder'],
                          icon: resultCondoInfoText['fields'][index]['icon'],
                          keyboardType: TextInputType.text,
                          controller: condoInfoControllers[index],
                        ),
                      ):Container(),
                      const SizedBox(width: 10),
                      index==2?Container():Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resultCondoInfoText['fields'][index+1]['label'],
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 1),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedMoradia,
                                  items: _moradiaOptions.map((moradia) {
                                    return DropdownMenuItem<String>(
                                      value: moradia,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                        child: Text(moradia),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMoradia = value;
                                      condoInfoControllers[index+1].text = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}