import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Icon icon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * .01),
      height: MediaQuery.sizeOf(context).height * .06,
      width: MediaQuery.sizeOf(context).width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade700, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2),
          ),
        ),
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        validator: (value) {
          if (value!.isEmpty) {
            return '$label is missing!';
          }
        },
      ),
    );
  }
}
