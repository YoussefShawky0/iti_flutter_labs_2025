import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/quiz_result.dart';

class QuestionCard extends StatelessWidget {
  final QuestionResult questionResult;
  final int questionNumber;

  const QuestionCard({
    super.key,
    required this.questionResult,
    required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس السؤال
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '$questionNumber',
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getStatusText(),
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(),
                    ),
                  ),
                ),
                Icon(_getStatusIcon(), color: _getStatusColor(), size: 24),
              ],
            ),

            const SizedBox(height: 16),

            // السؤال
            Text(
              questionResult.question,
              style: GoogleFonts.amiri(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            // الخيارات
            ...questionResult.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isCorrect = index == questionResult.correctAnswerIndex;
              final isSelected = index == questionResult.selectedAnswerIndex;
              final optionLabels = ['أ', 'ب', 'ج', 'د'];

              Color backgroundColor = Colors.grey[50]!;
              Color borderColor = Colors.grey[300]!;
              Color textColor = Colors.grey[800]!;

              if (isCorrect) {
                backgroundColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                textColor = Colors.green[800]!;
              } else if (isSelected && !isCorrect) {
                backgroundColor = Colors.red[50]!;
                borderColor = Colors.red[400]!;
                textColor = Colors.red[800]!;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? Colors.green[600]
                            : isSelected
                            ? Colors.red[600]
                            : Colors.grey[400],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          optionLabels[index],
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                    if (isCorrect)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    if (isSelected && !isCorrect)
                      const Icon(Icons.cancel, color: Colors.red, size: 20),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (questionResult.isSkipped) {
      return Colors.orange[600]!;
    } else if (questionResult.isCorrect) {
      return Colors.green[600]!;
    } else {
      return Colors.red[600]!;
    }
  }

  String _getStatusText() {
    if (questionResult.isSkipped) {
      return 'تم التخطي';
    } else if (questionResult.isCorrect) {
      return 'إجابة صحيحة';
    } else {
      return 'إجابة خاطئة';
    }
  }

  IconData _getStatusIcon() {
    if (questionResult.isSkipped) {
      return Icons.skip_next;
    } else if (questionResult.isCorrect) {
      return Icons.check_circle;
    } else {
      return Icons.cancel;
    }
  }
}

class ProgressCircle extends StatelessWidget {
  final double percentage;
  final Color color;
  final String label;
  final String value;

  const ProgressCircle({
    super.key,
    required this.percentage,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            children: [
              // الدائرة الخلفية
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
              ),
              // دائرة التقدم
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 6,
                    backgroundColor: color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
              // النص في المنتصف
              Center(
                child: Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
