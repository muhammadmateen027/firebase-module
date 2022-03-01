import 'package:assignment/services/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector implements ImageSelectorInterface {
  final _imagePicker = ImagePicker();

  @override
  Future<String> imgFromCamera() {
    return _getImage(ImageSource.camera);
  }


  @override
  Future<String> imgFromGallery() {
    return _getImage(ImageSource.gallery);
  }

  Future<String> _getImage(ImageSource source) async {
    final image =
    await _imagePicker.pickImage(source: source, imageQuality: 50);

    return image != null ? image.path : '';
  }
}
