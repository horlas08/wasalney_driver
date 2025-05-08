import 'package:driver/Logic/Controllers/user-controller.dart';
import 'package:driver/Models/car-detail.dart';
import 'package:driver/Models/date.dart';
import 'package:driver/Models/info-bank.dart';
import 'package:driver/Models/rate-club.dart';
import 'package:driver/Models/services.dart';
import 'package:driver/Models/wallet.dart';
import 'package:get/get.dart';
import 'documents-detail.dart';
import 'driver-document.dart';

class User {
  var id;
  int? codeWallet;
  Rx<int> creditUser=0.obs;
  DocDetail? certificateType;
  String? certificateValidity;
  Date? certificatDate;
  String?dateCertificate;
  Rx<String> image=''.obs;
  // String? numberLicence;
  String? long;
  String? lat;
  String? verifyCode;
  String? codeMeli;
  String? familyNumber;
  String? mobile;
  var removable;
  var unremovable;
  var state;
  String? name;
  String? code;
  String? description;
  String? introCode;
  String? token;
  String? tokenFCM;
  // String? notifToken;
  bool?hasInfoBank;
  bool?hasAllInfoUser;
  bool?hasInfoUser;
  bool?hasCarDetails;
  bool?hasDocument;
  DocDetail?statusDriver;
  Services? typeActivity;
  Services? parentType;

  String? plak;
  List<String> plakMotor=[];
  List<RateClub>rateList=[];
  RxInt rate=0.obs;
  int costRate=0;
  DocDetail? gender;

  List<CarDetail>? carDetails;
  // RxList<DriverDocument> documents=<DriverDocument>[].obs;
  Rx<DriverDocument> document=DriverDocument().obs;
  RxList<Wallet> wallet=<Wallet>[].obs;
  List<BankInfo> infoBank =[];


  User(
      {this.id,
        this.codeWallet,
        // this.credit,
        this.certificateType,
        this.certificateValidity,
        // this.numberLicence,
        this.long,
        this.lat,
        this.verifyCode,
        this.codeMeli,
        this.mobile,
        this.state,
        this.name,
        this.typeActivity,
        this.token,
        // this.notifToken,
        this.carDetails,
        this.familyNumber
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // credit = json['credit'];
    code = json['code'];
    introCode = json['intro_code'];
    hasDocument = json['has_documents'];
    hasCarDetails = json['has_car_details'];
    hasInfoUser = json['has_info_user'];
    hasInfoBank = json['has_info_bank'];
    hasAllInfoUser = json['has_profile'];
    description = json['description'];
    familyNumber = json['family_number'];
    tokenFCM = json['fcm_token']!=null? json['fcm_token']:null;
    gender=  json['gender'] != null
        ? new DocDetail.fromJson(json['gender'])
        : null;
    if (json['rate_user'] != null) {
      rateList = <RateClub>[].obs;
      json['rate_user'].forEach((v) {
        rateList.add(new RateClub.fromJson(v));
      });
      print('rate length>>>${rateList.length}');
      calculateRate();
      calCost();
    }
    if( json['car_tag']!=null){

      plak= json['car_tag'];
      print('number>>${plak}');
    }
    statusDriver= json['state_approval'] != null
        ? new DocDetail.fromJson(json['state_approval'])
        : null;
    certificateValidity = json['certificate_validity'] ;
    certificatDate = json['certificat_date'] != null
        ? new Date.fromJson(json['certificat_date'])
        : null;
    image.value = json['image'] != null ? json['image'] : '';
    state = json['state']!=null?json['state']:false;
    typeActivity = json['type_activity'] != null
        ? new Services.fromJson(json['type_activity'])
        : null;
    certificateType = json['certificate_type'] != null
        ? new DocDetail.fromJson(json['certificate_type'])
        : null;
    if (json['parent_type'] != null) {
      parentType = new Services.fromJson(json['parent_type']);
    } else {
      parentType = null;
    }
    // numberLicence = json['number_licence'];
    long = json['long'];
    lat = json['lat'];
    verifyCode = json['verify_code'];
    removable = json['removable'];
    unremovable = json['unremovable'];
    codeMeli = json['code_meli'];
    mobile = json['mobile'];
    name = json['name'];
    token = json['token'];
    // notifToken = json['notif_token'];
    print('car detail>>>${ json['car_details']}');
    if (json['car_details'] != null && json['car_details'].length!=0 ) {
      carDetails = <CarDetail>[];
      UserController.carDetails=CarDetail();
        carDetails!.add( new CarDetail.fromJson(json['car_details'][0]));
        UserController.carDetails=new CarDetail.fromJson(json['car_details'][0]);
    }
    if (json['car_detail'] != null) {
      UserController.carDetails=CarDetail();
        UserController.carDetails=new CarDetail.fromJson(json['car_detail']);
    }
    if (json['documents'] != null) {
      // documents.value = <DriverDocument>[];
      json['documents'].forEach((v) {
        // documents.add(new DriverDocument.fromJson(v));
        document.value=DriverDocument.fromJson(v);
      });
    }

    if (json['wallet'] != null) {
      wallet = <Wallet>[].obs;
      json['wallet'].forEach((v) {
        wallet.add(new Wallet.fromJson(v));
      });
      print('wallet length>>>${wallet.length}');
      calculateCredit();
    }
    if (json['info_bank'] != null) {
      infoBank = <BankInfo>[];
      json['info_bank'].forEach((v) {
        infoBank.add(new BankInfo.fromJson(v));
      });
      print('info bank length>>>${infoBank.length}');
    }

    if (json['info_bank'] != null) {
      json['info_bank'].forEach((v) {
        UserController.infoBank = BankInfo.fromJson(v);
      });
    }
      }
  User.fromJsonSoket(Map<String, dynamic> json) {
    id = json['id'];
    // credit = json['credit'];
    code = json['code'];
    gender=  json['gender'] != null
        ? new DocDetail.fromJson(json['gender'])
        : null;
    introCode=json['intro_code'];
    hasDocument = json['has_documents'];
    hasCarDetails = json['has_car_details'];
    hasInfoUser = json['has_info_user'];
    description = json['description'];
    hasInfoBank = json['has_info_bank'];
    hasAllInfoUser = json['has_profile'];
    familyNumber = json['family_number'];
    if (json['rate_user'] != null) {
      rateList = <RateClub>[].obs;
      json['rate_user'].forEach((v) {
        rateList.add(new RateClub.fromJson(v));
      });
      print('rate length>>>${rateList.length}');
      calculateRate();
      calCost();
    }
    if( json['car_tag']!=null){

      plak=json['car_tag'];
    }
    statusDriver=  json['status_driver'] != null
        ? new DocDetail.fromJson(json['status_driver'])
        : null;
    certificateValidity = json['certificate_validity'] ;


    certificatDate = json['certificat_date'] != null
        ? new Date.fromJson(json['certificat_date'])
        : null;
    image.value = json['image'] != null ? json['image']: '';
    if(json['state']=='1'){
      state = true;
    }
    else if(json['state']==null||json['state']=='1' ){
      state = false;
    }
    tokenFCM = json['fcm_token']!=null? json['fcm_token']:null;

    typeActivity = json['type_activity'] != null
        ? new Services.fromJson(json['type_activity'])
        : null;
    if (json['parent_type'] != null) {
      parentType = new Services.fromJson(json['parent_type']);
    } else {
      parentType = null;
    }
    certificateType = json['certificate_type'] != null
        ? new DocDetail.fromJson(json['certificate_type'])
        : null;
    // numberLicence = json['number_licence'];
    long = json['long'];
    lat = json['lat'];
    verifyCode = json['verify_code'];
    codeMeli = json['code_meli'];
    mobile = json['mobile'];
    name = json['name'];
    token = json['token'];
    // notifToken = json['notif_token'];
    if (json['car_details'] != null) {
      carDetails = <CarDetail>[];
      json['car_details'].forEach((v) {
        carDetails!.add(new CarDetail.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      // documents.value = <DriverDocument>[];
      json['documents'].forEach((v) {
        document.value=DriverDocument.fromJson(v);

        // documents.add(new DriverDocument.fromJson(v));
      });
    }
    if (json['wallet'] != null) {
      wallet = <Wallet>[].obs;
      json['wallet'].forEach((v) {
        wallet.add(new Wallet.fromJson(v));
      });
      calculateCredit();
    }

    if (json['info_bank'] != null) {
      infoBank = <BankInfo>[];
      json['info_bank'].forEach((v) {
        infoBank.add(new BankInfo.fromJson(v));
      });
      print('info bank length>>>${infoBank.length}');
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.certificateType?.id != null) {
      data['certificate_type'] = this.certificateType!.id;
    }
    if(this.gender!=null){
      data['gender'] =  this.gender!.id;
    }
    // data['certificate_type'] = this.certificateType!.id;
    if(this.certificatDate?.main !=null){
      data['certificat_date'] = '${this.certificatDate!.year}/${this.certificatDate!.month.toString().padLeft(2, '0')}/${this.certificatDate!.day}';
    }
    else{
      data['certificat_date'] = this.dateCertificate;
    }
    data['certificate_validity'] = this.certificateValidity;

    if(this.typeActivity!=null){
      data['type_activity'] =  this.typeActivity!.id;
    }
    if (this.parentType != null) {
      data['parent_type'] = this.parentType!.id;
    }
    // data['number_licence'] = this.numberLicence;
    data['car_tag']=this.plak;
    data['intro_code'] = this.introCode;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['verify_code'] = this.verifyCode;
    data['code_meli'] = this.codeMeli;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['family_number'] = this.familyNumber;
    data['state'] = this.state;
    return data;
  }
  calculateCredit(){
    int increase=0;
    int decrease=0;
    creditUser.value=0;
    for(Wallet w in wallet){
      if(w.type!.id==1 || w.type!.id==3){
        print('wallettt');
        increase+=int.parse(w.price.toString());
       print('creditUser>>${increase}');
      }
      else{
        decrease+=int.parse(w.price.toString());
      }
    }
    creditUser.value=increase-decrease;
  }
  calculateRate(){
    int increase=0;
    int decrease=0;
    rate.value=0;
    for(RateClub r in rateList){
      if(r.type!.id==1){
        increase+=r.count!;
      }
      else{
        decrease+=r.count!;
      }
    }
    rate.value=increase-decrease;
    print('rate is >>${rate.value}');

  }
  calCost(){
    costRate=0;
    for (var rate in rateList){
      if(rate.type!.id==1)
        costRate+=(rate.cost!)*(rate.count!);
    }
    print('rate cost is >>${costRate}');
  }
}


