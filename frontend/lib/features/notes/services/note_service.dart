import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_endpoints.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/features/notes/models/note_model.dart';

class NoteService {
  final ApiService _apiService;

  NoteService(this._apiService);

  Future<NoteModel?>getLatestNote(int leadId)async{
    final response = await _apiService.get(
      path: "${ApiEndpoints.getLatestNote}/$leadId"
      );

      final List<dynamic> data=response.data["notes"];

      if(data.isEmpty){
        return null;
      }

      return NoteModel.fromJson(
        Map<String,dynamic>.from(data.first)
      );
  }
}