abstract class GenericCRUDRepository<T> {
  Future<int> insert(T object);
  Future<bool> update(T updatedObject);
  Future<int> deleteById(int id);
  Future<T> getById(int id);
}
