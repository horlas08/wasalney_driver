import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:driver/Logic/Controllers/main-controller.dart';
import 'package:driver/Logic/Controllers/map-controller.dart';
import 'package:driver/Models/car-detail.dart';
import 'package:driver/Models/info-bank.dart';
import 'package:driver/Models/rate.dart';
import 'package:driver/Models/wallet.dart';
import 'package:driver/Models/weeklyStatistics.dart';
import 'package:driver/View/Pages/Auth/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver/Logic/Controllers/app-controller.dart';
import 'package:driver/Logic/Helpers/token-methods.dart';
import 'package:driver/Models/user.dart';
import 'package:driver/Public/enums.dart';
import 'package:driver/View/Components/Popups/snackbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Models/dailyStatistics.dart';
import '../../Models/documents-detail.dart';
import '../../Models/message.dart';
import '../../Public/api-urls.dart';
import '../../Public/config.dart';
import '../../Public/styles.dart';
import '../../View/Components/Popups/alert-dialog.dart';
import '../../View/Pages/Auth/OTP-page.dart';
import '../../View/Pages/Auth/activity-type.dart';
import '../../View/Pages/Auth/documents.dart';
import '../../View/Pages/Auth/edit-profile-page.dart';
import '../../View/Pages/Auth/information.dart';
import '../../View/Pages/Main/message-admin.dart';
import '../../View/Pages/Map/home-map.dart';
import '../Helpers/api-methods.dart';
import 'package:image/image.dart' as IMG;
import 'notification-controller.dart';
import 'order-controller.dart';

class UserController extends GetxController {
  static String mobile = '';
  static String verifyCode = '';
  static List<User> profile = [];
  static LatLng myPosition = LatLng(33.312805, 44.361488);
  static Rx<User> user = User().obs;
  static Rx<Statistics> statistics = Statistics().obs;
  static Statistics yesterdayReport = Statistics();
  static Rx<WeeklyStatistics> weeklyStatistics = WeeklyStatistics().obs;
  static Rx<Rate> rate = Rate().obs;
  static RxList<Statistics> monthly = <Statistics>[].obs;
  static CarDetail carDetails = CarDetail();
  static BankInfo infoBank = BankInfo();
  static RxList<User> infoUser = <User>[].obs;
  static String? token;
  static double priceWallet = 0.0;
  static RxInt timer = 0.obs;
  static List<DocDetail> genders = [];
  static RxList<Message> messages = <Message>[].obs;

  static login(bool isMainPage) async {
    AppController.startLoading(['login']);
    var response = await RestApi.post(loginUrl, body: {'mobile': mobile});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          timer.value = 59;
          const oneSec = Duration(seconds: 1);
          new Timer.periodic(
            oneSec,
            (Timer t) {
              if (timer.value == 0) {
                t.cancel();
              } else {
                timer.value--;
              }
            },
          );
          if (isMainPage)
            Navigator.push(Get.context!,
                MaterialPageRoute(builder: (builder) => OTPPage()));
        },
        printResponse: true);
    AppController.finishLoading(['login']);
  }

  static verify(var verifyCode) async {
    AppController.startLoading(['verify']);
    var response = await RestApi.post(verifyUrl,
        body: {'mobile': mobile, 'verify_code': verifyCode});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          print(response!.data['data']);
          user.value = User.fromJson(response.data['data']);
          await Token.setToken(user.value.token!);
          await getUser();
          await getGender();
          await OrderController.myOrder();
          await MainController.getServices();
          await MainController.getInfoSupport();
          await MainController.getDocuments();

          // MainController.checkPage();
          if (UserController.user.value.statusDriver?.id == null) {
            Navigator.push(Get.context!,
                MaterialPageRoute(builder: (context) => InformationPage()));
          } else if (UserController.user.value.statusDriver!.id != 2) {
            Navigator.pushAndRemoveUntil(
                Get.context!,
                MaterialPageRoute(builder: (context) => MessageAdmin()),
                (route) => false);
          } else if (UserController.user.value.statusDriver!.id == 2) {
            MainController.changePage();
            // Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);
          }
        },
        printResponse: true);
    // AppController.finishLoading(['verify']);
  }

  static FCMTOken() async {
    var messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    final token=await messaging.getToken();
    print("Token>>>:${token}");
    if(token !=null){
      var response=await RestApi.post(setTokenUrl,body: {'fcm_token':token});
      RestApi.responseHandler(response: response,successCallback: () async {
        user.value.tokenFCM=response!.data['data']['fcm_token'];
        print("Token>>>:${user.value.tokenFCM}");
        await Token.setNotifToken(user.value.tokenFCM!);
      });
    }
  }

  static getGender() async {
    AppController.startLoading(['get-gener']);
    var response = await RestApi.get(gendersUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          for (var json in response!.data['data']) {
            DocDetail model = DocDetail.fromJson(json);
            genders.add(model);
          }
        },
        printResponse: true);
    AppController.finishLoading(['get-gener']);
  }

  static editUser(String type) async {
    AppController.startLoading(['edit-user']);
    var response = await RestApi.post(updateUserUrl, body: user.value.toJson());
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          if (type == 'info') {
            // if(UserController.user.value.document.value.onCarCard==null || UserController.user.value.document.value.backCarCard==null || UserController.user.value.document.value.onCertificate==null){
            //   Navigator.push(Get.context!,MaterialPageRoute(builder: (context) => Documents()),);
            // }
            // else if(UserController.user.value.document.value.onCarCard!=null && UserController.user.value.document.value.backCarCard!=null && UserController.user.value.document.value.onCertificate!=null){
            //   Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);
            //   await getUser();
            // }
            Navigator.push(Get.context!,
                MaterialPageRoute(builder: (context) => ActivityTypeUser()));

            // MainController.getDocuments(changePage: true);
            // Navigator.push(Get.context!,MaterialPageRoute(builder: (context) => EditProfilePage()));
          } else
            showSnackbar(snackTypes.success,
                '${AppController.of(Get.context!)!.value('Your profile has been updated.')}');
        },
        printResponse: true);
    AppController.finishLoading(['edit-user']);
  }

  static setActivityUser() async {
    AppController.startLoading(['edit-user']);
    var response = await RestApi.post(updateUserUrl,
        body: UserController.user.value.toJson());
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          Navigator.push(
              Get.context!,
              MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                        changePage: true,
                      )));
        },
        printResponse: true);
    AppController.finishLoading(['edit-user']);
  }

  static editProfile(bool changePage) async {
    AppController.startLoading(['edit-profile']);
    var response =
        await RestApi.post(editProfileUrl, body: user.value.toJson());
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          // await Token.removeServicesToken();
          // if(user.value.typeActivity?.token!=null){
          //   await Token.setServicesToken(user.value.typeActivity!.token!);
          //   String?t=await Token.getServicesToken();
          //   print('serice token>>${t}');
          //   Get.put(NotificationController());
          //
          // }
          showSnackbar(snackTypes.success,
              '${AppController.of(Get.context!)!.value('Your account has been updated.')}');

          if (changePage == true) {
            print(UserController.carDetails.fuelType == null ||
                UserController.carDetails.yearMade == null ||
                UserController.carDetails.color == null ||
                UserController.carDetails.carModel == null);
            print(UserController.carDetails.fuelType == null ||
                UserController.carDetails.yearMade == null ||
                UserController.carDetails.color == null ||
                UserController.carDetails.carModel == null);
            if (UserController.carDetails.fuelType == null ||
                UserController.carDetails.yearMade == null ||
                UserController.carDetails.color == null ||
                UserController.carDetails.carModel == null) {
              print(
                  '${AppController.of(Get.context!)!.value('Please complete the car specifications')}>>>>>>>>>>>>>>>>');
              showSnackbar(snackTypes.error,
                  '${AppController.of(Get.context!)!.value('Please complete the car specifications')}');
            } else
              Navigator.push(Get.context!,
                  MaterialPageRoute(builder: (context) => Documents()));
            // Navigator.pushAndRemoveUntil(Get.context!,MaterialPageRoute(builder: (context) => HomeMap()), (route) => false);
          }
        },
        printResponse: true);
    AppController.finishLoading(['edit-profile']);
  }

  static editCarDetail({bool changePage = false}) async {
    AppController.startLoading(['edit-car-detail']);
    var response = await RestApi.post(editDocUrl, body: carDetails.toJson());
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          for (var json in response!.data['data']['car_details']) {
            CarDetail carDetail = CarDetail.fromJson(json);
            user.value.carDetails?.add(carDetail);
            carDetails = carDetail;
          }

          user.value.hasCarDetails = response.data['data']['has_car_details'];
          showSnackbar(snackTypes.success,
              '${AppController.of(Get.context!)!.value('Your car details have been updated.')}');
          if (changePage) {
            if (UserController.user.value.name == null ||
                UserController.user.value.codeMeli == null ||
                UserController.user.value.mobile == null ||
                UserController.user.value.certificateValidity == null ||
                UserController.user.value.certificateType == null ||
                UserController.user.value.certificatDate?.main == null) {
              showSnackbar(snackTypes.error,
                  '${AppController.of(Get.context!)!.value('Please complete the personal information')}');
            } else {
              Navigator.push(Get.context!,
                  MaterialPageRoute(builder: (context) => Documents()));

              // MainController.checkPage();
            }
          }
        },
        printResponse: true);
    AppController.finishLoading(['edit-car-detail']);
  }

  static editBankInfo() async {
    AppController.startLoading(['edit-bank-info']);
    print(infoBank.number.length);

    var response = await RestApi.post(editBankInfoUrl, body: infoBank.toJson());
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value.infoBank = [];
          BankInfo info = BankInfo.fromJson(response!.data['data']);
          user.value.infoBank.add(info);
          infoBank = info;
          print('infoBank length>>>${user.value.infoBank.length}');
          print('infoBank >>>${infoBank.name}');
          showSnackbar(snackTypes.success,
              '${AppController.of(Get.context!)!.value('Your account has been updated.')}');
        },
        printResponse: true);
    AppController.finishLoading(['edit-bank-info']);
  }

  static changeState(int state) async {
    AppController.startLoading(['change-state']);
    var response =
        await RestApi.post(changeStateUserUrl, body: {'state': state});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          print('user status>>>${user.value.state}');
          if (state == 1) {
            UserController.getMyLocation(
                controller: MapApiController.mainController);
            OrderController.allOrders();
          }
          else{
            MapApiController.removeAllMarker();
          }
        },
        printResponse: true);
    AppController.finishLoading(['change-state']);
  }

  static setStateDriver() async {
    AppController.startLoading(['set-state']);
    var response = await RestApi.get(setStateDriverUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          showSnackbar(snackTypes.success, response!.data['message']);
          UserController.user.value = User.fromJson(response.data['data']);
          if (UserController.user.value.statusDriver!.id == 2) {
            Navigator.pushAndRemoveUntil(
                Get.context!,
                MaterialPageRoute(builder: (context) => HomeMap()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                Get.context!,
                MaterialPageRoute(builder: (context) => MessageAdmin()),
                (route) => false);
          }
        },
        printResponse: true);
    AppController.finishLoading(['set-state']);
  }

  static addWallet(int code) async {
    AppController.startLoading(['add-money']);
    var response = await RestApi.post(addWalletUrl, body: {'code': code});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          updateWallet(response!.data['data']);
          Navigator.pop(Get.context!);
          showSnackbar(snackTypes.success, response.data['message']);
          // user.value=User.fromJson(response!.data['data']);
          // print('user status>>>${user.value.state}');
        },
        printResponse: true);
    AppController.finishLoading(['add-money']);
  }

  static updateWallet(data) {
    user.value.wallet.add(Wallet.fromJson(data));
    user.value.calculateCredit();
    print('credir>>${user.value.creditUser.value}');
  }

  static updateAvatar(Uint8List selectedImage) async {
    var response = await RestApi.post(avatarUrl,
        body: {'file': base64.encode(selectedImage)});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value = User.fromJson(response!.data['data']);
        },
        printResponse: true);
  }

  static updateDoc1(Uint8List selectedImage) async {
    AppController.startLoading(['update-Document1']);
    var response = await RestApi.post(editDoc1Url,
        body: {'on_car_card': base64.encode(selectedImage)});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value.document.value.onCarCard = response!.data['data']['on_car_card'];
          print('on card >>${basePathImgMain + UserController.user.value.document.value.onCarCard!}');
          // if(user.value.documents.value.length!=0){
          //   user.value.documents.value[0].onCarCard=response!.data['data']['on_car_card'];
          // }
          // else{
          //   user.value.documents.add(DriverDocument.fromJson(response!.data['data']));
          // }
        },
        printResponse: true);
    AppController.finishLoading(['update-Document1']);
  }

  static updateDoc2(Uint8List selectedImage) async {
    AppController.startLoading(['update-Document2']);
    var response = await RestApi.post(editDoc2Url,
        body: {'back_car_card': base64.encode(selectedImage)});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value.document.value.backCarCard =
              response!.data['data']['back_car_card'];

          // if(user.value.documents.value.length!=0){
          //
          // user.value.documents.value[0].backCarCard=response!.data['data']['back_car_card'];
          // }
          // else{
          //   user.value.documents.add(DriverDocument.fromJson(response!.data['data']));
          // }
        },
        printResponse: true);
    AppController.finishLoading(['update-Document2']);
  }

  static updateDoc3(Uint8List selectedImage) async {
    AppController.startLoading(['update-Document3']);
    var response = await RestApi.post(editDoc3Url,
        body: {'on_certificate': base64.encode(selectedImage)});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value.document.value.onCertificate =
              response!.data['data']['on_certificate'];

          // if(user.value.documents.value.length!=0){
          //
          //   user.value.documents.value[0].onCertificate=response!.data['data']['on_certificate'];
          // }
          // else{
          //   user.value.documents.add(DriverDocument.fromJson(response!.data['data']));
          // }
        },
        printResponse: true);
    AppController.finishLoading(['update-Document3']);
  }

  static updateDoc4(Uint8List selectedImage) async {
    AppController.startLoading(['update-Document4']);
    var response = await RestApi.post(editDoc4Url,
        body: {'additional_documents': base64.encode(selectedImage)});
    RestApi.responseHandler(
        response: response,
        successCallback: () {
          user.value.document.value.docAddition =
              response!.data['data']['additional_documents'];

          // if(user.value.documents.value.length!=0){
          //
          //   user.value.documents.value[0].onCertificate=response!.data['data']['on_certificate'];
          // }
          // else{
          //   user.value.documents.add(DriverDocument.fromJson(response!.data['data']));
          // }
        },
        printResponse: true);
    AppController.finishLoading(['update-Document4']);
  }

  static getUser() async {
    AppController.startLoading(['get-user']);
    if (await Token.getToken() != null) {
      var response = await RestApi.get(getUserUrl);
      RestApi.responseHandler(
          response: response,
          successCallback: () async {
            print('json >>>${response!.data['data']}');

            user.value = User.fromJson(response.data['data']);
            if (response.data['data']['car_details'].length != 0) {
              print('json222 >>>${response.data['data']['car_details']}');
                CarDetail carDetail =
                CarDetail.fromJson(response.data['data']['car_details'][0]);

                carDetails = carDetail;

            }
            token = await Token.getToken();
            FCMTOken();
            print('jsonw >>>${response.data['data']}');

            rateReport();
            if (user.value.typeActivity?.token != null) {
              await Token.removeServicesToken();
              await Token.setServicesToken(user.value.typeActivity!.token!);
              String? t = await Token.getServicesToken();
              print('serice token>>${t}');
              Get.put(NotificationController());
            }
            yesterdayReport = Statistics.fromJson(
                response.data['data']['yesterday_statistics']);


            // await MainController.getDocuments();


          },
          errorCallback: () {
            Navigator.pushAndRemoveUntil(
                Get.context!,
                MaterialPageRoute(builder: (context) => RegisterPage()),
                (route) => false);
          },
          popupMessage: false,
          printResponse: true);
    }
    AppController.finishLoading(['get-user']);
    // AppController.finishLoading(['verify']);
  }

  chooseDoc(ImageSource imageSource, {Function? onChange}) async {
    var accepted = false;
    if (!kIsWeb) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32 &&
          await Permission.storage.request().isGranted) {
        accepted = true;
      } else if (await Permission.photos.request().isGranted) {
        accepted = true;
      }
    }
    if (kIsWeb || accepted) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: imageSource, maxWidth: 1000, maxHeight: 1000);
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,
          // cropStyle: CropStyle.,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '${AppController.of(Get.context!)!.value('cut')}',
              toolbarColor: appColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: true,
            ),
            WebUiSettings(
              context: Get.context!,
              presentStyle: CropperPresentStyle.page,
              boundary: CroppieBoundary(
                width: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                height: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
              ),
              viewPort: CroppieViewPort(
                width: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                height: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                type: 'square',
              ),
              enableExif: true,
              enableZoom: true,
              mouseWheelZoom: true,
              enableOrientation: true,
              enableResize: true,
              enforceBoundary: true,
              showZoomer: false,
            ),
          ],
        );
        if (croppedFile != null) {
          AppController.isLoading.value = true;
          Uint8List selectedImage = await croppedFile.readAsBytes();
          onChange!(selectedImage);
          // var response=await RestApi.post(avatarUrl,body: {
          //   'file': base64.encode(selectedImage)
          // });
          // RestApi.responseHandler(response: response,successCallback: (){
          //   user.value=User.fromJson(response!.data['data']);
          // },printResponse: true);
          // await IsolatedWorker()
          //     .run(ReduceImageQualityAndSize, selectedImage)
          //     .then((value) {
          //   selectedImage = value;
          // });
          AppController.isLoading.value = false;
        }
      } else {
        print("No file selected");
      }
    }
    update();
  }

  // static chooseProfile(ImageSource imageSource,bool camera) async {
  //   PermissionStatus permissionStatusCamera = await Permission.camera.status;
  //   PermissionStatus permissionStatusGallery = await Permission.photos.status;
  //   print('permissionStatusGallery>>${permissionStatusGallery.isDenied}');
  //   print('permissionStatusGallery>>${permissionStatusCamera.isDenied}');
  //   if(camera==true){
  //     if(permissionStatusCamera.isDenied==true){
  //       showAlertDialog(Get.context!,
  //           title:
  //           '${AppController.of(Get.context!)!.value('Reason for accessing your camera or photos')}',
  //           child: Container(
  //             padding: EdgeInsets.only(left: 15, right: 15,bottom: 15),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                     '${AppController.of(Get.context!)!.value('Camera and gallery access is required to authenticate you')}\n',
  //                     style: AppController.fontStyle(
  //                         fontTypes.bodySM, additionalColor2Shade800)),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     InkWell(
  //                         onTap: () {
  //                           Get.back();
  //                           choosePhoto(imageSource);
  //                         },
  //                         child: Text('تایید',
  //                             style: AppController.fontStyle(
  //                                 fontTypes.bodySM, dominantColorShade300))),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ), onClose: () {
  //             // Navigator.pop(Get.context!);
  //             choosePhoto(imageSource);
  //           });
  //     }
  //     else{
  //       choosePhoto(imageSource);
  //     }
  //   }
  //   else
  //     if ( permissionStatusGallery.isDenied==true) {
  //     showAlertDialog(Get.context!,
  //         title:
  //             '${AppController.of(Get.context!)!.value('Reason for accessing your camera or photos')}',
  //         child: Container(
  //           padding: EdgeInsets.only(left: 15, right: 15,bottom: 15),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                   '${AppController.of(Get.context!)!.value('Camera and gallery access is required to authenticate you')}\n',
  //                   style: AppController.fontStyle(
  //                       fontTypes.bodySM, additionalColor2Shade800)),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   InkWell(
  //                       onTap: () {
  //                         Get.back();
  //                         choosePhoto(imageSource);
  //                       },
  //                       child: Text('تایید',
  //                           style: AppController.fontStyle(
  //                               fontTypes.bodySM, dominantColorShade300))),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ), onClose: () {
  //       // Navigator.pop(Get.context!);
  //           choosePhoto(imageSource);
  //     });
  //   }
  //     else{
  //       choosePhoto(imageSource);
  //     }
  // }

  static chooseProfile(ImageSource imageSource,bool camera) async {
    var accepted = false;
    if (!kIsWeb) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      // if(permissionStatusCamera.)
      if (androidInfo.version.sdkInt <= 34 &&
          await Permission.storage.request().isGranted) {
        accepted = true;
      } else if (await Permission.photos.request().isGranted) {
        accepted = true;
      }
    }
    if (kIsWeb || accepted) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: imageSource, maxWidth: 1000, maxHeight: 1000);
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: CropStyle.circle,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '${AppController.of(Get.context!)!.value('cut')}',
              toolbarColor: appColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: true,
            ),
            WebUiSettings(
              context: Get.context!,
              presentStyle: CropperPresentStyle.page,
              boundary: CroppieBoundary(
                width: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                height: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
              ),
              viewPort: CroppieViewPort(
                width: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                height: maxItemWidth >
                        MediaQuery.of(Get.context!).size.width.toInt()
                    ? MediaQuery.of(Get.context!).size.width.toInt() -
                        paddingSize.toInt()
                    : maxItemWidth.toInt(),
                type: 'circle',
              ),
              enableExif: true,
              enableZoom: true,
              mouseWheelZoom: true,
              enableOrientation: true,
              enableResize: true,
              enforceBoundary: true,
              showZoomer: false,
            ),
          ],
        );
        if (croppedFile != null) {
          AppController.isLoading.value = true;
          Uint8List selectedImage = await croppedFile.readAsBytes();

          // await IsolatedWorker()
          //     .run(ReduceImageQualityAndSize, selectedImage)
          //     .then((value) {
          //   selectedImage = value;
          // });

          AppController.isLoading.value = true;
          AppController.startLoading(['set-profile']);
          var response = await RestApi.post(avatarUrl,
              body: {'file': base64.encode(selectedImage)});
          RestApi.responseHandler(
              response: response,
              successCallback: () {
                user.value.image.value = response!.data['data']['image'];
              },
              printResponse: true);
          AppController.finishLoading(['set-profile']);
          AppController.isLoading.value = false;
        }
      } else {
        print("No file selected");
      }
    }
  }

  static Future<Uint8List> ReduceImageQualityAndSize(Uint8List image) async {
    int maxInBytes = 500000;
    Uint8List resizedData = Uint8List.fromList(image);

    IMG.Image? img = await IMG.decodeImage(image);
    int size = await image.lengthInBytes;
    int quality = 100;

    print("size max: " + maxInBytes.toString());
    print("size before: " + size.toString() + " bytes");

    while (size > maxInBytes && quality > 10) {
      // reduce image size about 10% of image, until the size is less than the maximum limit
      quality = (quality - (quality * 0.1)).toInt();
      int width = img!.width - (img.width * 0.1).toInt();
      IMG.Image resized = await IMG.copyResize(img, width: width);
      resizedData =
          await Uint8List.fromList(IMG.encodeJpg(resized, quality: quality));
      size = await resizedData.lengthInBytes;
      img = resized;
    }

    print("size after: " + size.toString() + " bytes");

    return resizedData;
  }

  static Future<bool> getMyLocation({GoogleMapController? controller}) async {
    var status = await Permission.location.status;
    print('permision>>>${status.isDenied}');
    print('controllerrrrr>>>${controller}');

    if (status.isDenied) {
      showAlertDialog(Get.context!,
          title:
              '${AppController.of(Get.context!)!.value('Reason for accessing your location')}',
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${AppController.of(Get.context!)!.value('Permission to access your location to receive orders near you and for directions')}\n',
                    style: AppController.fontStyle(
                        fontTypes.bodySM, additionalColor2Shade800)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                          getPermisionLocation(controller: controller);
                        },
                        child: Text('تاکید',
                            style: AppController.fontStyle(
                                fontTypes.bodySM, dominantColorShade300))),
                  ],
                )
              ],
            ),
          ), onClose: () {
        // Navigator.pop(Get.context!);
        getPermisionLocation(controller: controller);
      });
    }
    else{
      getPermisionLocation(controller: controller);

    }
    return true;
  }

  static Future<bool> getPermisionLocation({GoogleMapController? controller}) async {

    print('start determine');
    print('controllerrrrr>>>${controller}');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      showSnackbar(snackTypes.error,
          '${AppController.of(Get.context!)!.value('Turn on your mobile location to receive the trip!')}');
      return false;
    }

    permission = await Geolocator.checkPermission();
    print('permision>>>${permission}');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        showSnackbar(snackTypes.error,
            '${AppController.of(Get.context!)!.value('Turn on your mobile location to receive the trip!')}');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      showSnackbar(snackTypes.error,
          '${AppController.of(Get.context!)!.value('Turn on your mobile location to receive the trip!')}');

      return false;
    }
    print('end determine');
    Position myLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: Duration(seconds: 10));
    myPosition = LatLng(myLocation.latitude, myLocation.longitude);
    if (controller != null) {
      print('controller>>>>>>>>>>>>>>>>');
      MapApiController.setCameraPosition(
          myPosition.latitude, myPosition.longitude);
      // controller.move(myPosition, 16);
    }
    MainController mainController = Get.put(MainController());
    mainController.setLatLong(myPosition.latitude, myPosition.longitude);
    return true;
  }

  static updateUser(data) async {
    print('update user>>>>>>>>>>>>');
    user.value = User.fromJsonSoket(data);
    await Token.setNotifToken(user.value.tokenFCM!);
    await Token.removeServicesToken();
    if (user.value.typeActivity?.token != null) {
      await Token.setServicesToken(user.value.typeActivity!.token!);
      String? t = await Token.getServicesToken();
      print('serice token>>${t}');
    }
  }

  static dailyReport() async {
    AppController.startLoading(['statistics']);
    var response = await RestApi.get(dailyReportUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          statistics.value = Statistics.fromJson(response!.data['data']);
        },
        printResponse: true);
    AppController.finishLoading(['statistics']);
  }

  static rateReport() async {
    // AppController.startLoading('rate-report');
    var response = await RestApi.get(rateReportUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          for (var json in response!.data['data'])
            rate.value = Rate.fromJson(json);
        },
        printResponse: true);
    // AppController.finishLoading('rate-report');
  }

  static weeklyReport() async {
    AppController.startLoading(['weekly-statistics']);
    var response = await RestApi.get(weeklyReportUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          weeklyStatistics.value =
              WeeklyStatistics.fromJson(response!.data['data']);
          // Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=>ReportPage()));
        },
        printResponse: true);
    AppController.finishLoading(['weekly-statistics']);
  }

  static monthlyReport() async {
    AppController.startLoading(['monthly-statistics']);
    var response = await RestApi.get(monthlyReportUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          monthly = <Statistics>[].obs;
          for (var json in response!.data['data']) {
            Statistics statistics = Statistics.fromJson(json);
            monthly.add(statistics);
          }
        },
        printResponse: true);
    AppController.finishLoading(['monthly-statistics']);
  }

  static logout() async {
    Token.removeToken();
    Token.removeNotifToken();
    user.value = User();
    carDetails = CarDetail();
    Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => RegisterPage()),
        (route) => false);
  }

  static checkWallet(double price) async {
    AppController.startLoading(['add-money']);
    var response = await RestApi.post(accountCheckUrl, body: {'price': price});
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          // updateWallet(Wallet.fromJson(response!.data['data']));
          // user.value.wallet.add(Wallet.fromJson(response!.data['data']));
          // user.value.calculateCredit();
          showSnackbar(snackTypes.success, response!.data['message']);
          // user.value=User.fromJson(response!.data['data']);
          // print('user status>>>${user.value.state}');
        },
        printResponse: true);
    AppController.finishLoading(['add-money']);
  }

  static getMessage() async {
    AppController.startLoading(['get-message']);
    var response = await RestApi.get(getMessageUrl);
    RestApi.responseHandler(
        response: response,
        successCallback: () async {
          messages.value = [];
          for (var json in response!.data['data']) {
            Message message = Message.fromJson(json);
            messages.add(message);
          }
          print('messsage is>>${messages.length}');
        },
        printResponse: true);
    AppController.finishLoading(['get-message']);
  }
}
