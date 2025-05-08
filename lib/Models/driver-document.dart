
class DriverDocument {
  var id;
  String? onCertificate;
  String? backCarCard;
  String? onCarCard;
  String? docAddition;

  DriverDocument(
      {this.id, this.onCertificate, this.backCarCard, this.onCarCard});

  DriverDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onCertificate = json['on_certificate'] != null ?json['on_certificate'] : null;
    backCarCard = json['back_car_card'] != null ? json['back_car_card'] : null;
    onCarCard = json['on_car_card'] != null ? json['on_car_card'] : null;
    docAddition = json['additional_documents'] != null ? json['additional_documents'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onCertificate != null) {
      data['on_certificate'] = this.onCertificate;
    }
    if (this.backCarCard != null) {
      data['back_car_card'] = this.backCarCard;
    }
    if (this.onCarCard != null) {
      data['on_car_card'] = this.onCarCard;
    }
    if (this.docAddition != null) {
      data['additional_documents'] = this.docAddition;
    }
    return data;
  }
}