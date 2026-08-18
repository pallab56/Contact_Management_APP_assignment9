// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  const CustomButton({
    super.key,
    required this.title,
  }) ;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * .02),
      height: MediaQuery.sizeOf(context).height * .06,
      width: MediaQuery.sizeOf(context).width ,
      decoration: BoxDecoration(
        color: Color(0XFF5555d9),
        borderRadius: BorderRadius.circular(10),

      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: () {}, 
      
      child: Text(title,style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white),)),
    );
  }
}
