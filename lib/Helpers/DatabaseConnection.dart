import 'package:agri_farmers_app/Data/AgriLandData.dart';
import 'package:agri_farmers_app/Data/AnimalHusbandryData.dart';
import 'package:agri_farmers_app/Data/Caste.dart';
import 'package:agri_farmers_app/Data/District.dart';
import 'package:agri_farmers_app/Data/Fisheries.dart';
import 'package:agri_farmers_app/Data/HorticultureQuery.dart';
import 'package:agri_farmers_app/Data/LandWaterData.dart';
import 'package:agri_farmers_app/Data/ResourceQuery.dart';
import 'package:agri_farmers_app/Data/GenderData.dart';
import 'package:agri_farmers_app/Data/Scheme.dart';
import 'package:agri_farmers_app/Data/SericultureData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'agri1.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(ResourceQuery().farmersTable);
    await database.execute(ResourceQuery().farmerBankDetails);
    await database.execute(District().districtTable);
    await database.execute(ResourceQuery().farmerCategoryTable);
    await database.execute(GenderData().genderTable);
    await database.execute(CasteData().casteTable);
    await database.execute(District().subDivisiontable);
    await database.execute(District().rdBlockTable);
    await database.execute(District().villageTable);
    await database.execute(AgriLandData().landHoldingTable);
    await database.execute(AgriLandData().ownershipType);
    await database.execute(AgriLandData().irrigationInfrastructureTable);
    await database.execute(AgriLandData().farmEquipmentTable);
    await database.execute(AgriLandData().kharifCropTable);
    await database.execute(AgriLandData().rabiCropTable);
    await database.execute(SchemeData().schemeTable);
    await database.execute(HorticultureQuery().plantationQuery);
    await database.execute(HorticultureQuery().orchardsTable);
    await database.execute(HorticultureQuery().greenHousePlantQuery);
    await database.execute(LandWaterData().landCropsTable);
    await database.execute(Fisheries().fishTable);
    await database.execute(AnimalHusbandry().livestockTable);
    await database.execute(AnimalHusbandry().typeOfFarmTable);
    await database.execute(AnimalHusbandry().typeOfBreedTable);
    await database.execute(AnimalHusbandry().typeOfPoultryBreedTable);
    await database.execute(AnimalHusbandry().typeOfPoultryFarmTable);
    await database.execute(SericultureData().silkwormTable);
  }
}
