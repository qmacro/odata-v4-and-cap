using northwind from '../db/schema';

service SingletonExample {

  @odata.singleton entity BestBargain as
    select from northwind.Products order by UnitPrice asc;

  entity Products as projection on northwind.Products

}
