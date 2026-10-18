import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/features/notes/models/note_model.dart';
import 'package:frontend/features/notes/services/note_service.dart';

class NoteProvider extends ChangeNotifier{
  final NoteService _noteService;

  NoteProvider(this._noteService);

  bool _isLoading=false;
  bool get isLoading  => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  NoteModel? _note;
  NoteModel? get note => _note;

  Future<void> fetchLatestNote(int leadId)async{
    try{
      _isLoading=true;
      _errorMessage=null;
      notifyListeners();

      _note=await _noteService.getLatestNote(leadId);
    }on ApiException catch(e){
      debugPrint("NOTE API ERROR: ${e.message}");
      _errorMessage=e.message;
    }catch(e,stackTrace){
      debugPrint("Unknown Error: $e");
      debugPrint("stack trace: $stackTrace");
      _errorMessage="Somethig went wrong";
    }finally {
      _isLoading=false;
      notifyListeners();
    }
  }

  Future<bool>createNotes({
    required int leadId,
    required String notes
  })async{
    try{
      _isLoading=true;
      _errorMessage=null;
      notifyListeners();

      await _noteService.createNotes(
        leadId: leadId, 
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