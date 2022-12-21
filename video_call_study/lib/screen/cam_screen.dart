import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dss'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          // 에러일때
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // 맨처음, 데이터가 없을때
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text('권한이 있습니다.'),
          );
        }
      ),
    );
  }

  Future<bool> init() async {
    final response = await [Permission.camera, Permission.microphone].request();
    final cameraPermission = response[Permission.camera];
    final micPermission = response[Permission.microphone];

    if(cameraPermission != PermissionStatus.granted ||
     micPermission != PermissionStatus.granted){
      throw '카메라 또는 마이크 권한이 없습니다.';

    }
    return true;
  }
}
