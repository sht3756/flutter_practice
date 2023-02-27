import 'package:animate_rive/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 280,
      width: 260,
      decoration: BoxDecoration(
        color: course.bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    course.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const Text(
                  "61 SECTIONS - 11 HOURS",
                  style: TextStyle(color: Colors.white54),
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    3,
                        (index) => Transform.translate(
                      offset: Offset((-5 * index).toDouble(), 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                            "assets/avaters/Avatar ${index + 1}.jpg"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}