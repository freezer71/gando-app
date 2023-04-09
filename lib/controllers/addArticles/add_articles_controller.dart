import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/car/car_brand_controller.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/Equipment.dart';
import '../../models/CarBrandModel.dart';
import '../../navigation.dart';

class AddArticlesController extends GetxController {

  File? _image;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;

  RxInt choosedImage = 0.obs;
  RxInt currentStep = 0.obs;
  RxBool inProcess = false.obs;
  RxBool isLoading = false.obs;
  RxBool terms = false.obs;
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
            // addMultiImages(selectedFile1);
            choosedImage(0);
            // update();
            break;
          case 1:
            selectedFile2.value = File(cropped.path);
            // addMultiImages(selectedFile2);
            choosedImage(0);
            // update();
            break;
          case 2: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile3.value = File(cropped.path);
            // addMultiImages(selectedFile3);
            choosedImage(0);
            // update();
            break;
          case 3: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile4.value = File(cropped.path);
            // addMultiImages(selectedFile4);
            choosedImage(0);
            // update();
            break;
          case 4: // Enter this block if mark == 1 or mark == 2 or mark == 3
            selectedFile5.value = File(cropped.path);
            // addMultiImages(selectedFile5);
            choosedImage(0);
            // update();
            break;
          default:
            selectedFile.value = File(cropped.path);
            choosedImage(0);
            // update();
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
  RxList<String> selectedEquipments = <String>[].obs;
  final RxString selectedKilometer = ''.obs;
  final RxString selectedFuel = ''.obs;
  RxBool gearboxValue = true.obs; // manual = true, automatic = false
  RxInt selectedPlaces = 4.obs;
  RxInt selectedDoor = 5.obs;
  RxString selectedGearbox = ''.obs;
  RxString selectedDayTech = ''.obs;
  RxString selectedMonthTech = ''.obs;
  RxString selectedYearTech = ''.obs;


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
  late final Future fetchZipCode;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  final RxString selectedZipCode = ''.obs;
  RxList<String> itemsZipCode = <String>[].obs;
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
  FormData? formData;
  RxBool youngDriver = false.obs;
  Rx<TextEditingController> dayPriceController =
      TextEditingController(text: '30').obs;
  Rx<TextEditingController> weekPriceController =
      TextEditingController(text: '160').obs;
  Rx<TextEditingController> monthPriceController =
      TextEditingController(text: '400').obs;

  Future uploadData() async {
    final nextTechnicalInspection = '${selectedYearTech.value}-${selectedMonthTech.value}-${selectedDayTech.value}';
    final setIndisponibility = selectedAvailability!.value.length > 0
        ? "indisponnible"
        : "disponnible";
    final unDisponibility = '[{"start": "${DateFormat('yyyy-MM-dd').format(selectedAvailability![0])}","end": "${DateFormat('yyyy-MM-dd').format(selectedAvailability![0]) != null ? DateFormat('yyyy-MM-dd').format(selectedAvailability![1]) : DateFormat('yyyy-MM-dd').format(selectedAvailability![0])}"}]';

    formData = FormData.fromMap({
      "year": yearController.value.toString(),
      "type": typeController.value.text.toString(),
      "model": modelController.value.text.toString(),
      "brand": brandController.value.text.toString(),
      "fuel": selectedFuel.value.toString(),
      "gearbox": gearboxValue.value ? "manuelle" : "automatique",
      "licensePlate": numberplateController.value.text.toString(),
      "mileage": selectedKilometer.value.toString(),
      "numberOfDoors": selectedDoor.value.toString(),
      "numberOfPlaces": selectedPlaces.value.toString(),
      "equipment": selectedEquipments.toString(),
      "nextTechnicalInspection": nextTechnicalInspection, // replace by date
      // image section to be added
      "technical_inspection_image": await MultipartFile.fromFile(selectedFile.value!.path,
        filename: selectedFile.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      "ariere34":await MultipartFile.fromFile(selectedFile1.value!.path,
        filename: selectedFile1.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      "lateral": await MultipartFile.fromFile(selectedFile2.value!.path,
        filename: selectedFile2.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      "avant34": await MultipartFile.fromFile(selectedFile3.value!.path,
        filename: selectedFile3.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      "interieur": await MultipartFile.fromFile(selectedFile4.value!.path,
        filename: selectedFile4.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      "supplementaire": await MultipartFile.fromFile(selectedFile5.value!.path,
        filename: selectedFile5.value!.path.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
      // end image section
      "description": descriptionController.value.text.toString(),
      "address": addressController.value.text.toString(),
      "pricePerMonth": monthPriceController.value.text.toString(),
      "pricePerWeek": weekPriceController.value.text.toString(),
      "pricePerDay": dayPriceController.value.text.toString(),
      "city": cityController.value.text.toString(),
      "zipCode": selectedZipCode.value.toString(),
      "undisponibilityType": setIndisponibility,
      "undisponibility": '$unDisponibility',
      "youngDriver": youngDriver.value ? true : false,
    });

    try {

      final res = await ApiProvider().addNewAnnonce("/annonce/add", formData, CancelToken());
      // final body = res.data;

      if (res.statusCode == STATUS_OK) {

        Get.defaultDialog(
          title: 'Félicitation',
          titleStyle: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
            color: AppTheme.darkColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppTheme.light,
          content: Column(
            children: [
              SizedBox(height: 20),
              Text('Votre annonce a été publiée avec succès', style: TextStyle(
                color: AppTheme.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ), textAlign: TextAlign.center,),
            ],
          ),
          textConfirm: 'OK',
          buttonColor: AppTheme.primaryColor,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAllNamed(Routes.home);
          },
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Erreur',
        titleStyle: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
          color: AppTheme.darkColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppTheme.light,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${e}', style:
                Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ), textAlign: TextAlign.center,),
            ),
          ],
        ),
        textConfirm: 'OK',
        buttonColor: AppTheme.primaryColor,
        confirmTextColor: AppTheme.light,
        onConfirm: () {
          Get.back();
        },
      );
    }finally{
      isLoading(false);
    }
  }

  //----------Final step -----------//
  @override
  void onInit() {
    super.onInit();
    fetchZipCode = getZipCode();
    Get.put(CarBrandController());
    items.value = equipmentsList
        .map((data) => MultiSelectItem<Equipment>(data, data.name))
        .toList();
  }

  @override
  void onClose() {
    if (selectedFile.value != null && selectedFile.value!.existsSync()) {
      selectedFile.value!.deleteSync();
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

  // ----------------- function step 3 -----------------//
  // get zip code from api
  Future<List<String>> getZipCode() async {
    try {
      final res = await ApiProvider().getData("/utils/zipCode");
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        itemsZipCode.value = body.map<String>((e) => e.toString()).toList();
        return itemsZipCode;
      }else {
        return itemsZipCode.value = [];
      }
    } catch (e) {
      return itemsZipCode.value = [];
    }
  }

}
