import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHomeScreenPage extends StatefulWidget {
  const GoogleMapHomeScreenPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapHomeScreenPage> createState() =>
      _GoogleMapHomeScreenPageState();
}

class _GoogleMapHomeScreenPageState extends State<GoogleMapHomeScreenPage> {
  // 현재 위치를 저장하는 방법
  // latitude - 위도, longitude - 경도
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
      body: FutureBuilder(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text('데이터가 null 이다.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return Column(
              children: [
                _CustomGoogleMap(
                  initialPosition: initialPosition,
                ),
                _AttendanceCheckButton(),
              ],
            );
          }
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  Future<String> checkPermission() async {
    // 로케이션 서비스(위치 여부)가 활성화 되어있는지 나타내는 함수, 비동기로 boolean 값 리턴
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    // LocationPermission : enum(열거형)
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    // 만약 권한을 리턴받아 저장한 값이 == denied 라면?
    if (checkedPermission == LocationPermission.denied) {
      // 다시 요청해서 변수에 저장을 하고,
      checkedPermission = await Geolocator.requestPermission();
      // 저장을 한 후에도 변수의 값이 denied 라면 리턴문 출력
      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    // 리턴 받은 값 == deniedForever 이라면? 사용자가 직접 세팅에서 설정해야한다.
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다.';
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
