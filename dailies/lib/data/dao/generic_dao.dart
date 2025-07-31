abstract class GenericDao<TGetType, TInsertType> {
  Future<int> insertEntry(TInsertType object);
  Future<int> deleteEntryById(int id);
  Future<bool> updateEntry(TInsertType updatedObject);
  Future<TGetType?> getEntryById(int id);
}
