

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/Equipment.dart';

class AddArticlesController extends GetxController {
  var currentStep = 0.obs;

  File? _image;
  File? _image1;
  File? _image2;
  File? _image3;
  File? _image4;
  File? _image5;

  int? _choosedImage;
  RxBool inProcess = false.obs;
  List<MultipartFile> multipartImageList = <MultipartFile>[];

  Rx<File?> selectedFile = Rx<File?>(null);
  File? _selectedFile1;
  File? _selectedFile2;
  File? _selectedFile3;
  File? _selectedFile4;
  File? _selectedFile5;

  final _picker = ImagePicker();

  void _onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.camera);
    }
  }

  void _onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.gallery);
    }
  }


  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void _askPermissionCamera({num}) {
    requestPermission(Permission.camera).then(_onStatusRequestedCamera);
  }

  void _askPermissionStorage({num}) {
    requestPermission(Permission.storage).then(_onStatusRequested);
  }

  void _askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);

    void _onStatusRequestedCamera(status) {
      if (status != PermissionStatus.granted) {
        if (Platform.isIOS) {
          openAppSettings();
        } else {
          if (status == PermissionStatus.permanentlyDenied) {
            openAppSettings();
          }
        }
      } else {
        getImage(ImageSource.camera);
      }
    }
  }

  void getImage(ImageSource source) async {
    inProcess(true);
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }

    if (_image != null) {
      final cropped = await ImageCropper().cropImage(
          sourcePath: _image!.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 70,
          maxWidth: 500,
          maxHeight: 500,
          cropStyle: CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings : [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle: 'Cropper',
              statusBarColor: AppTheme.primaryColor,
              activeControlsWidgetColor: AppTheme.primaryColor,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              toolbarWidgetColor: AppTheme.redColor,
              backgroundColor: Colors.white,
            ),
            IOSUiSettings(
              title: 'Cropper',
            )
          ]
      );

        if (cropped != null) {
          switch (_choosedImage) {
            case null: // Enter this block if mark == 0
              if (selectedFile.value != null && selectedFile.value!.existsSync()) {
                selectedFile.value!.deleteSync();
              }
              selectedFile.value = File(cropped.path);
              break;
            case 1:
              _selectedFile1 = File(cropped.path);
              addMultiImages(_selectedFile1);
              _choosedImage = null;
              break;
            case 2:
              _selectedFile2 = File(cropped.path);
              addMultiImages(_selectedFile2);
              _choosedImage = null;
              break;
            case 3: // Enter this block if mark == 1 or mark == 2 or mark == 3
              _selectedFile3 = File(cropped.path);
              addMultiImages(_selectedFile3);
              _choosedImage = null;
              break;
            case 4: // Enter this block if mark == 1 or mark == 2 or mark == 3
              _selectedFile4 = File(cropped.path);
              addMultiImages(_selectedFile4);
              _choosedImage = null;
              break;
            case 5: // Enter this block if mark == 1 or mark == 2 or mark == 3
              _selectedFile5 = File(cropped.path);
              addMultiImages(_selectedFile5);
              _choosedImage = null;
              break;
            default:
              if (source.toString() == 'ImageSource.camera' &&
                  _image!.existsSync()) {
                _image!.deleteSync();
              }
              _image = null;
              inProcess(false);
              _choosedImage = null;
              break; // this is a good habit, in case you change default to something else later.
          }
        } else {
          inProcess(false);
        }
    }
  }

  Future addMultiImages(selectedFile) async{
    final String filename = selectedFile!.path.split('/').last;
    final img = await MultipartFile.fromFile(selectedFile!.path,
        filename: filename,
        contentType: MediaType('image', 'jpg'));
    return multipartImageList.add(img);
  }

  //---------- step 1 -------------//
  ImageSource? selectedImageSource;

  void pickImage(imageSource) async {

    switch (imageSource) {
      case 'camera':
        getImage(ImageSource.camera);
        break;
      case 'gallery':
        getImage(ImageSource.gallery);
        break;
      default:
        print('No image selected.');
    }

    final pickedFile = await ImagePicker().pickImage(source: selectedImageSource!);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }


  Rx<TextEditingController> brandController = TextEditingController().obs;
  Rx<TextEditingController> modelController = TextEditingController().obs;
  Rx<TextEditingController> typeController = TextEditingController().obs;
  Rx<TextEditingController> distanceController = TextEditingController().obs;
  Rx<TextEditingController> numberplateController = TextEditingController().obs;
  Rx<TextEditingController> fuelController = TextEditingController().obs;
  RxString yearController = ''.obs;
  // image picker
  Rx<File> selectedImage = File('').obs;

  final List<String> itemsKilometer = [
    '0-50 000 Km',
    '50-100 000 Km',
    '100 000-150 000 Km',
    '150 000-200 000 Km',
    '+200 000 Km',
  ];

  final List<Equipment> equipmentsList = [
    Equipment(1, 'Climatisation'),
    Equipment(2, 'Régulateur de vitesse'),
    Equipment(3, 'GPS'),
    Equipment(4, 'Siège enfant'),
    Equipment(5, 'bluetooth'),
    Equipment(6, 'Pneus Neige'),
    Equipment(7, 'Caméra de recule'),
    Equipment(8, 'Radio'),
  ];

  final List<int> placesList = [
    2,3,4,5,6,7,8,9
  ];

  final List<int> doorList = [
    2,3,4,5,6,7,
  ];

  final RxList<MultiSelectItem> items = <MultiSelectItem>[].obs;
  RxList<Equipment> selectedEquipments = <Equipment>[].obs;

  final RxString selectedKilometer = ''.obs;
  RxBool gearboxValue = true.obs; // manual = true, automatic = false
  RxInt selectedPlaces = 4.obs;
  RxInt selectedDoor = 5.obs;
  RxString selectedGearbox = ''.obs;
  // ---- step 1 -----------------//

  // ------------- step 2 ---------//
  final List<String> imagesList = [
    '3/4 Avant','Latéral','3/4 Arrière','Interieur','Suplémentaire'
  ];
  //-------------- step 2 --------------//

  // ------------- step 3 -------------//
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  // ------------- step 3 -------------//

  //---------- step 4 ----------------//
  final initialDate = DateTime.now().obs;
  final initialDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now()).obs;
  //------------Step 4 --------------//


  //----------Final step -----------//
  RxBool youngDriver = false.obs;
  Rx<TextEditingController> dayPriceController = TextEditingController(text: '30').obs;
  Rx<TextEditingController> weekPriceController = TextEditingController(text: '160').obs;
  Rx<TextEditingController> monthPriceController = TextEditingController(text: '400').obs;
  //----------Final step -----------//

  @override
  void onInit() {
    items.value = equipmentsList
        .map((data) => MultiSelectItem<Equipment>(data, data.name))
        .toList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (selectedFile.value != null && selectedFile.value!.existsSync()) {
      selectedFile.value!.deleteSync();
      selectedFile.value = null;
      _selectedFile1 = null;
      _selectedFile2 = null;
      _selectedFile3 = null;
      _selectedFile4 = null;
      _selectedFile5 = null;
    }else if(_selectedFile1 != null && _selectedFile1!.existsSync()){
      _selectedFile1!.deleteSync();

    }else if(_selectedFile2 != null && _selectedFile2!.existsSync()){
      _selectedFile2!.deleteSync();

    }else if(_selectedFile3 != null && _selectedFile3!.existsSync()){
      _selectedFile3!.deleteSync();

    }else if(_selectedFile4 != null && _selectedFile4!.existsSync()){
      _selectedFile4!.deleteSync();

    }else if(_selectedFile5 != null && _selectedFile5!.existsSync()){
      _selectedFile5!.deleteSync();
    }
    multipartImageList.clear();
    super.onClose();
  }
}