import 'package:dio/dio.dart';
import 'package:dusty_study/component/card_title.dart';
import 'package:dusty_study/component/category_card.dart';
import 'package:dusty_study/component/hourly_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_card.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/component/main_stat.dart';
import 'package:dusty_study/constant/colors.dart';
import 'package:dusty_study/constant/data.dart';
import 'package:dusty_study/model/stat_model.dart';
import 'package:dusty_study/repository/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    final statModels = await StatRepository.fetchData();

    print(statModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                const SizedBox(height: 16.0),
                HourlyCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
