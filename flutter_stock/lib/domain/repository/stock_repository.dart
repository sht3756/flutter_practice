import 'package:flutter_stock/domain/model/company_listing.dart';
import 'package:flutter_stock/util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings({
    required bool fetchFromRemote,
    required String query,
  });
}
