import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/constant/app_icons.dart';
import '../../../routes/route_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),() => context.go(RoutePath.home));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(AppIcons.mainLogo)),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
