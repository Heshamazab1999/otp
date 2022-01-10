import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp/models/product_model.dart';
import 'package:otp/services/category_services.dart';

class CategoryController extends GetxController {
  final models = <CategoryModel>[].obs;
  final services = CategoryServices();
  final label = ''.obs;
  final image = ''.obs;
  final _picker = ImagePicker();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    models.assignAll(await services.getCategory());
  }

  Stream<List<CategoryModel>> getStream() {
    return services.getStreamData();
  }

  sendData() async {
    await services.addNewCategory(
        CategoryModel(name: label.value, image: image.value),
        image.value,
        image.value.toString());
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
}
