import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/bloc_2/widgets/flat_button.dart';

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
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호 재입력',
                hintText: '비밀번호를 다시 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            FlatButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              text: '완료',
              isActive: _isButtonActive,
            )
          ],
        ),
      ),
    );
  }
}
