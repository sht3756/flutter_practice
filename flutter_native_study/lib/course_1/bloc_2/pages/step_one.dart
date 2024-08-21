import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/bloc_2/widgets/flat_button.dart';

import 'step_two.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final TextEditingController _emailController = TextEditingController();

  bool _isButtonActive = false;

  void _checkEmailValidity() {
    final email = _emailController.text;
    final isEmailValid =
        RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);

    setState(() {
      _isButtonActive = isEmailValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkEmailValidity);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: '이메일을 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StepTwo()));
              },
              text: 'Next',
              isActive: _isButtonActive,
            ),
          ],
        ),
      ),
    );
  }
}
