import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_2/widgets/flat_button.dart';
import 'package:flutter_native_study/course_1/bloc_3/bloc/pw_bloc.dart';

import '../bloc/email_bloc.dart';
import '../bloc/name_bloc.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  bool _isButtonActive = false;

  void _checkPwValidity() {
    final isPwMatch = _pwController.text == _confirmPwController.text;
    final isPwNotEmpty =
        _pwController.text.isNotEmpty && _confirmPwController.text.isNotEmpty;

    setState(() {
      _isButtonActive = isPwMatch && isPwNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _pwController.addListener(_checkPwValidity);
    _confirmPwController.addListener(_checkPwValidity);
  }

  @override
  void dispose() {
    _pwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PwBloc, PwState>(
              builder: (BuildContext context, PwState state) {
                return TextField(
                  onChanged: (pw) => context.read<PwBloc>().add(PwChanged(pw)),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력하세요.',
                    border: const OutlineInputBorder(),
                    errorText: !state.isPwValid ? '비밀번호는 8자 이상이어야 합니다.' : null
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<PwBloc, PwState>(
                builder: (BuildContext context, PwState state) {
              return TextField(
                onChanged: (confirmPw) =>
                    context.read<PwBloc>().add(ConfirmPwChanged(confirmPw)),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 재입력',
                  hintText: '비밀번호를 다시 입력하세요.',
                  border: const OutlineInputBorder(),
                  errorText: !state.isConfirmPwValid ? '비밀번호가 일치하지 않습니다.' : null
                ),
              );
            }),
            const SizedBox(height: 20.0),
            BlocBuilder<PwBloc, PwState>(
                buildWhen: (p, c) => p.isPwValid != c.isPwValid,
                builder: (BuildContext context, PwState state) {
                  return FlatButton(
                    onPressed: () {
                      context.read<EmailBloc>().add(EmailSubmitted());
                      context.read<NameBloc>().add(NameSubmitted());
                      context.read<PwBloc>().add(PwSubmitted());
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    text: '완료',
                    isActive: state.isPwValid && state.isConfirmPwValid,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
