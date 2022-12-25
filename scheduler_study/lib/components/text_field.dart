import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler_study/constant/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({Key? key, required this.label, required this.isTime, required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      // null 이 리턴 되면 에러가 없다.
      // 에러가 있으면 에러를 String 값을 리턴 해준다.
      onSaved: onSaved,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }

        // isTime 일때 FilteringTextInputFormatter 로 인해 타입은 무조건 int 로 들어온다.
        if (isTime) {
          int time = int.parse(val);

          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          }

          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }
        } else {
          if (val.length > 500) {
            // maxLength: 500 를 해줘도 된다.
            return '500자 이하의 글자를 입력해주세요.';
          }
        }
        return null;
      },
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
          // 테두리 삭제
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300]),
    );
  }
}
