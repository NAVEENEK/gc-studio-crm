import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatefield extends StatelessWidget {
  final String label;
  final String? hint;
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(String?)? validator;
  
  const AppDatefield({
    required this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.validator,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today_outlined)
      ),
      controller: TextEditingController(
        text: value != null
        ?DateFormat('dd/MM/yyyy').format(value!)
        :''
      ),
      onTap: ()async{
        final selectedDate=await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(), 
          firstDate: DateTime(2000), 
          lastDate: DateTime(2100)
          );
          if(selectedDate != null){
            onChanged?.call(selectedDate);
          }
      },
    );
  }
}