import 'dart:convert';

class FarmerBankDetailModel {
  int? id;
  String? bank_name;
  String? branch_name;
  String? account_number;
  String? ifsc_code;
  int? farmers_id;
  FarmerBankDetailModel({
    this.id,
    this.bank_name,
    this.branch_name,
    this.account_number,
    this.ifsc_code,
    this.farmers_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank_name': bank_name,
      'branch_name': branch_name,
      'account_number': account_number,
      'ifsc_code': ifsc_code,
      'farmers_id': farmers_id
    };
  }

  factory FarmerBankDetailModel.fromMap(Map<String, dynamic> map) {
    return FarmerBankDetailModel(
      id: map['id']?.toInt(),
      bank_name: map['bank_name'],
      branch_name: map['branch_name'],
      account_number: map['account_number'],
      ifsc_code: map['ifsc_code'],
      farmers_id: map['farmers_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmerBankDetailModel.fromJson(String source) =>
      FarmerBankDetailModel.fromMap(json.decode(source));
  static List<FarmerBankDetailModel> fromJsonList(List list) {
    return list.map((e) => FarmerBankDetailModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'FarmerBankDetailModel(id: $id, bank_name: $bank_name, branch_name: $branch_name, account_number: $account_number, ifsc_code: $ifsc_code)';
  }
}
