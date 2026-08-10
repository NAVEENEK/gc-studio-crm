import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/leads/models/lead_status_model.dart';
import 'package:frontend/features/leads/services/lead_service.dart';

class LeadStatusProvider extends ChangeNotifier{
  final LeadService _leadService;

  LeadStatusProvider(this._leadService);

  List<LeadStatusModel>_leadStatus=[];
  List<LeadStatusModel>get leadStatus=> _leadStatus;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

   String? _errorMessage ;
  String? get errorMessage => _errorMessage;

    Future<void> loadLeadStatusCount() async{
    try{
      _isLoading=true;
      _errorMessage=null;
      notifyListeners();

      _leadStatus=await _leadService.getLeadStatusCount();
    }on ApiException catch(e){
      _errorMessage=e.message;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }  
}