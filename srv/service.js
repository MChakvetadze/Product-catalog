import { DEFAULT_STATE, getStockState } from "./utils.js";

export default (srv) => {

    srv.before(["CREATE"], "Products", (req) => {
        const data = req.data;

        if (!data) return;

        const {singlePrice, stockItems,supplier_ID,category_ID, status_ID } = data;


        // Stock quantity and price can not be negative
        if (stockItems < 0) {
            return req.reject(
                400,
                "Stock Items cannot be negative."
            );
        }

        if (singlePrice < 0) {
            return req.reject(
                400,
                "Single Price cannot be negative."
            );
        }


        // Set default state.
        if(!singlePrice) data.singlePrice = DEFAULT_STATE.singlePrice;
        if(!stockItems) data.stockItems = DEFAULT_STATE.stockItems;
        if(!supplier_ID) data.supplier_ID = DEFAULT_STATE.supplier_ID;
        if(!category_ID) data.category_ID = DEFAULT_STATE.category_ID;
        if(!status_ID) data.status_ID = DEFAULT_STATE.status_ID;
        

    });

       srv.before(["UPDATE"], "Products", (req) => {
        const data = req.data;
        if (!data) return;
        const stockItems = data.stockItems;

        if (stockItems !== undefined) {
            const stockState = getStockState(stockItems);
            // Sync status to quantity of sotck items.
            if (stockState) data.status_ID = stockState.status_ID;
        }
    });


    srv.after("READ", "Products", (results) => {
        const items = Array.isArray(results)
            ? results
            : [results];

        items.forEach((item) => {
            const stockState = getStockState(item.stockItems);

            if (!stockState) return;

            item.criticality = stockState.criticality;
        });
    });

};