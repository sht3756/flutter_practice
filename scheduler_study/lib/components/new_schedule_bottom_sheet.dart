import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler_study/components/text_field.dart';
import 'package:scheduler_study/constant/colors.dart';
import 'package:scheduler_study/database/drift_database.dart';
import 'package:scheduler_study/model/category_color.dart';
import 'package:scheduler_study/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    // 시스템적으로 가려진 부분
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? newValue) {
                        print('newValue $newValue');
                        startTime = int.parse(newValue!);
                      },
                      onEndSaved: (String? newValue) {
                        endTime = int.parse(newValue!);
                      },
                    ),
                    SizedBox(height: 16.0),
                    _Content(
                      onSaved: (String? newValue) {
                        content = newValue;
                      },
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          return _ColorPicker(
                            colors: snapshot.hasData
                                ? snapshot.data!.map((e) => Color(
                                      int.parse(
                                        'FF${e.hexCode}',
                                        radix: 16,
                                      ),
                                    )).toList()
                                : [],
                          );
                        }),
                    SizedBox(height: 8.0),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey 는 생성했는데 Form 위젯과 결합을 안했을때 (Form 위젯에 key 값 안넣을때)
    if (formKey.currentState == null) {
      return;
    }
    // 모든 textField 를 검증을 하고서 다 null 값이 다 리턴되면(모두 에러가 안나면) true 리턴
    if (formKey.currentState!.validate()) {
      // true: TextFormField(validator)은 null 로 리턴을 했다.
      print('에러가 없습니다.');
      formKey.currentState!.save();

      print('----');
      print('startTime : $startTime');
      print('endTime : $endTime');
      print('content : $content');
    } else {
      // false: TextFormField(validator)은 string 값을 리턴한다.
      print('에러 가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({Key? key, required this.onStartSaved, required this.onEndSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('onStartSaved : $onStartSaved');
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          isTime: true,
          onSaved: onStartSaved,
        )),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: onEndSaved,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final List<Color> colors;

  const _ColorPicker({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors.map((e) => renderColor(e)).toList(),
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                onPressed: onPressed,
                child: Text('저장'))),
      ],
    );
  }
}
