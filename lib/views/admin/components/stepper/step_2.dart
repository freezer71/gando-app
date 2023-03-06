import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../config/textstyle.dart';

class Step2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Step2State();
  }
}

class Step2State extends State<Step2> {
  static final form2 = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  final controller = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddArticlesController>(
      assignId: true,
      builder: (logic) {
        return Form(
          key: form2,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(
                height: 10,
              ),
              _buildBody(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text('Photos Conforme',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 10,
          ),
          Text(
              'Pour une bonne compréhension  de la location,\nveuillez prendre des photos quilitative de votre véhicule.',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.imagesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 120,
            ),
            itemBuilder: (context, index) {
              return _buildLastBox(index, controller.imagesList[index]);
              // return _buildImageBox(index, controller.imagesList[index], controller.selectedFile1.value);

              /*return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.light),
                    overlayColor: MaterialStateProperty.all(Colors
                        .transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  ),
                  onPressed: () {
                    controller.choosedImage.value = index;
                    _buildImageBox(index, controller.imagesList[index]);
                    // _showMaterialDialog();
                  },
                  child: SizedBox(
                    width: Get.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${controller.imagesList[index]} ${index == controller.imagesList.length -1 ? '+' : ''}",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.darkColor)),
                        const SizedBox(height: 10,),
                        Icon(Icons.camera_alt_outlined, size: 40, color: AppTheme.darkColor.withOpacity(0.4),)
                      ],
                    ),
                  ));*/
            },
          ),
        ],
      ),
    );
  }

  //Zone multiples images
  Widget _buildLastBox(int num, String title) {
    switch (num) {
      case 0:
        return _buildImageBox(num, title, controller.selectedFile1.value);
      case 1:
        return _buildImageBox(num, title, controller.selectedFile2.value);
      case 2:
        return _buildImageBox(num, title, controller.selectedFile3.value);
      case 3:
        return _buildImageBox(num, title, controller.selectedFile4.value);
      case 4:
        return _buildImageBox(num, title, controller.selectedFile5.value);
      default:
        return Container();
    }
  }

  Widget _buildImageBox(int num, String title, File? image) {
    return image == null
        ? InkWell(
            onTap: () {
              controller.choosedImage.value = num;
              _showMaterialDialog();
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.light,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: AppTheme.darkColor.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("${title}",
                      style:
                      TextStyle(fontSize: 14, color: AppTheme.darkColor)),

                ],
              ),
            ),
          )
        : ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 350, rect.width, 100));
          },
          blendMode: BlendMode.darken,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.redColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete_outline,
                      color: AppTheme.light, size: 20,),
                    onPressed: () {
                      switch (num) {
                        case 0:
                          controller.selectedFile1.value = null;
                          controller.update();
                          break;
                        case 1:
                          controller.selectedFile2.value = null;
                          controller.update();
                          break;
                        case 2:
                          controller.selectedFile3.value = null;
                          controller.update();
                          break;
                        case 3:
                          controller.selectedFile4.value = null;
                          controller.update();
                          break;
                        case 4:
                          controller.selectedFile5.value = null;
                          controller.update();
                          break;
                        default:
                          break;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
  }

  _showMaterialDialog() {

   return Get.bottomSheet(
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Expanded(
                  child:
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(AppTheme.primaryColor),
                      overlayColor: MaterialStateProperty.all(AppTheme.primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      controller.askPermissionCamera();
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context, true);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt_outlined, color: AppTheme.darkColor),
                        const SizedBox(width: 10,),
                        Text('Camera', style: TextStyle(color: AppTheme.darkColor),),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Expanded(child:
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.primaryColor),
                    overlayColor: MaterialStateProperty.all(AppTheme.primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  ),
                  onPressed: () {
                    if (Platform.isIOS) {
                      controller.askPermissionPhotos();
                    } else {
                      controller.askPermissionStorage();
                    }
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context, true);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.photo_library_outlined, color: AppTheme.darkColor),
                      const SizedBox(width: 10,),
                      const Text('Gallery', style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
                ),
              ),
            ],
          ),
        ),);
  }
}
