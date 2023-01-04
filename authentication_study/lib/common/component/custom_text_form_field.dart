import 'package:authentication_study/common/const/colors.dart';
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final bool obscureText;
  final String? hitText;
  final String? errorText;

  const CustomTextFormField({
    Key? key,
    required this.onChanged,
    this.obscureText = false,
    this.autofocus = false,
    this.hitText,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      onChanged: onChanged,
      // 자동 포커스
      autofocus: autofocus,
      // 커서 포인트
      cursorColor: PRIMARY_COLOR,
      // 비밀번호
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hitText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,
        filled: true,
        contentPadding: EdgeInsets.all(20),
        enabledBorder: baseBorder,
        focusedBorder:
        baseBorder.copyWith(borderSide: BorderSide(color: PRIMARY_COLOR)),
      ),
    );
  }
}
