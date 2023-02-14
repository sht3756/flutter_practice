import 'package:flutter/material.dart';
import 'package:flutter_stock/domain/repository/stock_repository.dart';
import 'package:flutter_stock/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyListingsState();

  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  Future _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getCompanyListings(
        fetchFromRemote: fetchFromRemote, query: query);
    result.when(success: (listings) {
      _state = state.copyWith(
        companies: listings,
      );
    }, error: (e) {
      print('리모트 에러 : ' + e.toString());
    });

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }
}
