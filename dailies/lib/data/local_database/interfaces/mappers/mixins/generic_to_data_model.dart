mixin GenericToDataModelMixin<TDataModelType, TDomainModelType> {
  TDataModelType toDataModel(TDomainModelType domainModel);
}
