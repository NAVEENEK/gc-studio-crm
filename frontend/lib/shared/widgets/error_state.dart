import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String title;
  final String errorMessage;

  const ErrorState({
    required this.title,
    required this.errorMessage,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 230,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.circular(20) 
    ),
    child:  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            color: Colors.redAccent,
            size: 48,
          ),
          const SizedBox(height: 12,),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
  }
