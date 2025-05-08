import 'dart:ui';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Public/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../Models/message.dart';
import '../../Models/notification.dart';
import '../../Public/api-urls.dart';
import '../../Public/styles.dart';
import '../../View/Components/Popups/snackbar.dart';
import '../Helpers/api-methods.dart';
import '../Helpers/token-methods.dart';
import 'map-controller.dart';
import 'order-controller.dart';

class NotificationController extends GetxController  with WidgetsBindingObserver{

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      // Replace with actual values
      options: FirebaseOptions(
        apiKey: "AIzaSyB8oUC1poCOcBYBC8sfT8XY1Gz_LgvbzDM",
        appId: "1:259470122485:web:c8cf1bef51baeb2bd694bc",
        messagingSenderId: "259470122485",
        projectId: "okay-f7073",
      ),
     );

    print("Handling a background message: ${message.data}");
    echoChannelBackground(message);
  }

  static final backgroundService = FlutterBackgroundService();
  // static bool _isinitial=true;
  @pragma('vm:entry-point')
  static initSocket({bool isBackgroundSocket=false})async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      echoChannelForground(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      print('Message data: ${message.data}');
      echoChannelForground(message);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }
  static echoChannelForground(RemoteMessage data) async {
    String? userToken=await Token.getNotifToken();


    SocketNotification notification=SocketNotification.fromJson(data.data);
    MapApiController mapApiController=Get.put(MapApiController());
    OrderController orderController=Get.put(OrderController());

    print('notif >>>${notification.isShowAlert}${notification.isAudioAlert} ${notification.status} ${notification.message}');
    // if(!isBackgroundSocket){
    switch(data.data['type']){
    // case 'update_order':
    //   OrderController.getOrder(int.parse(notification.fId!));
    //   break;
      case 'add_order':
        orderController.addOrder(data.data['data']);
        break;

//accept order by agency
      case 'send_order':
        OrderController.acceptAgencyOrder(data.data['data']);
        break;

      case 'update_user':
        UserController.updateUser(data.data['data']);
        break;

      case 'update_wallet':
        var response = await RestApi.post(getWalletItemUrl,body: {'id':data.data['data']});
        RestApi.responseHandler(
            response: response,
            successCallback: () async {
              UserController.updateWallet(response!.data['data']);
            });
        break;

      case 'update_order':
        OrderController.updateAcceptOrder(data.data['data']);
        break;

      case 'update_order_list':
        OrderController.updateOrderList(data.data['data']);
        break;

      case 'update_pay_order':
        OrderController.updateAcceptOrder(data.data['data']);
        break;

      case 'cancel_order':
        OrderController.deleteOrder(data.data['data']);
        break;

      case 'cancel_order_item':
        OrderController.deleteOrderItem(data.data['data']);
        break;

      case 'set_rate':
        UserController.rateReport();
        break;
      case 'recive_message':
        OrderController.getMessage(data.data['data']);
        break;
      case 'new_message':
        var response = await RestApi.post(getMessageItemUrl,body: {'id':data.data['data']});
        RestApi.responseHandler(
            response: response,
            successCallback: () async {
              Message message = Message.fromJson(response!.data['data']);
              UserController.messages.add(message);
            },printResponse: true);
        break;
    }


    // if(isBackgroundSocket==false){
    if(notification.isAudioAlert=='1'){
      print("play audio");
      AssetsAudioPlayer.newPlayer().open(
          Audio("assets/media/notif.mpeg")
      );
      // }
      // }

    }

    print('listen alert');

    if(notification.isShowAlert=='1'){
      // showNotificationWeb(notification.message);
      print('notif status>>${notification.status}');

      switch(notification.status){
        case 'error':
        // if(isBackgroundSocket)
        //   showNotificationApp(notification.message!, errorColor);
        // else
          showSnackbar(snackTypes.error, notification.message);
          break;
        case '1':
        // if(isBackgroundSocket)
        //   showNotificationApp(notification.message!, successColor);
        // else
          showSnackbar(snackTypes.success, notification.message);
          break;
        case 'info':
        // if(isBackgroundSocket)
        //   showNotificationApp(notification.message!, successColor);
        // else
          showSnackbar(snackTypes.info, notification.message);
          break;
        case 'warning':
        // if(isBackgroundSocket)
        //   showNotificationApp(notification.message!, warningColor);
        // else
          showSnackbar(snackTypes.warning, notification.message);
          break;
      }
    }
  }

  static echoChannelBackground(RemoteMessage data) async {
    SocketNotification notification=SocketNotification.fromJson(data.data);
    MapApiController mapApiController=Get.put(MapApiController());
    OrderController orderController=Get.put(OrderController());

    print('notif >>>${notification.isShowAlert}${notification.isAudioAlert} ${notification.status} ${notification.message}');
    switch(data.data['type']){
    // case 'update_order':
    //   OrderController.getOrder(int.parse(notification.fId!));
    //   break;
      case 'add_order':
        orderController.addOrder(data.data['data']);
        break;

//accept order by agency
      case 'send_order':
        OrderController.acceptAgencyOrder(data.data['data']);
        break;

      case 'update_user':
        UserController.updateUser(data.data['data']);
        break;

      case 'update_wallet':
        var response = await RestApi.post(getWalletItemUrl,body: {'id':data.data['data']});
        RestApi.responseHandler(
            response: response,
            successCallback: () async {
              UserController.updateWallet(response!.data['data']);
            });
        break;

      case 'update_order':
        OrderController.updateAcceptOrder(data.data['data']);
        break;

      case 'update_order_list':
        OrderController.updateOrderList(data.data['data']);
        break;

      case 'update_pay_order':
        OrderController.updateAcceptOrder(data.data['data']);
        break;

      case 'cancel_order':
        OrderController.deleteOrder(data.data['data']);
        break;

      case 'cancel_order_item':
        OrderController.deleteOrderItem(data.data['data']);
        break;

      case 'set_rate':
        UserController.rateReport();
        break;
      case 'recive_message':
        OrderController.getMessage(data.data['data']);
        break;
      case 'new_message':
        var response = await RestApi.post(getMessageItemUrl,body: {'id':data.data['data']});
        RestApi.responseHandler(
            response: response,
            successCallback: () async {
              Message message = Message.fromJson(response!.data['data']);
              UserController.messages.add(message);
            },printResponse: true);
        break;
    }

    if(notification.isAudioAlert=='1'){
      print("play audio");
      AssetsAudioPlayer.newPlayer().open(
          Audio("assets/media/notif.mpeg")
      );
    }
    if(notification.isShowAlert=='1'){
      // showNotificationWeb(notification.message);
      print('notif status>>${notification.status}');

      switch(notification.status){
        case 'error':
          showNotificationApp(notification.message!, errorColor);
          break;
        case '1':
          showNotificationApp(notification.message!, successColor);
          break;
        case 'info':
          showNotificationApp(notification.message!, successColor);
          break;
        case 'warning':
          showNotificationApp(notification.message!, warningColor);
          break;
      }
    }
  }

  static Future<void> initBackgroundService() async {

    // if(!await backgroundService.isRunning()){


    print('initBackgroundService');


    await backgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStartBackground,
        // auto start service
        autoStart: false,
        isForegroundMode: false,
        notificationChannelId: 'alerts',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStartBackground,

        // you have to enable background fetch capability on xcode project
        onBackground: (ServiceInstance service) {
          WidgetsFlutterBinding.ensureInitialized();
          print('FLUTTER BACKGROUND FETCH');

          return true;
        },
      ),
    );
    // backgroundService.startService();
    // }

  }

  @pragma('vm:entry-point')
  static void onStartBackground(ServiceInstance service) async {
    print('***onStartBackgroundService**');

// Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    initSocket(isBackgroundSocket: true);


    if (service is AndroidServiceInstance) {

      service.on('setAsForeground').listen((event) {
        print('setAsForeground');
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        print('setAsBackground');
        service.setAsBackgroundService();
      });


    }

    service.on('stopService').listen((event) {
      service.stopSelf();

    });

    // bring to foreground
    // Timer.periodic(const Duration(seconds: 10), (timer) async {//check: remove
    //
    //   // print('hello');
    //
    //
    //   // if (service is AndroidServiceInstance) {
    //   //   service.setForegroundNotificationInfo(
    //   //     title: "My App Service",
    //   //     content: "Updated at ${DateTime.now()}",
    //   //   );
    //   // }
    //   //
    //   // /// you can see this log in logcat
    //   // // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    //   //
    //   // // test using external plugin
    //   // // final deviceInfo = DeviceInfoPlugin();
    //   // String? device;
    //   // if (Platform.isAndroid) {
    //   //   // final androidInfo = await deviceInfo.androidInfo;
    //   //   device = 'androidInfo.model';
    //   // }
    //   //
    //   // if (Platform.isIOS) {
    //   //   // final iosInfo = await deviceInfo.iosInfo;
    //   //   device = 'iosInfo.model';
    //   // }
    //   //
    //   // service.invoke(
    //   //   'update',
    //   //   {
    //   //     "current_date": DateTime.now().toIso8601String(),
    //   //     "device": device,
    //   //   },
    //   // );
    // });
  }
  static Future<bool> displayNotificationPermission() async {
    bool userAuthorized = false;
    BuildContext context = Get.context!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  @pragma('vm:entry-point')
  static showNotificationApp(String text,Color color) async {
    print('notifText>>$text');
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    print('notifAllowed>>>${isAllowed}');
    if (!isAllowed) isAllowed = await displayNotificationPermission();
    if (!isAllowed) return;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: text,
            // body:"aaaaaa",
            // largeIcon:
            // 'asset://assets/logos/logo.png',
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          // NotificationActionButton(key: 'REDIRECT', label: 'Redirect',),
          // NotificationActionButton(
          //     key: 'REPLY',
          //     label: 'Reply Message',
          //     requireInputText: true,
          //     actionType: ActionType.SilentAction
          // ),
          NotificationActionButton(
              key: 'close',
              label: 'close',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);

  }
  static showNotificationWeb(var text){
    // if(kIsWeb){
    //   // js.context.callMethod('persistentNotification',[text]);
    //   var element=html.document.getElementById('notificationDiv');
    //   element!.innerHtml=text;
    //   element.click();
    //   element.innerHtml='';
    // }
  }
  @override
  void onInit() async{
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    if(kIsWeb){
      print('onInitNotif');
      initSocket(isBackgroundSocket: false);
    }
    else{
      final androidInfo =await DeviceInfoPlugin().androidInfo;
      if(androidInfo.version.sdkInt<=32 || await Permission.notification.request().isGranted){

        print('onInitNotif');
        initSocket(isBackgroundSocket: false);
        await initBackgroundService();
        backgroundService.invoke('stopService');
      }

    }
  }
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    print('onCloseNotif');
    if(!kIsWeb)
      backgroundService.startService();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // document.getElementById('elementId')!.onClick;
    switch(state){
      case AppLifecycleState.resumed:
        print('appResume');
        if(!kIsWeb)
          backgroundService.invoke('stopService');
        break;
      case AppLifecycleState.inactive:
        print('appInactive');
        if(!kIsWeb)
          backgroundService.startService();
        break;
      case AppLifecycleState.paused:
        print('appPause');
        if(!kIsWeb)
          backgroundService.startService();
        break;
      case AppLifecycleState.detached:
        print('appDeatached');
        if(!kIsWeb)
          backgroundService.startService();
        break;
    }
  }

}