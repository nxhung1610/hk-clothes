
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateInfoController extends GetxController with SingleGetTickerProviderMixin{
  static UpdateInfoController instance = Get.find();
  var  selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async{

   final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
   if(pickedFile != null)
     {
       selectedImagePath.value=pickedFile.path;
     }
   else
     Get.snackbar("Error", "No image selected", snackPosition: SnackPosition.BOTTOM);
   }




}