import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/build_dropdown.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          //search field
          TextFormField(
            decoration: InputDecoration(
              hintText: "Search by name",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [Expanded(child: BuildDropdown(label: "Lead Status", hint: "All Status", 
          items: const [
          DropdownMenuItem(value: "new", child: Text("New")),
          DropdownMenuItem(value: "assigned", child: Text("Assigned")),
          DropdownMenuItem(value: "contacted", child: Text("Contacted")),
          DropdownMenuItem(value: "qualified", child: Text("Qualified")),
          DropdownMenuItem(
            value: "praposal send",
            child: Text("Praposal send"),
          ),
          DropdownMenuItem(value: "negotiation", child: Text("Negotiation")),
          DropdownMenuItem(value: "won", child: Text("Won")),
          DropdownMenuItem(value: "lost", child: Text("Lost")),
        ],
          )
          ),

          const SizedBox(width: 16,),

          Expanded(
            child: BuildDropdown(
              label: "Follow-up Status", 
              hint: "All status", 
              items: const[
                DropdownMenuItem(
                  value: "pending",
                  child: Text("Pending")
                  ),
                  DropdownMenuItem(
                  value: "completed",
                  child: Text("Completed")
                  ),
                  DropdownMenuItem(
                  value: "cancelled",
                  child: Text("Cancelled")
                  ),
              ]
              )
            ),

            const SizedBox( width: 16,),

            SizedBox(
              height: 56,
              child: OutlinedButton.icon(
                onPressed: (){}, 
                label: const Text("Filter"),
                icon: const Icon(Icons.filter_alt_off_outlined),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  side: BorderSide(
                    color: Colors.grey.shade300
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(14)
                  )
                ),
                ),
                
            )
          ]
          ),
        ],
      ),
    );
  }
}

