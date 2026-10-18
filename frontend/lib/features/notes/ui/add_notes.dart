import 'package:flutter/material.dart';
import 'package:frontend/features/notes/provider/note_provider.dart';
import 'package:frontend/shared/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  final leadId;
  const AddNote({super.key, required this.leadId});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _noteController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitNote() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String note = _noteController.text.trim();

    //call provider
    final success = await context.read<NoteProvider>().createNotes(
      leadId: widget.leadId,
      notes: note,
    );

    //check whether widget is still mounted
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note submitted successfully'),
          backgroundColor: Colors.green,
        ),
      );

      //return to previous screen
      Navigator.pop(context, true);
    } else {
      final errorMessage = context.read<NoteProvider>().errorMessage;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Failed to create note'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: 20),
                    SizedBox(width: 10),
                    Text('Back', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Heading
              const Text(
                'Add Note',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C24),
                ),
              ),

              const SizedBox(height: 56),

              // Notes input using your existing AppTextfield
              Expanded(
                child: Form(
                  key: _formKey,
                  child: AppTextfield(
                    label: '',
                    hint: 'Write your note...',
                    controller: _noteController,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a note';
                      }

                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // Submit button
              Align(
                alignment: Alignment.centerRight,
                child: Consumer<NoteProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      height: 42,
                      child: ElevatedButton.icon(
                        onPressed: provider.isLoading ? null : _submitNote,
                        icon: provider.isLoading
                            ? const SizedBox(
                                width: 17,
                                height: 17,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.check, size: 17),
                        label: Text(
                          provider.isLoading ? "Submitting..." : "Submit",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.blue.shade400,
                          disabledForegroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
