import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/shared/widgets/app_dateField.dart';
import 'package:frontend/shared/widgets/app_textField.dart';
import 'package:frontend/shared/widgets/common_appbar.dart';

import 'package:frontend/features/followups/providers/follow_up_provider.dart';

class AddFollowUps extends StatefulWidget {
  final int leadId;
  final String leadName;

  const AddFollowUps({
    super.key,
    required this.leadName,
    required this.leadId,
  });

  @override
  State<AddFollowUps> createState() => _AddFollowUpsState();
}

class _AddFollowUpsState extends State<AddFollowUps> {
  final _formKey = GlobalKey<FormState>();

  DateTime? followUpDate;

  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  // Submit follow-up
  Future<void> _submitFollowUp() async {
    // Validate notes
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate follow-up date
    if (followUpDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a follow-up date'),
        ),
      );
      return;
    }

    // Get notes
    final notes = notesController.text.trim();

    // Call Provider
    final success = await context.read<FollowUpProvider>().createFollowUp(
          leadId: widget.leadId,
          followUpDate: followUpDate!,
          notes: notes,
        );

    // Check whether widget is still mounted
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Follow-up created successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Return to previous screen
      Navigator.pop(context, true);
    } else {
      final errorMessage =
          context.read<FollowUpProvider>().errorMessage;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage ?? 'Failed to create follow-up',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            CommonAppbar(
              title: "Add Follow Up",
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Lead name
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lead",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.leadName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Follow-up date
                      AppDatefield(
                        label: "Follow-up Date",
                        hint: "Select follow-up date",
                        value: followUpDate,
                        onChanged: (date) {
                          setState(() {
                            followUpDate = date;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // Notes
                      AppTextfield(
                        label: "Notes",
                        hint: "Add follow-up notes",
                        controller: notesController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter notes";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Submit button
                      Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<FollowUpProvider>(
                          builder: (context, provider, child) {
                            return SizedBox(
                              height: 42,
                              child: ElevatedButton.icon(
                                onPressed: provider.isLoading
                                    ? null
                                    : _submitFollowUp,
                                icon: provider.isLoading
                                    ? const SizedBox(
                                        width: 17,
                                        height: 17,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.check,
                                        size: 17,
                                      ),
                                label: Text(
                                  provider.isLoading
                                      ? "Submitting..."
                                      : "Submit",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor:
                                      Colors.blue.shade400,
                                  disabledForegroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}