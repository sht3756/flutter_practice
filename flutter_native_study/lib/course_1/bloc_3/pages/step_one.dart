import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_2/widgets/flat_button.dart';
import 'package:flutter_native_study/course_1/bloc_3/bloc/email_bloc.dart';

import 'step_two.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EmailBloc, EmailState>(builder: (context, state) {
              return TextField(
                onChanged: (email) =>
                    context.read<EmailBloc>().add(EmailChanged(email)),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: '이메일',
                    hintText: '이메일을 입력하세요.',
                    border: const OutlineInputBorder(),
                    errorText: !state.isValid ? '유효하지 않은 이메일 형식입니다.' : null),
              );
            }),
            const SizedBox(height: 20.0),
            BlocBuilder<EmailBloc, EmailState>(
                buildWhen: (p, c) => p.isValid != c.isValid,
                builder: (context, state) {
                  return FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StepTwo()));
                    },
                    text: 'Next',
                    isActive: state.isValid,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
