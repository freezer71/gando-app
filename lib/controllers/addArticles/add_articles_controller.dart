import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/Equipment.dart';
import '../../navigation.dart';

class AddArticlesController extends GetxController {
  var currentStep = 0.obs;

  File? _image;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;

  RxInt choosedImage = 0.obs;
  RxBool inProcess = false.obs;
  List<MultipartFile> multipartImageList = <MultipartFile>[];

  Rx<File?> selectedFile = Rx<File?>(null);
  Rx<File?> selectedFile1 = Rx<File?>(null);
  Rx<File?> selectedFile2 = Rx<File?>(null);
  Rx<File?> selectedFile3 = Rx<File?>(null);
  Rx<File?> selectedFile4 = Rx<File?>(null);
  Rx<File?> selectedFile5 = Rx<File?>(null);

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

  void askPermissionCamera({num}) {
    requestPermission(Permission.camera).then(_onStatusRequestedCamera);
  }

  void askPermissionStorage({num}) {
    requestPermission(Permission.storage).then(_onStatusRequested);
  }

  void askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);

    void onStatusRequestedCamera(status) {
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
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle: 'Cropper',
              toolbarWidgetColor: AppTheme.darkColor,
              statusBarColor: AppTheme.primaryColor,
              activeControlsWidgetColor: AppTheme.primaryColor,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            IOSUiSettings(
              title: 'Cropper',
            )
          ]);

      if (cropped != null) {
        switch (choosedImage.value) {
          case 0:
            selectedFile1.value = File(cropped.path);
            addMultiImages(selectedFile1);
            choosedImage(0);
            update();
            break;
          case 1:
            selectedFile2.value = File(cropped.path);
            addMultiImages(selectedFile2);
            choosedImage(0);
            update();
            break;
          case 2: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile3.value = File(cropped.path);
            addMultiImages(selectedFile3);
            choosedImage(0);
            update();
            break;
          case 3: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile4.value = File(cropped.path);
            addMultiImages(selectedFile4);
            choosedImage(0);
            update();
            break;
          case 4: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile5.value = File(cropped.path);
            addMultiImages(selectedFile5);
            choosedImage(0);
            update();
            break;
          default:
            selectedFile.value = File(cropped.path);
            choosedImage(0);
            update();
            break; // this is a good habit, in case you change default to something else later.
        }
      } else {
        inProcess(false);
      }
    }
  }

  Future addMultiImages(selectedFile) async {
    final String filename = selectedFile!.path.split('/').last;
    final img = await MultipartFile.fromFile(selectedFile!.path,
        filename: filename, contentType: MediaType('image', 'jpg'));
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

    final pickedFile =
        await ImagePicker().pickImage(source: selectedImageSource!);

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
  Rx<TextEditingController> fuelController =
      TextEditingController(text: 'Essence').obs;
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

  final List<String> itemsFuel = [
    'Essence',
    'Diesel',
    'Hybride',
    'Electrique',
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

  final List<int> placesList = [2, 3, 4, 5, 6, 7, 8, 9];

  final List<int> doorList = [
    2,
    3,
    4,
    5,
    6,
    7,
  ];

  final RxList<MultiSelectItem> items = <MultiSelectItem>[].obs;
  RxList<Equipment> selectedEquipments = <Equipment>[].obs;

  final RxString selectedKilometer = ''.obs;
  final RxString selectedFuel = ''.obs;
  RxBool gearboxValue = true.obs; // manual = true, automatic = false
  RxInt selectedPlaces = 4.obs;
  RxInt selectedDoor = 5.obs;
  RxString selectedGearbox = ''.obs;
  // ---- step 1 -----------------//

  // ------------- step 2 ---------//
  final List<String> imagesList = [
    '3/4 Avant',
    'Latéral',
    '3/4 Arrière',
    'Interieur',
    'Suplémentaire'
  ];
  //-------------- step 2 --------------//

  // ------------- step 3 -------------//
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  final RxString selectedZipCode = ''.obs;
  final RxList<String> itemsZipCode = [
    "971",
    "97122",
    "97123",
    "97100",
    "97125",
    "97130",
    "97140",
    "97126",
    "97113",
    "97128",
    "97112",
    "97127",
    "97129",
    "97139",
    "97190",
    "97160",
    "97111",
    "97170",
    "97131",
    "97110",
    "97116",
    "97117",
    "97120",
    "97180",
    "97115",
    "97118",
    "97134",
    "97150",
    "97130",
    "97136",
    "97137",
    "97114",
    "97141",
    "973",
    "972",
    "974",
    "97425",
    "97412",
    "97413",
    "97414",
    "97427",
    "97420",
    "97419",
    "97440",
    "97470",
    "97400",
    "97438",
    "97439",
    "97441",
    "97434",
    "97480",
    "97436",
    "97450",
    "97460",
    "97442",
    "97410",
    "97433",
    "97430",
    "97426",
    "97437",
    "97216",
    "97218",
    "97222",
    "97222",
    "97221",
    "97224",
    "97250",
    "97200",
    "97240",
    "97218",
    "97213",
    "97232",
    "97214",
    "97218",
    "97225",
    "97290",
    "97260",
    "97226",
    "97250",
    "97211",
    "97215",
    "97231",
    "97227",
    "97228",
    "97230",
    "97270",
    "97212",
    "97250",
    "97280",
    "97229",
    "97223",
    "97220",
    "97213",
    "97233",
    "97317",
    "97319",
    "97330",
    "97300",
    "97340",
    "97350",
    "97310",
    "97355",
    "97360",
    "97370",
    "97351",
    "97356",
    "97314",
    "97316",
    "97390",
    "97354",
    "97311",
    "97312",
    "97313",
    "97320",
    "97370",
    "97315"
  ].obs;

  // ------------- step 3 -------------//

  //---------- step 4 ----------------//
  final initialDate = DateTime.now().obs;
  final initialDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  final dateRangePickerController1 = DateRangePickerController().obs;
  final dateRangePickerController2 = DateRangePickerController().obs;
  final RxList? selectedAvailability = [].obs;
  //------------Step 4 --------------//

  //----------Final step -----------//
  RxBool youngDriver = false.obs;
  Rx<TextEditingController> dayPriceController =
      TextEditingController(text: '30').obs;
  Rx<TextEditingController> weekPriceController =
      TextEditingController(text: '160').obs;
  Rx<TextEditingController> monthPriceController =
      TextEditingController(text: '400').obs;

  Future uploadData() async {
    // try/catch call service to upload data if success show success dialog and navigate to home page
    // if fail show error dialog
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.dialog(
        const AlertDialog(
          title: Text('Success'),
          content: Text('Your car has been added successfully'),
        ),
      );
      // Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.dialog(
        const AlertDialog(
          title: Text('Error'),
          content: Text('Something went wrong'),
        ),
      );
    }



  }

  //----------Final step -----------//

  @override
  void onInit() {
    super.onInit();
    items.value = equipmentsList
        .map((data) => MultiSelectItem<Equipment>(data, data.name))
        .toList();
  }

  @override
  void onClose() {
    if (selectedFile.value != null && selectedFile.value!.existsSync()) {
      selectedFile.value!.deleteSync();
      selectedFile.value = null;
      selectedFile1.value = null;
      selectedFile2.value = null;
      selectedFile3.value = null;
      selectedFile4.value = null;
      selectedFile5.value = null;
    } else if (selectedFile1 != null && selectedFile1.value!.existsSync()) {
      selectedFile1.value!.deleteSync();
    } else if (selectedFile2 != null && selectedFile2.value!.existsSync()) {
      selectedFile2.value!.deleteSync();
    } else if (selectedFile3 != null && selectedFile3.value!.existsSync()) {
      selectedFile3.value!.deleteSync();
    } else if (selectedFile4 != null && selectedFile4.value!.existsSync()) {
      selectedFile4.value!.deleteSync();
    } else if (selectedFile5 != null && selectedFile5.value!.existsSync()) {
      selectedFile5.value!.deleteSync();
    }
    multipartImageList.clear();
    // dispose all controllers
    brandController.value.dispose();
    modelController.value.dispose();
    typeController.value.dispose();
    distanceController.value.dispose();
    numberplateController.value.dispose();
    fuelController.value.dispose();
    yearController.value = '';
    descriptionController.value.dispose();
    addressController.value.dispose();
    cityController.value.dispose();
    postalCodeController.value.dispose();
    dayPriceController.value.dispose();
    weekPriceController.value.dispose();
    monthPriceController.value.dispose();
    super.onClose();
  }
}
