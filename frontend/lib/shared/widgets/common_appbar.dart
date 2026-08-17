import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonAppbar extends StatelessWidget {
  final String title;
  final List<Widget>? action;
  final bool showBackButton;

  const CommonAppbar({
    super.key,
    required this.title,
    this.action,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30,24,30,20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: (){
                if(context.canPop()){
                  context.pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: 18),
                    SizedBox(width: 6),
                    Text("Back", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
      
          const SizedBox(width: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
      
          if (action != null) ...action!,
        ],
      ),
    );
  }
}
