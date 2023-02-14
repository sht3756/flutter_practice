import 'package:flutter_stock/data/mapper/company_mapper.dart';
import 'package:flutter_stock/data/source/local/stock_dao.dart';
import 'package:flutter_stock/data/source/remote/stock_api.dart';
import 'package:flutter_stock/domain/model/company_listing.dart';
import 'package:flutter_stock/domain/repository/stock_repository.dart';
import 'package:flutter_stock/util/result.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      {required bool fetchFromRemote, required String query}) async {
    // 캐시에서 찾기
    final localListings = await _dao.searchCompanyListing(query);

    // 없으면 리모트에서 가져오기
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시
    if (shouldJustLoadFromCache) {
      // 확장 메소드 사용 toCompanyListing()
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList());
    }

    // 리모트
    try {
      final remoteListings = await _api.getListings();
      // TODO: CSV 파싱 변환
      return const Result.success([]);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패!'));
    }
  }
}
