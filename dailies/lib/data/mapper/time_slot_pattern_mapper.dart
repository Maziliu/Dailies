import 'package:dailies/data/mapper/model_mapper.dart';

abstract class TimeSlotPatternMapper<
  TIncomingDatabaseModel,
  TOutgoingDatabaseModel
>
    extends ModelMapper<TIncomingDatabaseModel, TOutgoingDatabaseModel> {}
