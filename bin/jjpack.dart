import 'dart:io';
import 'package:archive/archive_io.dart';

class Config {
  static const String _defaultExt = 'dwg';
  static const bool _defaultDelete = true;
  String ext = _defaultExt;
  bool delete = _defaultDelete;
  Config._({this.ext = _defaultExt, this.delete = _defaultDelete});
  Config.fromCli(final List<String> arguments) {
    if (arguments.length == 1) {
      if (arguments[0] == 'nodelete') {
        ext = _defaultExt;
        delete = false;
      } else {
        ext = arguments[0];
        delete = _defaultDelete;
      }
    } else if (arguments.length == 2) {
      ext = arguments[0];
      delete = _defaultDelete;
      if (arguments[1] == 'nodelete') {
        delete = false;
      }
    } else {
      Config._();
    }
  }
  String get fullExt => '.$ext';
}

bool _compress(final File file, final Config config) {
  try {
    final zippedPath = file.path.replaceFirst(
        config.fullExt, '.zip', (file.path.length - config.fullExt.length));
    final encoder = ZipFileEncoder();
    encoder.create(zippedPath, level: 5);
    encoder.addFile(file);
    encoder.close();
    return true;
  } catch (e) {
    print('ERROR COMPRESSING: ${file.path}: ${e.toString()}');
    return false;
  }
}

bool _delete(final File file) {
  try {
    file.deleteSync();
    return true;
  } catch (e) {
    print('ERROR DELETING: ${file.path}: ${e.toString()}');
    return false;
  }
}

void main(List<String> arguments) async {
  final config = Config.fromCli(arguments);

  int processed = 0, zipped = 0, deleted = 0;

  await for (final entity
      in Directory.current.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith(config.fullExt)) {
      processed++;

      if (_compress(entity, config)) {
        zipped++;
      }

      if (config.delete && _delete(entity)) {
        deleted++;
      }
    }
  }

  print('=========');
  print('Processed $processed files with \'${config.ext}\' extension.');
  if (processed > 0) {
    print('Zipped $zipped files.');
    print('Deleted $deleted files.');
  }
}
