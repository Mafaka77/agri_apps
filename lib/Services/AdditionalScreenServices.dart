import 'dart:io';

import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/FarmerAdditionalDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerSchemeApplied.dart';
import 'package:agri_farmers_app/Routes.dart';
import 'package:dio/dio.dart';
import '../Helpers/Repository.dart';

class AdditionalScreenServices extends BaseService {
  late Repository repository;
  AdditionalScreenServices() {
    repository = Repository();
  }

  getScheme() async {
    var data = await repository.readData('schemes');
    return data;
  }

  uploadDocuments(File? file) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file!.path),
      });
      var response =
          await client.post(Routes.UPLOAD_ADDITIONAL_FILE, data: formData);
      var data = response.data['data'];
      return data;
    } catch (ex) {
      print(ex);
    }
  }

  submitAdditionalDetails(
      FarmerAdditionalDetailModel model, List schemeApplied) async {
    try {
      var response = await client.post(
        Routes.SUBMIT_ADDITIONAL_DETAILS,
        data: {
          'data': model.toMap(),
          'scheme': schemeApplied,
        },
      );
      return response.data;
    } catch (ex) {
      return ex;
    }
  }

  Future<FarmerAdditionalDetailModel> getAdditionalDetails(int id) async {
    try {
      var response = await client.get(Routes.GET_ADDITIONAL_DETAIL(id));
      var data = response.data['data'];
      return FarmerAdditionalDetailModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<FarmerSchemeApplied>> getFarmerScheme(int id) async {
    try {
      var response = await client.get(Routes.GET_FARMER_SCHEME(id));
      var data = response.data['data'];
      return FarmerSchemeApplied.fromJsonList(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  updateAdditionalDetail(int id, FarmerAdditionalDetailModel additional,
      List schemeApplied) async {
    try {
      var response =
          await client.put(Routes.UPDATE_ADDITIONAL_DETAILS(id), data: {
        'data': additional.toMap(),
        'scheme': schemeApplied,
      });
    } catch (ex) {
      print(ex);
    }
  }

  deleteAdditionalDetail(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_ADDITIONAL_DETAIL(id));
      return response.data;
    } catch (ex) {
      return ex;
    }
  }
}
