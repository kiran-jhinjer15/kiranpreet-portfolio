abstract final class ProjectAssets {
  static const String root = 'assets/projects';

  static const Map<String, String> foldersByProjectId = {
    'daawat': 'daawat',
    'viewghana': 'viewghana',
    'bumper-buds': 'bumper_buds',
    'age-calculator-pro': 'age_calculator',
    'siesta-travel': 'siesta_travel',
    'abmg': 'abmg',
    'night-light': 'night_light',
    'viewghana-vendor': 'viewghana_vendor',
  };

  static String directoryFor(String projectId) {
    final folder = foldersByProjectId[projectId];
    return '$root/${folder ?? projectId}';
  }
}
