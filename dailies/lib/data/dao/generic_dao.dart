abstract class GenericDao<TIncomingDatabaseModel, TOutgoingDatabaseModel> {
  Future<int> insertEntry(TOutgoingDatabaseModel object);
  Future<int> deleteEntryById(int id);
  Future<bool> updateEntry(TOutgoingDatabaseModel updatedObject);
  Future<TIncomingDatabaseModel?> getEntryById(int id);
}
