import 'package:flutter/material.dart';
import '../theme/ppt_typography.dart';

Widget sectionHeader(String sub, Color subColor, String title, String desc) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(width: 24, height: 3, color: subColor),
          const SizedBox(width: 8),
          Text(sub, style: PptTypography.subtitleSlide(color: subColor)),
        ],
      ),
      const SizedBox(height: 4),
      Text(title, style: PptTypography.titleSlide()),
      const SizedBox(height: 3),
      Text(desc, style: PptTypography.bodyMedium()),
    ],
  );
}

