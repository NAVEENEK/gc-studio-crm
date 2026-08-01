import 'package:flutter/foundation.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';
import 'package:frontend/features/followups/services/follow_up_service.dart';

class FollowUpProvider extends ChangeNotifier{
  final FollowUpService _followUpService;

  FollowUpProvider(this._followUpService);

  bool _isLoading=false;
  String? _errorMessage;
  List<FollowUpModel> _todayFollowUps=[];

  bool get isLoading=>_isLoading;
  String? get errorMessage=>_errorMessage;
  List<FollowUpModel> get todayFollowUps=>_todayFollowUps;

  Future<void> loadTodayFollowUps() async{
    _isLoading=true;
    _errorMessage=null;
    _todayFollowUps=[];
    notifyListeners();

    try{
      _todayFollowUps=await _followUpService.fetchTodayFollowUps();
    }on ApiException catch(e){
      _errorMessage=e.message;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}