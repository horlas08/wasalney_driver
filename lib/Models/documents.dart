import 'car-detail.dart';
import 'documents-detail.dart';

class Document {
  List<DocDetail>? fuelType;
  List<DocDetail>? certificatesTypes;
  // List<DocDetail>? carModels;
  List<DocDetail>? banks;

  Document({this.fuelType, this.certificatesTypes});

  Document.fromJson(Map<String, dynamic> json) {
    if (json['fuelType'] != null) {
      fuelType = <DocDetail>[];
      json['fuelType'].forEach((v) {
        fuelType!.add(new DocDetail.fromJson(v));
      });
    }
    if (json['certificatesTypes'] != null) {
      certificatesTypes = <DocDetail>[];
      json['certificatesTypes'].forEach((v) {
        certificatesTypes!.add(new DocDetail.fromJson(v));
      });
    }

    if (json['banks'] != null) {
      banks = <DocDetail>[];
      json['banks'].forEach((v) {
        banks!.add(new DocDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fuelType != null) {
      data['fuelType'] = this.fuelType!.map((v) => v.toJson()).toList();
    }
    if (this.certificatesTypes != null) {
      data['certificatesTypes'] =
          this.certificatesTypes!.map((v) => v.toJson()).toList();
    }

    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

