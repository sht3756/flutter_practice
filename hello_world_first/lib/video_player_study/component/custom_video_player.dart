import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;

  const CustomVideoPlayer({Key? key, required this.video}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  // 영상이 재생시간을 저장할 변수
  Duration currentPosition = Duration();

  @override
  void initState() {
    super.initState();

    // initState 함수는 initializeController 가 끝나기를 기다리진 않는다.
    initializeController();
  }

  initializeController() async {
    // 컨틀롤러 생성
    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    // 초기화
    await videoController!.initialize();

    // 비디오 컨트롤러생성했으니, 새로운 videoController 에 맞게  UI 를 새로 build 해라
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }
    return AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoController!),
            _Controls(
              onPlayPressed: onPlayPressed,
              onReversePressed: onReversePressed,
              onForwardPressed: onForwardPressed,
              isPlaying: videoController!.value.isPlaying,
            ),
            _NewVideo(onPressed: onNewVideoPressed),
            Slider(
              value: currentPosition.inSeconds.toDouble(),
              onChanged: (double val) {
                setState(() {
                  currentPosition = Duration(seconds: val.toInt());
                });
              },
              max: videoController!.value.duration.inSeconds.toDouble(),
              min: 0,
            )
          ],
        ));
  }

  void onNewVideoPressed() {}

  void onPlayPressed() {
    setState(() {
      if (videoController!.value.isPlaying) {
        // 실행중이면 중지
        videoController!.pause();
      } else {
        // 실행중 아니면 실행
        videoController!.play();
      }
    });
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); // 기본 0초로 세팅

    if (currentPosition.inSeconds > 3) {
      // 현재 시간 이 3 초보다 크면은 3초를 빼준다.
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 전체 영상의 길이

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      // 전체 시간 - 3 초 > 현재 초
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    Key? key,
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          renderIconButton(
              onPressed: onReversePressed, iconData: Icons.rotate_left),
          renderIconButton(
              onPressed: onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow),
          renderIconButton(
              onPressed: onForwardPressed, iconData: Icons.rotate_right),
        ],
      ),
    );
  }

  // 중복되는 아이콘 함수로 빼기
  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 30.0,
        color: Colors.white,
        icon: Icon(iconData));
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // 오른쪽에 0 픽셀만큼 위치시킨다.
      right: 0,
      child: IconButton(
          onPressed: onPressed,
          color: Colors.white,
          iconSize: 30.0,
          icon: Icon(
            Icons.photo_camera_back,
          )),
    );
  }
}
