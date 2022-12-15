import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({Key? key, required this.video, required this.onNewVideoPressed}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  // 영상이 재생시간을 저장할 변수
  Duration currentPosition = Duration();
  bool showControls = false;

  @override
  void initState() {
    super.initState();

    // initState 함수는 initializeController 가 끝나기를 기다리진 않는다.
    initializeController();
  }

  // StatefulWidget 이 실행이 되었고, 파라미터값만 변경이 되었을때 didUpdateWidget 이 호출된다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  initializeController() async {
    // Duration() 으로 돌려놓는다.
    currentPosition = Duration();

    // 컨틀롤러 생성
    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    // 초기화
    await videoController!.initialize();

    // videoController 의 값이 변하면 실행이 된다.(position 이 바뀔때마다 매번!)
    videoController!.addListener(() async {
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });

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
        child: GestureDetector(
          onTap: (){
            setState(() {
              showControls = !showControls;
            });
          },
          child: Stack(
            children: [
              VideoPlayer(videoController!),
              if(showControls)
              _Controls(
                onPlayPressed: onPlayPressed,
                onReversePressed: onReversePressed,
                onForwardPressed: onForwardPressed,
                isPlaying: videoController!.value.isPlaying,
              ),
              if(showControls)
              _NewVideo(onPressed: widget.onNewVideoPressed),
              _SliderBottom(
                  currentPosition: currentPosition,
                  maxPosition: videoController!.value.duration,
                  onSliderChanged: onSliderChanged)
            ],
          ),
        ));
  }

  void onSliderChanged(double val) {
    videoController!.seekTo(
      Duration(
        seconds: val.toInt(),
      ),
    );
  }


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
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _SliderBottom(
      {Key? key,
      required this.currentPosition,
      required this.maxPosition,
      required this.onSliderChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, "0")}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, "0")}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
