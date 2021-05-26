
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class FilePickerDemo {
  List<PlatformFile> _files;
  FileType _pickingType = FileType.any;
  bool _multiPick = false;
  String _extension;

  @override

  Future<List<PlatformFile>> openFileExplorer() async {
    try {
      _files = (await FilePicker.platform.pickFiles(
                type: _pickingType,
                allowMultiple: _multiPick,
                allowedExtensions: (_extension?.isNotEmpty ?? false)
                    ? _extension?.replaceAll(' ', '').split(',')
                    : null,
              ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    //if (!mounted) return null;
    return _files;
  }
}
