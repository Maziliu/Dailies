import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section.dart';
import 'package:file_picker/file_picker.dart';

class ConfigurationSectionViewModel {
  Map<String, Map<String, dynamic>> _configurations = {};

  void updateConfigurations(PlatformFile file, Map<String, dynamic> fieldValues) {
    final Map<String, dynamic> cleaned = {};

    cleaned['allowCondense'] = fieldValues[CONDENSE_FIELD_TAG] ?? false;
    cleaned['instructions'] = fieldValues[INSTRUCTIONS_FIELD_TAG] ?? '';
    cleaned['path'] = file.path;
    cleaned['extension'] = file.extension;

    _configurations[file.name] = cleaned;
  }

  void clearConfigurations() => _configurations = {};

  Map<String, Map<String, dynamic>> get configurations => _configurations;

  void removeConfiguration(PlatformFile file) => _configurations.remove(file.name);
}
