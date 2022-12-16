import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHomeScreenPage extends StatefulWidget {
  const GoogleMapHomeScreenPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapHomeScreenPage> createState() =>
      _GoogleMapHomeScreenPageState();
}

class _GoogleMapHomeScreenPageState extends State<GoogleMapHomeScreenPage> {
  // latitude - 위도, longitude - 경도
  // 현재 위치를 저장하는 방법
  // 구글에서 제공하는 클래스 LatLng
  static final LatLng companyLatLng = LatLng(37.518820573402, 126.89986969097);

  // 줌 레벨
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Column(
        children: [
          _CustomGoogleMap(
            initialPosition: initialPosition,
          ),
          _AttendanceCheckButton(),
        ],
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '오늘도 출근',
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;

  const _CustomGoogleMap({Key? key, required this.initialPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        // 처음 실행시켰을때 기본 위치
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
      ),
    );
  }
}

class _AttendanceCheckButton extends StatelessWidget {
  const _AttendanceCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text('출근'));
  }
}
