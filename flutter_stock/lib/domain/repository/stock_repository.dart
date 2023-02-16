import 'package:flutter_stock/domain/model/company_info.dart';
import 'package:flutter_stock/domain/model/company_listing.dart';
import 'package:flutter_stock/domain/model/intraday_info.dart';
import 'package:flutter_stock/util/result.dart';

abstract class StockRepository {
  // 회사 리스트
  Future<Result<List<CompanyListing>>> getCompanyListings({
    required bool fetchFromRemote,
    required String query,
  });

  // 회사정보
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol);

  // 하루동안 정보
  Future<Result<List<IntradayInfo>>> getIntradayInfo(String symbol);
}
