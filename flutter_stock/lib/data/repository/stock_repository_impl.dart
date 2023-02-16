import 'package:flutter_stock/data/csv/company_listing_parsers.dart';
import 'package:flutter_stock/data/mapper/company_mapper.dart';
import 'package:flutter_stock/data/source/local/stock_dao.dart';
import 'package:flutter_stock/data/source/remote/stock_api.dart';
import 'package:flutter_stock/domain/model/company_info.dart';
import 'package:flutter_stock/domain/model/company_listing.dart';
import 'package:flutter_stock/domain/repository/stock_repository.dart';
import 'package:flutter_stock/util/result.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _parser = CompanyListingsParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      {required bool fetchFromRemote, required String query}) async {
    final localListings = await _dao.searchCompanyListing(query);

    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    if (shouldJustLoadFromCache) {
      // 확장 메소드 사용 toCompanyListing()
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList());
    }

    try {
      final res = await _api.getListings();
      final remoteListings = await _parser.parse(res.body);

      await _dao.clearCompanyListings();
      await _dao.insertCompanyListings(
          remoteListings.map((e) => e.toCompanyListingEntity()).toList());

      return Result.success(remoteListings);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패!'));
    }
  }

  @override
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(symbol: symbol);
      return Result.success(dto.toCompanyInfo());
    } catch (e) {
      return Result.error(Exception('회사 정보 로드 실패!! : ${e.toString()}'));
    }
  }
}
