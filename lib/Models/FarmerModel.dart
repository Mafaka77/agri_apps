import 'dart:convert';

import 'package:agri_farmers_app/Models/CasteModel.dart';
import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmerBankDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerCategoryModel.dart';
import 'package:agri_farmers_app/Models/GenderModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';

class FarmerModel {
  int? id;
  int? ids;
  String? full_name;
  String? dob;
  int? caste_id;
  int? gender_id;
  String? relationship;
  String? relationship_name;
  String? phone_no;
  String? aadhaar_no;
  String? aadhaar_verify_type;
  String? voter_no;
  String? education_qualification;
  int? farmer_category_id;
  String? is_farming_main_income;
  String? other_income;
  String? state_lgd_code;
  String? village_lgd_code;
  String? status;
  String? verification;
  int? user_id;
  int? district_id;
  int? sub_division_id;
  int? block_id;
  int? village_id;
  String? account_number;
  String? bank_name;
  String? branch_name;
  String? ifsc_code;
  String? f_category_name;
  String? district_name;
  int? farmers_id;
  late CasteModel? caste;
  late GenderModel? gender;
  late FarmerCategoryModel? category;
  late DistrictModel? district;
  late SubDivisionModel? subDivision;
  late RdBlockModel? rdBlock;
  late VillageModel? village;
  late FarmerBankDetailModel? bankDetail;
  FarmerModel({
    this.id,
    this.ids,
    this.full_name,
    this.dob,
    this.caste_id,
    this.gender_id,
    this.relationship,
    this.relationship_name,
    this.phone_no,
    this.aadhaar_no,
    this.aadhaar_verify_type,
    this.voter_no,
    this.education_qualification,
    this.farmer_category_id,
    this.is_farming_main_income,
    this.other_income,
    this.state_lgd_code,
    this.village_lgd_code,
    this.status,
    this.verification,
    this.user_id,
    this.district_id,
    this.sub_division_id,
    this.block_id,
    this.village_id,
    this.account_number,
    this.bank_name,
    this.branch_name,
    this.ifsc_code,
    this.f_category_name,
    this.district_name,
    this.farmers_id,
    this.caste,
    this.gender,
    this.category,
    this.district,
    this.subDivision,
    this.rdBlock,
    this.village,
    this.bankDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ids': ids,
      'full_name': full_name,
      'dob': dob,
      'caste_id': caste_id,
      'gender_id': gender_id,
      'relationship': relationship,
      'relationship_name': relationship_name,
      'phone_no': phone_no,
      'aadhaar_no': aadhaar_no,
      'aadhaar_verify_type': aadhaar_verify_type,
      'voter_no': voter_no,
      'education_qualification': education_qualification,
      'farmer_category_id': farmer_category_id,
      'is_farming_main_income': is_farming_main_income,
      'other_income': other_income,
      'state_lgd_code': state_lgd_code,
      'village_lgd_code': village_lgd_code,
      'status': status,
      'user_id': user_id,
      'district_id': district_id,
      'sub_division_id': sub_division_id,
      'block_id': block_id,
      'village_id': village_id,
      'bank_name': bank_name,
      'branch_name': branch_name,
      'account_number': account_number,
      'ifsc_code': ifsc_code,
    };
  }

  Map<String, dynamic> bankToMap() {
    return {
      'bank_name': bank_name,
      'account_number': account_number,
      'branch_name': branch_name,
      'ifsc_code': ifsc_code,
      'farmers_id': farmers_id
    };
  }

  factory FarmerModel.fromMap(Map<String, dynamic> map) {
    return FarmerModel(
      id: map['id'],
      ids: map['ids'],
      full_name: map['full_name'],
      dob: map['dob'],
      caste_id: map['caste_id']?.toInt() ?? 0,
      gender_id: map['gender_id']?.toInt() ?? 0,
      relationship: map['relationship'],
      relationship_name: map['relationship_name'],
      phone_no: map['phone_no'],
      aadhaar_no: map['aadhaar_no'],
      aadhaar_verify_type: map['aadhaar_verify_type'],
      voter_no: map['voter_no'],
      education_qualification: map['education_qualification'],
      farmer_category_id: map['farmer_category_id']?.toInt() ?? 0,
      is_farming_main_income: map['is_farming_main_income'] == 1 ? 'Yes' : 'No',
      other_income: map['other_income'],
      state_lgd_code: map['state_lgd_code'],
      village_lgd_code: map['village_lgd_code'],
      status: map['status'],
      user_id: map['user_id']?.toInt() ?? 0,
      district_id: map['district_id']?.toInt() ?? 0,
      sub_division_id: map['sub_division_id']?.toInt() ?? 0,
      block_id: map['block_id']?.toInt() ?? 0,
      village_id: map['village_id']?.toInt() ?? 0,
      f_category_name: map['f_category_name'],
      district_name: map['district_name'],
    );
  }
  factory FarmerModel.fromOnlineMap(Map<String, dynamic> map) {
    return FarmerModel(
        id: map['id'],
        ids: map['ids'],
        full_name: map['full_name'],
        dob: map['dob'],
        caste_id: map['caste_id']?.toInt() ?? 0,
        gender_id: map['gender_id']?.toInt() ?? 0,
        relationship: map['relationship'],
        relationship_name: map['relationship_name'],
        phone_no: map['phone_no'],
        aadhaar_no: map['aadhaar_no'],
        aadhaar_verify_type: map['aadhaar_verify_type'],
        voter_no: map['voter_no'],
        education_qualification: map['education_qualification'],
        farmer_category_id: map['farmer_category_id']?.toInt() ?? 0,
        is_farming_main_income:
            map['is_farming_main_income'] == 1 ? 'Yes' : 'No',
        other_income: map['other_income'] ?? '',
        state_lgd_code: map['state_lgd_code'],
        village_lgd_code: map['village_lgd_code'],
        status: map['status'],
        verification: map['verification'],
        user_id: map['user_id']?.toInt() ?? 0,
        district_id: map['district_id']?.toInt() ?? 0,
        sub_division_id: map['sub_division_id']?.toInt() ?? 0,
        block_id: map['block_id']?.toInt() ?? 0,
        village_id: map['village_id']?.toInt() ?? 0,
        f_category_name: map['f_category_name'],
        district_name: map['district']['district_name'],
        caste: CasteModel.fromMap(
          map['caste'],
        ),
        gender: GenderModel.fromMap(map['gender']),
        category: FarmerCategoryModel.fromMap(map['farmer_category']),
        district: DistrictModel.fromMap(map['district']),
        subDivision: SubDivisionModel.fromMap(map['sub_division']),
        rdBlock: RdBlockModel.fromMap(map['block']),
        village: VillageModel.fromMap(map['village']),
        bankDetail: FarmerBankDetailModel.fromMap(map['farmer_bank_details']));
  }

  static List<FarmerModel> fromJsonList(List list) {
    return list.map((e) => FarmerModel.fromMap(e)).toList();
  }

  static List<FarmerModel> fromOnlineJsonList(List list) {
    return list.map((e) => FarmerModel.fromOnlineMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory FarmerModel.fromJson(String source) =>
      FarmerModel.fromMap(json.decode(source));
}
