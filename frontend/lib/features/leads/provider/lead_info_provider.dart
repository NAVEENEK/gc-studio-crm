import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/leads/models/lead_model.dart';
import 'package:frontend/features/leads/services/lead_service.dart';

class LeadInfoProvider extends ChangeNotifier {
  final LeadService _leadService;

  LeadInfoProvider(this._leadService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LeadModel? _lead;
  LeadModel? get lead => _lead;

  Future<void> fetchLeadById(int leadId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _lead = await _leadService.getLeadById(leadId);
    } on ApiException catch (e) {
      _errorMessage=e.message;
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}
