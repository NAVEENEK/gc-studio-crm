import 'package:flutter/material.dart';
import 'package:frontend/features/notes/provider/note_latest_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:provider/provider.dart';

class NotesCard extends StatefulWidget {
  final bool showAddButton;
  final int leadId;

  const NotesCard({required this.leadId, this.showAddButton = true, super.key});

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  @override
  void initState() {
    super.initState();
    context.read<NoteLatestProvider>().fetchLatestNote(widget.leadId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoteLatestProvider>();
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 167, 166, 166),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("+ Add"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //note content
            Expanded(child: _buildNoteContent(provider)
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("View All Notes ->"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNoteContent(NoteLatestProvider provider){
  if(provider.isLoading){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if(provider.errorMessage != null){
    return ErrorState(
      title: "Unable to load notes", 
      errorMessage: "Somethig Went wrong"
      );
  }
  if(provider.note == null){
    return EmptyState(
      title: "No Notes Yet", 
      message: "There is no notes for this lead yet.  "
      );
  }
  final note =provider.note!;

  return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 226, 243),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.employeeName ?? "Unknown",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                 Text(
                  note.date.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 45, 44, 44),
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                note.note,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



