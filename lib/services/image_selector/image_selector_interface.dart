abstract class ImageSelectorInterface {
  Future<String> imgFromCamera();
  Future<String> imgFromGallery();
}
