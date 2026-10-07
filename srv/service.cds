using my.demo from '../db/schema';

service ProductCatalogService @(requires: 'authenticated-user') {

    @(restrict: [
        { grant: ['READ'], to: ['support', 'admin'] },
        { grant: ['CREATE', 'UPDATE', 'DELETE'], to: ['admin'] }
    ])
    @odata.draft.enabled
    entity Products as projection on demo.Products;


    @readonly
    entity Suppliers as projection on demo.Suppliers;


    @readonly
    entity Categories as projection on demo.Categories;

    @readonly 
    entity ProductStatuses as projection on demo.ProductStatuses;
}