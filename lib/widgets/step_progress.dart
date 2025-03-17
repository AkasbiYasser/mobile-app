import 'package:flutter/material.dart';
import '../models/prepaid_card_models.dart';

class StepProgress extends StatelessWidget {
  final List<StepData> steps;
  final int currentStep;

  const StepProgress({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Expanded(
                child: Container(
                  height: 2,
                  color: index < currentStep * 2 
                    ? Color(0xFFB4F700) 
                    : Colors.white24,
                ),
              );
            }
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;

            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent 
                  ? Color(0xFFB4F700) 
                  : Colors.white24,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted 
                  ? Icons.check 
                  : Icons.circle,
                color: isCompleted 
                  ? Color(0xFF002B20)
                  : isCurrent 
                    ? Color(0xFF002B20)
                    : Colors.white24,
                size: isCompleted ? 20 : 16,
              ),
            );
          }),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            final index = steps.indexOf(step);
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: Text(
                step.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isCompleted || isCurrent 
                    ? Colors.white 
                    : Colors.white38,
                  fontSize: 12,
                  fontWeight: isCurrent 
                    ? FontWeight.bold 
                    : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
