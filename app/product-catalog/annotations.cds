using ProductCatalogService as service from '../../srv/service';

annotate service.Products with {
    productName @title : 'Product';
    description @title : 'Description';

    supplier    @title : 'Supplier';
    category    @title : 'Category';
    status      @title : 'Status';

    stockItems  @title : 'Stock Items';
    unit        @title : 'Unit';
    singlePrice @title : 'Single Price';
    totalPrice  @title : 'Total Price';
};


annotate service.Products with {
    supplier @Common.ValueListWithFixedValues : true;
    category @Common.ValueListWithFixedValues : true;
    status @Common.ValueListWithFixedValues : true;
};



annotate service.Products with @(

    UI.HeaderInfo : {
        TypeName       : 'Product',
        TypeNamePlural : 'Products',
        Title          : {
            Value : productName
        },
        Description    : {
            Value : description
        }
    },


    UI.SelectionFields : [
        supplier_ID,
        category_ID,
        unit
    ],


    UI.LineItem : [
        {
            Value : productName,
            Label : 'Product'
        },
        {
            Value : supplier.name,
            Label : 'Supplier'
        },
        {
            Value : category.name,
            Label : 'Category'
        },
        {
            Value : stockItems,
            Label : 'Stock Items',
            Criticality : criticality
        },
        {
            Value : unit,
            Label : 'Unit'
        },
        {
            Value : singlePrice,
            Label : 'Single Price'
        },
        {
            Value : status.name,
            Label : 'Status',
            Criticality : criticality
        },
        {
            Value : totalPrice,
            Label : 'Total Price'
        }
    ],


    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#General'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Stock & Pricing',
            Target : '@UI.FieldGroup#Pricing'
        }
    ],


    UI.FieldGroup#General : {
        Data : [
            { Value : productName },
            { Value : description },
            { Value : supplier_ID },
            { Value : category_ID },
            { Value : status_ID }
        ]
    },

    UI.FieldGroup#Pricing : {
        Data : [
            {
                Value : stockItems,
                Criticality : criticality
            },
            {
                Value : unit
            },
            {
                Value : singlePrice
            },
            {
                Value : totalPrice
            }
        ]
    }

);