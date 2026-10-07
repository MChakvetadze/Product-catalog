namespace my.demo;

using { cuid, managed } from '@sap/cds/common';

entity Products : cuid, managed {
    productName : String(100) not null;
    description : String(500);

    supplier : Association to Suppliers;
    category : Association to Categories;
    status   : Association to ProductStatuses;

    stockItems : Integer;
    unit       : String(20);

    singlePrice : Decimal(15,2);

    totalPrice : Decimal(15,2) =
        stockItems * singlePrice;

    virtual criticality : Integer;
}

@cds.odata.valuelist
entity ProductStatuses {
    key ID : String(20);
    name   : String(50);
}

@cds.odata.valuelist
entity Suppliers {
    key ID : String(20);
    name   : String(100);
}


@cds.odata.valuelist
entity Categories {
    key ID : String(20);
    name   : String(100);
}