import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/app_textField.dart';
import 'package:frontend/shared/widgets/common_appbar.dart';

class AddLeads extends StatefulWidget {
  const AddLeads({super.key});

  @override
  State<AddLeads> createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CommonAppbar(title: "Create Lead"),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child:Column(
                    children: [
                      Text(
                        "Enter lead information ",
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ) ,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppTextfield(
                            label: "Lead Name",
                            hint: "Enter lead name",
                            ),
                            AppTextfield(
                            label: "Interested Service",
                            hint: "Enter Interested service",
                            ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppTextfield(
                            label: "phone Number",
                            hint: "Enter phone number",
                            ),
                            AppTextfield(
                            label: "Email",
                            hint: "Enter email",
                            ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        
                        ],
                      ),

                    ],

                  ) ,

                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
