const AWS = require('aws-sdk')

const config = new AWS.Config({
  accessKeyId: process.env.ACCESSKEYID,
  secretAccessKey: process.env.SECRETKEYACCESS,
  region: process.env.REGION,
  apiVersion: process.env.APIVERSION
})

const client = new AWS.Rekognition(config);

//Async function written around AWS function to allow Rekognition to process the information
//That way the lambda does not finish before the reponse is returned
//Time out is handled on the Lambda through AWS
function compareFaces(params) {
    return new Promise (resolve => {
        client.compareFaces(params, function(err, response) {
            if (err) {
                throw err
            } else {
                resolve(response);
            }
        })
    })
}

exports.handler = async (event, context, callback) => {
    
    let body
    
    //Parse Body of the request to usage
    //Return error otherwise
    if (event.body !== null && event.body !== undefined) {
        body = JSON.parse(event.body)
    } else {
        var res = {
            "statusCode": 500,
            "headers": {
                "Content-Type" : "application/json"
            },
            "body": {
                "message" : 'Internal Server Error'
            },
            "isBase64Encoded": false
        };
        console.log("failed to parse json")
        callback(null, res);
        return;
    }

    //Setup images to be sent to Rekognition
    var params = {
        "SourceImage": {
            "Bytes": Buffer.from(body.photo_source, 'base64')
        },
        "TargetImage": {
            "Bytes": Buffer.from(body.photo_target, 'base64')
        },
        "SimilarityThreshold": 0
    }
    
    //Attempt to get information from compareFaces with Rekognition
    try {
        var response = await compareFaces(params)

        var res = {
            "statusCode": 200,
            "headers": {
                "Content-Type" : "application/json"
            },
            "body": JSON.stringify(response),
            "isBase64Encoded": false
        };

        callback(null, res);
        return;

    } catch (err) {
        console.log(err, err.stack);
        return;
    }
    
};