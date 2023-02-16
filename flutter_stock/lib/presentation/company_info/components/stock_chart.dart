import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_stock/domain/model/intraday_info.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfo> infos;
  final Color color;
  final Color graphColor;
  final Color textColor;

  const StockChart({
    Key? key,
    required this.infos,
    required this.color,
    required this.graphColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 250,
      child: CustomPaint(
        painter: ChartPainter(infos, graphColor, textColor),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfo> infos;
  final Color graphColor;
  final Color textColor;

  // 가장 큰값:fold 함수로 전값 현재값 비교해서 높은거, ceil: 올림처리
  late int upperValue = infos.map((e) => e.close).fold<double>(0.0, max).ceil();

  // 첫번쨰 두번째데이터 비교해서 줄여나간다.소수점 버림
  late int lowerValue = infos.map((e) => e.close).reduce(min).toInt();

  // 간격
  final spacing = 50.0;

  late Paint strokePaint;

  // Paint() 는 메소드 안에있는것보다. 밖에 선언하면 성능이 더 좋다.
  ChartPainter(this.infos, this.graphColor, this.textColor) {
    strokePaint = Paint()
      ..color = graphColor
      // 그림그리는 스타일 stroke : 선
      ..style = PaintingStyle.stroke
      // 굵기
      ..strokeWidth = 3
      // 선 모양: 둥글게
      ..strokeCap = StrokeCap.round;
  }

  // 캔버스에 직접 그리는 코드
  @override
  void paint(Canvas canvas, Size size) {
    // 가격 위아래 간격: 얼마큼씩 떨어져있는지
    final priceStep = (upperValue - lowerValue) / 5.0;
    // 5개니깐 5번 반복
    // textSpan 여기서는 text 도 그린다.

    for (var i = 0; i < 5; i++) {
      //TextPainter 로 위치를 잡아준다.
      final tp = TextPainter(
        // 밑에서부터 그려 올라가는데, 제일 낮은 곳에서 한단계 사이만큼 올라간다.
        text: TextSpan(
          text: '${(lowerValue + priceStep * i).round()}',
          style: TextStyle(fontSize: 12, color: textColor),
        ),
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );
      // 레이아웃 위치 잡아주고
      tp.layout();
      // 그린다. offset : 어디에그릴지 좌표적는다.
      tp.paint(
          canvas, Offset(10, size.height - spacing - i * size.height / 5.0));
    }

    // 시간 좌우 간격
    final spacePerHour = (size.width - spacing) / infos.length;
    for (var i = 0; i < infos.length; i += 12) {
      final hour = infos[i].date.hour;

      final tp = TextPainter(
        text: TextSpan(
          text: '$hour',
          style: TextStyle(fontSize: 12, color: textColor),
        ),
        // textAlign, textDirection 은 없어도되지만, 나라별로 다르기떄문에!
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(i * spacePerHour + spacing, size.height + 20));
    }

    // 그림은 ㅖath() 를 사용해서 부드럽게 굴곡을 만들어 이으면 된다.
    var lastX = 0.0;
    final strokePath = Path();
    for (var i = 0; i < infos.length; i++) {
      // 각 인포 데이터를 얻는다.
      final info = infos[i];
      // 다음 인덱스
      var nextIndex = i + 1;
      // 만약에 다음인덱스가 마지막 인덱스보다 크다면, 마지막 인덱스로 하겠다. 더이상 넘어가지 않겠다. 예외처리
      if (i + 1 > infos.length - 1) nextIndex = infos.length - 1;
      // 다음 인포 정의
      final nextInfo = infos[nextIndex];
      // 비율 계산
      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio =
          (nextInfo.close - lowerValue) / (upperValue - lowerValue);

      // 앞의 좌표, 뒤의 자표를 구해서 이어줘야한다.
      // 앞 x좌표
      final x1 = spacing + i * spacePerHour;
      // 앞 y좌표
      final y1 = size.height - (leftRatio * size.height).toDouble();
      // 다음 x좌표
      final x2 = spacing + (i + 1) * spacePerHour;
      // 다음 y좌표
      final y2 = size.height - (rightRatio * size.height).toDouble();

      // 첫번째
      if (i == 0) {
        // path 를 처음에 이동을 시켜줘야한다.
        strokePath.moveTo(x1, y1);
      }
      // x값을 계속 이동시킨다.(앞 x 좌표와 다음 x 좌표의 중간)
      lastX = (x1 + x2) / 2.0;

      // quadraticBezierTo :곡선을 만들어줌
      strokePath.quadraticBezierTo(x1, y1, lastX, (y1 + y2) / 2.0);
    }

    // 배경 뒷부분 path 구하기 (그래프밑으로 배경 그리기위함) Path.from(strokePath) 기존 path 가져오기
    // lineTo path를 찾아서 라인을 그어버린다. spacing 만큼 위에서 그리기

    final fillPath = Path.from(strokePath)
      // 마지막 부분에서 밑으로 긋기
      ..lineTo(lastX, size.height - spacing)
      // 왼쪽으로 긋기
      ..lineTo(spacing, size.height - spacing)
      // 닫는건 계산 필요없음 닫으면됌
      ..close();

    // 색칠할 Paint()
    final fillPaint = Paint()
      ..color = graphColor
      // 스타일 fill 채우기
      ..style = PaintingStyle.fill
      //
      ..shader = ui.Gradient.linear(
        //Offset.zero : 좌표 0,0 (맨위 맨왼쪽)
        Offset.zero,
        Offset(0, size.height - spacing),
        [
          // 투명도 조절
          graphColor.withOpacity(0.5),
          // transparent : 투명색
          Colors.transparent,
        ],
      );

    // 그리기
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(strokePath, strokePaint);
  }

  // 언제 갱신되는지 규칙
  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    // 언제 다시그릴지(전상태와 현상태가 다를때)
    // 만약 return true 이면 계속 다시 그린다.
    return oldDelegate.infos != infos;
  }
}
