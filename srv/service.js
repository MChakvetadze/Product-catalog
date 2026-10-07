export default (srv) => {

    srv.before(["CREATE", "UPDATE"], "Products", (req) => {
        const data = req.data;

        if (!data) return;

        if (
            data.stockItems !== undefined &&
            data.stockItems < 0
        ) {
            return req.reject(
                400,
                "Stock Items cannot be negative."
            );
        }

        if (
            data.singlePrice !== undefined &&
            data.singlePrice < 0
        ) {
            return req.reject(
                400,
                "Single Price cannot be negative."
            );
        }
    });


    srv.after("READ", "Products", (results) => {
        const items = Array.isArray(results)
            ? results
            : [results];

        items.forEach((item) => {
            if (item.stockItems == null) return;

            if (item.stockItems <= 5) {
                item.criticality = 1;
                return;
            }

            if (item.stockItems <= 10) {
                item.criticality = 2;
                return;
            }

            item.criticality = 3;
        });
    });

};