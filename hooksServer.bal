import ballerina/http;

endpoint http:Listener listener {
    port:9090
};

// Order management is done using an in memory map.
// Add some sample orders to 'ordersMap' at startup.
map<json> ordersMap;

// RESTful service.
@http:ServiceConfig { basePath: "/tvShows" }
service<http:Service> orderMgt bind listener {

    // Resource that handles the HTTP GET requests that are directed to a specific
    // order using path '/order/<orderId>'.
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/show/{showName}"
    }
    findOrder(endpoint client, http:Request req, string showName) {
        // Find the requested order from the map and retrieve it in JSON format.
        // json? payload = ordersMap[orderId];
        // http:Response response;
        // if (payload == null) {
            // payload = "Order : " + orderId + " cannot be found.";
        // }

        // Set the JSON payload in the outgoing response message.
        // response.setJsonPayload(untaint payload);

        // Send response to the client.
        _ = client->respond({"great": untaint showName});
    }



}