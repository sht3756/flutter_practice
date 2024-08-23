import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_2/pages/step_three.dart';
import 'package:flutter_native_study/course_1/bloc_2/widgets/flat_button.dart';
import 'package:flutter_native_study/course_1/bloc_3/bloc/name_bloc.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NameBloc, NameState>(builder: (context, state) {
              return TextField(
                onChanged: (name) =>
                    context.read<NameBloc>().add(NameChanged(name: name)),
                decoration: (InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력하세요.',
                  border: const OutlineInputBorder(),
                  errorText: !state.isValid ? '유효하지 않은 이름입니다.' : null,
                )),
              );
            }),
            const SizedBox(height: 20.0),
            BlocBuilder<NameBloc, NameState>(
              buildWhen: (p, c) => p.isValid != c.isValid,
              builder: (context, state) {
                return FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StepThree()));
                  },
                  text: 'Next',
                  isActive: state.isValid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
