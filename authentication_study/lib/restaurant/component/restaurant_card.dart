import 'package:authentication_study/common/const/colors.dart';
import 'package:authentication_study/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지 (통째로 위젯으로)
  final Widget image;

  // 레스토랑 이름
  final String name;

  // 레스토랑 태그
  final List<String> tags;

  // 평점 개수
  final int ratingsCount;

  // 배송 시간
  final int deliveryTime;

  // 배송 요금
  final int deliveryFee;

  // 평균 평점
  final double ratings;

  // 상세페이지 여부
  final bool isDetail;

  // 상세 내용
  final String? detail;

  // hero 위젯 태그
  final String? heroKey;

  const RestaurantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
    this.heroKey,
  }) : super(key: key);

  // factory constructor 생성, 생성가능한 이유? RestaurantCard 도 클래스이기 때문이다!
  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
      heroKey: model.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (heroKey != null)
          // Hero 위젯 : 화면 전환 될떄 이미지가 그대로 넘어오는 듯한 애니메이션 전환 위젯,
          // tag 값이 같은 것들이 연결을 시킬 수 있다.
          Hero(
            tag: ObjectKey(heroKey),
            child: ClipRRect(
              // 디테일 페이지면 border 0, 리스트 페이지면 border 12
              borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
              child: image,
            ),
          ),
        if (heroKey == null)
          ClipRRect(
            // 디테일 페이지면 border 0, 리스트 페이지면 border 12
            borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
            child: image,
          ),
        const SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                tags.join('·'),
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  _IconText(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timelapse_outlined,
                    label: '$deliveryTime 분',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                  ),
                ],
              ),
              // 디테일 있고 isDetail true 일때
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                ),
            ],
          ),
        )
      ],
    );
  }

  // . 찍기
  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
