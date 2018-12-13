import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/config;

endpoint http:Client clientEndpoint {
    url: "http://api.hooksdata.io/v1/fetch?api_key="+config:getAsString("apiKey")
};

public function main() {

    // http:Request req = new; 
    // json jsonMsg = {"query": "SELECT * FROM EpisodesByTVShow(name = 'Game of Thrones')"};
    string value = "Game of Thrones";
    string data = string `SELECT * FROM EpisodesByTVShow(name = '{{value}}')`;
    io:print(data);
    // req.setJsonPayload(jsonMsg);
    // var response = clientEndpoint->post("", req);

    // match response {
    //     http:Response resp => {
    //         var msg = resp.getJsonPayload();
    //         match msg {
    //             json jsonPayload => {
    //                 io:println(jsonPayload);
    //             }
    //             error err => {io:println("Hello");}
    //         }
    //     }
    //     error err => {log:printError(err.message, err = err);}
    // }
}
