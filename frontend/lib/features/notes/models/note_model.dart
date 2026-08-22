
class NoteModel {
  final int noteId;
  final String? employeeId;
  final String? employeeName;
  final String? employeeStatus;
  final String  note;
  final DateTime date;

  const NoteModel({
    required this.noteId,
    this.employeeId,
    this.employeeName,
    this.employeeStatus,
    required this.note,
    required this.date
  });

  factory NoteModel.fromJson(Map<String,dynamic> json){
    return NoteModel(
      noteId: json["note_id"],
      employeeName: json["employee_name"], 
      employeeStatus: json["employee_status"],
      note: json["note"], 
      date: DateTime.parse(json["created_at"])
      );
  }

  Map<String,dynamic>toJson(){
    return{
      "note_id":noteId,
      "employee_id":employeeId,
      "note":note,
      "created_at":date.toIso8601String()
    };
  }

  NoteModel copyWith({
    int? noteId,
    String? employeeName,
    String? employeeStatus,
    String? note,
    DateTime? date
  }){
    return NoteModel(
      noteId: noteId ?? this.noteId, 
      employeeName: employeeName ?? this.employeeName,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      note: note ?? this.note, 
      date: date ?? this.date
      );
  }
}