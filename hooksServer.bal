import ballerina/http;
import ballerina/log;

// By default, Ballerina exposes an HTTP service via HTTP/1.1.

type Query record {
    string tvShow;
};

endpoint http:Client clientEndpoint {
    url: "http://api.hooksdata.io/v1/fetch?api_key="+config:getAsString("apiKey")
};

@http:ServiceConfig {
    basePath: "/"
}

service hello on new http:Listener(9090) {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/show"
        //body: "oblong",
        //consumes: ["application/json"]
    }

    // Resource functions are invoked with the HTTP caller and the incoming request as arguments.
    resource function sayHello(http:Caller caller, http:Request req) {
        // Send a response back to the caller.
        var result = clientEndpoint->post()
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }
}
