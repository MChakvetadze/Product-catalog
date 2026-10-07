export const getStockState = (stockItems) => {
    if (stockItems == null) return null;

    if (stockItems === 0) {
        return {
            status_ID: "DISCONTINUED",
            criticality: 1
        };
    }

    if (stockItems <= 10) {
        return {
            status_ID: "LOW_STOCK",
            criticality: 2
        };
    }

    return {
        status_ID: "ACTIVE",
        criticality: 3
    };
};


export const DEFAULT_STATE = {
    singlePrice: 10,
    stockItems: 20,
    supplier_ID: "SUP001",
    category_ID: "COMPUTERS",
    status_ID: "ACTIVE"
};