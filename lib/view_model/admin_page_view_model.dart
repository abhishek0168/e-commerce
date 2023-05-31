import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminViewModel extends ChangeNotifier {
  List<XFile> images = [];

  chooseImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      images.add(pickImage);
    }

    notifyListeners();
  }
}
