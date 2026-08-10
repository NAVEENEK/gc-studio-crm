import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/leads/models/lead_model.dart';
import 'package:frontend/features/leads/services/lead_service.dart';

class LeadProvider extends ChangeNotifier{
  final LeadService _leadService;

  LeadProvider(this._leadService);
  
  bool _isLoading=false;
  bool get isLoading => _isLoading;

  String? _errorMessage ;
  String? get errorMessage => _errorMessage;

  List<LeadModel> _myLeads=[];
  List<LeadModel> get myLeads=>_myLeads;

  String _searchText="";
  String get searchText=> _searchText;

  String? _selectedStatus;
  String? get selectedStatus=>_selectedStatus; 

  Future<void>loadMyLeads({
    String? search,
    String? status
  })async{
    _searchText=search ?? _searchText;
    _selectedStatus= status ?? _selectedStatus;
    try{
      _isLoading=true;
      _errorMessage=null;
      notifyListeners();

      _myLeads=await _leadService.getMyLeads(
        status: _selectedStatus,
        leadName: _searchText.isEmpty ? null :searchText
      );
    }on ApiException catch(e){
      _errorMessage=e.message;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}