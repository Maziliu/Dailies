import 'package:dailies/data/models/app_model.dart';

abstract class ModelMapper<TInputModel, TOutputModel> {
  AppModel convertOutputToAppModel(TOutputModel outputModel);
  TInputModel convertAppModelToInputModel(AppModel appModel);
}
