import 'package:flutter/material.dart';
import 'package:scheduler_study/constant/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          color: PRIMARY_COLOR,
          fontWeight: FontWeight.w600
        ),),
        TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            // 테두리 삭제
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300]
          ),
        ),
      ],
    );
  }
}
