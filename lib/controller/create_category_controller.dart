import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp/models/category_model.dart';
import 'package:otp/models/product_model.dart';
import 'package:otp/services/create_category_services.dart';

class CreateCategoryController extends GetxController {
  final services = CreateCategoryServices();
  final label = ''.obs;
  final controller = TextEditingController();
  final image = ''.obs;
  final _picker = ImagePicker();
  final product = ''.obs;
  final value = 'A'.obs;
  final key = ''.obs;

  create() async {
    await services.createCategory(CreateModel(name: label.value));
  }

  Stream<List<CreateModel>> getCategories() {
    return services.getCategorys();
  }

  selectImage() async {
    try {
      final XFile? _image =
          await _picker.pickImage(source: ImageSource.gallery);

      if (_image != null) image.value = _image.path;
    } catch (e) {
      print(e.toString());
    }
  }

  sendData() async {
    await services.addNewProduct(
        CategoryModel(name: product.value, image: image.value),
        image.value,
        image.value.toString(),
        key.value);
  }
}
