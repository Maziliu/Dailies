import 'package:dailies/data/models/app_model.dart';

abstract class ModelMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  AppModel convertIncomingDatabaseModelToAppModel(TIncomingDatabaseModel incomingDatabaseModel);
  TOutgoingDatabaseModel convertAppModelToOutgoingDatabaseModel(AppModel appModel);
}
