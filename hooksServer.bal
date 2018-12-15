import ballerina/config;
import ballerina/http;
import ballerina/io;


endpoint http:Listener listener {
    port:9090
};

type Query record {
    string tvShow;
};

endpoint http:Client clientEndpoint {
    url: "http://api.hooksdata.io/v1/fetch?api_key="+config:getAsString("apiKey")
};


// RESTful service.
@http:ServiceConfig { basePath: "/tvShows" }
service<http:Service> tvShows bind listener {

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/show",
        body: "oblong",
        consumes: ["application/json"]
    }
    findShow(endpoint client, http:Request req, Query oblong) {
        
        http:Request outBoundRequest = new;

        io:println(oblong);

        var result = req.getJsonPayload();
        http:Response res = new;

        match result {
            json value => {
                json tvShow = check req.getJsonPayload();
                string dataSet = tvShow.tvShow.toString();
                string queryString = string `SELECT * FROM EpisodesByTVShow(name = '{{dataSet}}')`;
                json jsonMsg = {"query": queryString};
                outBoundRequest.setJsonPayload(untaint jsonMsg);
                http:Response response = check clientEndpoint->post("", outBoundRequest);
                json data = check response.getJsonPayload();
                res.setPayload(untaint data);
            }
            error err => {
                res.statusCode = 400;
                res.setPayload("JSON containted invalid data");
            }
        }
        _ = client->respond(res);
    }



}