import 'package:flutter/material.dart';
import 'package:hello_world_first/random_number_study/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // stretch 만 넣어도 버튼이 커지지만, SafeArea를 통해서 하단바에 안붙게 적용
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(
                maxNumber: maxNumber,
              ),
              _Footer(
                  onSliderChanged: onSliderChanged,
                  onButtonPressed: onButtonPressed,
                  maxNumber: maxNumber),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber
            .toInt()
            .toString()
            .split('')
            .map((e) => Image.asset(
                  'asset/img/random_number/$e.png',
                  width: 50.0,
                  height: 70.0,
                ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;
  final double maxNumber;

  const _Footer(
      {required this.onSliderChanged,
      required this.onButtonPressed,
      required this.maxNumber,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          child: Text('저장!'),
          style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
        )
      ],
    );
  }
}
