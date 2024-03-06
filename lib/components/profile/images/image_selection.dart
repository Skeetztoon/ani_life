import 'package:image_picker/image_picker.dart';

 pickImage(ImageSource source) async {
  final _resultImage = await ImagePicker().pickImage(source: source);
  if (_resultImage!=null) {
    return await _resultImage.readAsBytes();
  }
}