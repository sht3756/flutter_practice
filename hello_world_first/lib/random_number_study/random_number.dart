import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world_first/random_number_study/constant/color.dart';

class RandomNumberPage extends StatefulWidget {
  const RandomNumberPage({Key? key}) : super(key: key);

  @override
  State<RandomNumberPage> createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '랜덤함수 생성기',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: RED_COLOR,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: randomNumbers
                      .asMap()
                      .entries
                      .map((x) => Padding(
                            padding:
                                EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                            child: Row(
                                children: x.value
                                    .toString()
                                    .split('')
                                    .map((y) => Image.asset(
                                          'asset/img/random_number/$y.png',
                                          height: 70.0,
                                          width: 50.0,
                                        ))
                                    .toList()),
                          ))
                      .toList(),
                ),
              ),
              // 무한대값 double.infinity
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
                      onPressed: () {
                        final rand = Random();

                        final Set<int> newNumbers = {};

                        while(newNumbers.length != 3) {
                          final number = rand.nextInt(1000);

                          newNumbers.add(number);
                        }

                        setState(() {
                          randomNumbers = newNumbers.toList();
                        });
                      },
                      child: Text('생성하기!')))
            ],
          ),
        ),
      ),
    );
  }
}
