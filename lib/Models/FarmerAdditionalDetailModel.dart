import 'dart:convert';

class FarmerAdditionalDetailModel {
  int? id;
  String? ration_card_number;
  String? ration_card_path;
  int? is_kcc_availed;
  String? kcc_card_no;
  String? kcc_renew_or_new;
  String? bank_name;
  String? branch_name;
  String? year_of_amount_sanction;
  String? amount_sanction;
  String? aadhaar_card_path;
  String? bank_passbook_path;
  String? date_of_data_collection;
  String? remarks;
  int? farmers_id;
  FarmerAdditionalDetailModel({
    this.id,
    this.ration_card_number,
    this.ration_card_path,
    this.is_kcc_availed,
    this.kcc_card_no,
    this.kcc_renew_or_new,
    this.bank_name,
    this.branch_name,
    this.year_of_amount_sanction,
    this.amount_sanction,
    this.aadhaar_card_path,
    this.bank_passbook_path,
    this.date_of_data_collection,
    this.remarks,
    this.farmers_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ration_card_number': ration_card_number,
      'ration_card_path': ration_card_path,
      'is_kcc_availed': is_kcc_availed,
      'kcc_card_no': kcc_card_no,
      'kcc_renew_or_new': kcc_renew_or_new,
      'bank_name': bank_name,
      'branch_name': branch_name,
      'year_of_amount_sanction': year_of_amount_sanction,
      'amount_sanction': amount_sanction,
      'aadhaar_card_path': aadhaar_card_path,
      'bank_passbook_path': bank_passbook_path,
      'date_of_data_collection': date_of_data_collection,
      'remarks': remarks,
      'farmers_id': farmers_id,
    };
  }

  factory FarmerAdditionalDetailModel.fromMap(Map<String, dynamic> map) {
    return FarmerAdditionalDetailModel(
      id: map['id']?.toInt(),
      ration_card_number: map['ration_card_number'],
      ration_card_path: map['ration_card_path'],
      is_kcc_availed: map['is_kcc_availed'],
      kcc_card_no: map['kcc_card_no'] ?? '',
      kcc_renew_or_new: map['kcc_renew_or_new'] ?? '',
      bank_name: map['bank_name'] ?? '',
      branch_name: map['branch_name'] ?? '',
      year_of_amount_sanction: map['year_of_amount_sanction'] ?? '',
      amount_sanction: map['amount_sanction'] ?? '',
      aadhaar_card_path: map['aadhaar_card_path'],
      bank_passbook_path: map['bank_passbook_path'],
      date_of_data_collection: map['date_of_data_collection'],
      remarks: map['remarks'] ?? '',
      farmers_id: map['farmers_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmerAdditionalDetailModel.fromJson(String source) =>
      FarmerAdditionalDetailModel.fromMap(json.decode(source));

  static List<FarmerAdditionalDetailModel> fromJsonList(List list) {
    return list.map((e) => FarmerAdditionalDetailModel.fromMap(e)).toList();
  }
}
