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
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    if(videoController == null){
      return CircularProgressIndicator();
    }
    return VideoPlayer(videoController!);
  }
}
