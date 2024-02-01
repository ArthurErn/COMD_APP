import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? child; // Adição do Widget child

  const InputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.child, // Adição do Widget child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[700]),
        ),
        const SizedBox(height: 1),
        Container(
          height: 50, // Altura ajustada para 50
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            controller: controller,
            validator: validator,
          ),
        ),
        if (child != null) // Adição do child
          child!,
      ],
    );
  }
}
