import 'package:comd_app/assets/colors.dart';
import 'package:comd_app/view/login/action_button.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class PhotoSheet extends StatefulWidget {
  const PhotoSheet({Key? key}) : super(key: key);

  @override
  State<PhotoSheet> createState() => _PhotoSheetState();
}

class _PhotoSheetState extends State<PhotoSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430, // Ajuste conforme necessário
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Envie uma foto para seu perfil de usuário",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ActionButton(
                label: 'Enviar foto',
                onPressed: () {},
                backgroundColor: AppColors().greencolor,
                textColor: Color.fromARGB(255, 0, 0, 0),
                height: 45,
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Container(
                  height: 190,
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      dashPattern: [10, 10],
                      color: Colors.grey,
                      strokeWidth: 2,
                      child: Center(
                        child: Icon(
                          Icons.upload_file,
                          size: 45,
                          color: AppColors().greencolor,
                        ),
                      )),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "O arquivo deve conter ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 131, 131, 131)),
                  ),
                  Text(
                    "até 5MB de tamanho",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 131, 131, 131)),
                  ),
                ],
              ),
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
