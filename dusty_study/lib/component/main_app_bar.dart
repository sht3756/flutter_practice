import 'package:dusty_study/model/stat_model.dart';
import 'package:dusty_study/model/status_model.dart';
import 'package:dusty_study/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class MainAppBar extends StatelessWidget {
  // 데이터 모델링 클래스를 기반으로 단계를 나누는 값 정의한 모델
  final StatusModel status;

  // 실제 api 통신하고 플러터로 사용하기 쉽게 만든 데이터 모델링 클래스
  final StatModel stat;

  const MainAppBar({
    Key? key,
    required this.status,
    required this.stat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      expandedHeight: 500,
      backgroundColor: status.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            // kToolbarHeight: 시스템적으로 기본적인 정해진 AppBar 높이를 사용할 수 있다.
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20.0),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
