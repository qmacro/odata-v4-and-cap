using northwind from '../db/schema';

service CustomAggregates {
  @Aggregation.CustomAggregate#UnitsInStock : 'Edm.Decimal'
  entity Products as projection on northwind.Products {
    *,

    @Aggregation.default: #SUM 
    UnitsInStock

  }
}
