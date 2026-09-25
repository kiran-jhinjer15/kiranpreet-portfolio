import 'package:flutter/material.dart';

class EducationItem {
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.dateOrStatus,
    this.isCurrent = false,
  });

  final String degree;
  final String institution;
  final String dateOrStatus;
  final bool isCurrent;
}

class LearningArea {
  const LearningArea({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

abstract final class EducationData {
  static const String eyebrow = 'EDUCATION';
  static const String heading = 'Academic background.';
  static const String description =
      'Formal study in computer applications, alongside professional work.';

  static const List<EducationItem> items = [
    EducationItem(
      degree: 'Master of Computer Applications (MCA)',
      institution: 'Lovely Professional University, Jalandhar',
      dateOrStatus: 'Currently Pursuing',
      isCurrent: true,
    ),
    EducationItem(
      degree: 'Bachelor of Computer Applications (BCA)',
      institution: 'Punjabi University, Patiala',
      dateOrStatus: 'May 2021',
    ),
    EducationItem(
      degree: 'Diploma in Computer Applications (DCA)',
      institution: 'SITS, Fatehgarh Sahib',
      dateOrStatus: '2021',
    ),
  ];

  static const String learningEyebrow = 'CURRENTLY LEARNING';
  static const String learningHeading =
      'Continuously improving my engineering depth.';
  static const String learningDescription =
      "I'm currently focusing on strengthening the areas that help me build more maintainable, scalable and production-ready Flutter applications.";
  static const String learningContext =
      'This builds on professional experience by deepening how I design, test, and ship Flutter applications.';
  static const String learningFocusLabel = 'Current focus areas';
  static const String learningFocusNote =
      'Active focus alongside professional work.';

  static const List<String> learningProgression = [
    'Learn',
    'Practice',
    'Build',
    'Improve',
  ];

  static const List<LearningArea> learningAreas = [
    LearningArea(label: 'Advanced Dart', icon: Icons.code),
    LearningArea(
      label: 'Flutter Architecture',
      icon: Icons.account_tree_outlined,
    ),
    LearningArea(
      label: 'Responsive Web Development',
      icon: Icons.devices_outlined,
    ),
    LearningArea(label: 'Performance Optimization', icon: Icons.speed_outlined),
    LearningArea(label: 'Testing', icon: Icons.science_outlined),
    LearningArea(
      label: 'Clean Code & Reusability',
      icon: Icons.layers_outlined,
    ),
    LearningArea(label: 'CI/CD', icon: Icons.sync_outlined),
    LearningArea(
      label: 'System Design for Mobile Applications',
      icon: Icons.hub_outlined,
    ),
  ];
}
