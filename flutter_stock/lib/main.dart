import 'package:flutter/material.dart';
import 'package:flutter_stock/data/repository/stock_repository_impl.dart';
import 'package:flutter_stock/data/source/local/stock_dao.dart';
import 'package:flutter_stock/data/source/remote/stock_api.dart';
import 'package:flutter_stock/domain/repository/stock_repository.dart';
import 'package:flutter_stock/presentation/company_listings/company_listings_view_model.dart';
import 'package:flutter_stock/util/color_schemes.g.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'data/source/local/company_listing_entity.dart';
import 'presentation/company_listings/company_listings_screen.dart';

void main() async {
  // Hive 초기화
  await Hive.initFlutter();
  // Hive 에 TypeAdapter 등록하기
  Hive.registerAdapter(CompanyListingEntityAdapter());
  final repository = StockRepositoryImpl(StockApi(), StockDao());

  GetIt.instance.registerSingleton<StockRepository>(repository);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CompanyListingsViewModel(
          StockRepositoryImpl(
            StockApi(),
            StockDao(),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const CompanyListingsScreen(),
    );
  }
}
