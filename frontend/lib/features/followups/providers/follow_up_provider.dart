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
  List<FollowUpModel> _leadFollowUps=[];
  String _searchText = "";
  String? _selectedStatus;
  String? _selectedFilter;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<FollowUpModel> get todayFollowUps => _todayFollowUps;
  List<FollowUpModel> get myFollowUps => _myFollowUps;
  List<FollowUpModel> get leadFollowUps=>
  _leadFollowUps;
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
    if (search != null) _searchText = search;

    if (filter != null) {
      _selectedFilter = filter.isEmpty ? null : filter;
    }
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
    _myFollowUps=[];
    notifyListeners();
    await loadMyFollowUps();
  }

  Future<void> loadFollowUpsById(int leadId)async{
    print("leadId:$leadId");
    try{
      _isLoading=true;
      _errorMessage=null;
      _leadFollowUps=[];
      notifyListeners();

      _leadFollowUps=await _followUpService.fetchFollowUpsById(leadId);
    }on ApiException catch(e){
      _errorMessage=e.message;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future<bool> createFollowUp({
    required int leadId,
    required DateTime followUpDate,
    required String notes
  })async{
    try{
      _isLoading=true;
      _errorMessage=null;
      notifyListeners();

      await _followUpService.createFollowUp(
        leadId: leadId, 
        followUpDate: followUpDate, 
        notes: notes
        );
        return true;
    }on ApiException catch(e){
      _errorMessage=e.message;
      return false;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}
