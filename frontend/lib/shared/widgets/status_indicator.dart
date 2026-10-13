import 'package:flutter/material.dart';
import 'package:frontend/core/theme/status_colors.dart';

class StatusIndicator extends StatelessWidget {
  final String status;
  final double dotSize;
  final double spacing;
  final TextStyle? textStyle;

  const StatusIndicator({
    required this.status,
    this.dotSize=10,
    this.spacing=8,
    this.textStyle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final Color StatusColor=StatusColors.getColor(status);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: StatusColor,
            shape: BoxShape.circle
          ),
        ),
        SizedBox(width: spacing,),
        Text(
          status,
          style: textStyle,
        )
      ],
    );
  }
}