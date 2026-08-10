import 'package:flutter/foundation.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';
import 'package:frontend/features/followups/services/follow_up_service.dart';

class FollowUpProvider extends ChangeNotifier {
  final FollowUpService _followUpService;

  FollowUpProvider(this._followUpService);

  bool _isLoading = false;
  String? _errorMessage;
  List<FollowUpModel> _todayFollowUps = [];
  List<FollowUpModel> _myFollowUps = [];
  String _searchText = "";
  String? _selectedStatus;
  String? _selectedFilter;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<FollowUpModel> get todayFollowUps => _todayFollowUps;
  List<FollowUpModel> get myFollowUps => _myFollowUps;
  String get searchText => _searchText;
  String? get selectedStatus => _selectedStatus;
  String? get selectedFilter => _selectedFilter;

  Future<void> loadTodayFollowUps() async {
    _isLoading = true;
    _errorMessage = null;
    _todayFollowUps = [];
    notifyListeners();

    try {
      _todayFollowUps = await _followUpService.fetchTodayFollowUps();
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMyFollowUps({
    String? status,
    String? search,
    String? filter,
  }) async {
    if (status != null) {
      _selectedStatus = status.isEmpty ? null : status;
    }
    ;
    if (search != null) _searchText = search;

    if (filter != null) {
      _selectedFilter = filter.isEmpty ? null : filter;
    }
    ;
    try {
      _isLoading = true;
      _errorMessage = null;
      _myFollowUps = [];
      notifyListeners();

      _myFollowUps = await _followUpService.fetchMyFollowUps(
        status: _selectedStatus,
        leadName: _searchText,
        filter: _selectedFilter,
      );
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearFilters() async {
    _selectedFilter = null;
    _selectedStatus = null;
    _searchText = "";
  }
}
