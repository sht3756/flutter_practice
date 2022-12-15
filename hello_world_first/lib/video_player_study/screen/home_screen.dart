import 'package:flutter/material.dart';
import 'package:hello_world_first/video_player_study/component/custom_video_player.dart';
import 'package:image_picker/image_picker.dart';

class VideoHomeScreenPage extends StatefulWidget {
  const VideoHomeScreenPage({Key? key}) : super(key: key);

  @override
  State<VideoHomeScreenPage> createState() => _VideoHomeScreenPageState();
}

class _VideoHomeScreenPageState extends State<VideoHomeScreenPage> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: video == null ? renderEmpty() : renderVideo());
  }

  // 비디오 있을 때 뷰
  Widget renderVideo() {
    return CustomVideoPlayer(
      video: video!,
      onNewVideoPressed: onNewVideoPressed,
    );
  }

  // 비디오 없을 때 뷰
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          SizedBox(
            height: 30.0,
          ),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    // ImagePicker 를 통한 갤러리의 비디오 가져오기
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF2A3A7C),
        Color(0xFF000118),
      ],
    ));
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image(
        image: AssetImage("asset/img/logo.png"),
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 공통적인 textStyle 변수선언
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
              fontWeight: FontWeight.w700), // 공통 스타일과 다른 부분은 copyWith() 사용
        )
      ],
    );
  }
}
