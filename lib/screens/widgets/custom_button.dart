// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool isEdit;
  const CustomButton({super.key, this.isEdit = false, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * .01),
      height: MediaQuery.sizeOf(context).height * .06,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Color(0XFF5555d9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: ontap,

        child:isEdit? Center(child: Icon(Icons.check_outlined,size: 18,color: Colors.white,),):Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
