import 'package:dailies/data/local_database/interfaces/dao/generic_dao.dart';
import 'package:dailies/data/local_database/interfaces/mapper/model_mapper.dart';
import 'package:dailies/data/repositories/crud_operations_mixin.dart';

class EventRepository with CRUDOperationsMixin {
  final GenericDao _dao;
  final ModelMapper _mapper;

  EventRepository({required GenericDao dao, required ModelMapper mapper})
    : _dao = dao,
      _mapper = mapper;

  @override
  GenericDao get dao => _dao;

  @override
  ModelMapper get mapper => _mapper;
}
