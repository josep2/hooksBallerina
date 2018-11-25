import ballerina/http;
import ballerina/io;
import ballerina/log;

endpoint http:Client clientEndpoint {
    url: "https://httpbin.org"
};

public function main() {
    http:Request req = new; 
    var response = clientEndpoint->get("/get");

    match response {
        http:Response resp => {
            var msg = resp.getJsonPayload();
            match msg {
                json jsonPayload => {
                    io:println(jsonPayload);
                }
                error err => {log:printError(err.message, err = err);}
            }
        }
        error err => {log:printError(err.message, err = err);}
    }
}
