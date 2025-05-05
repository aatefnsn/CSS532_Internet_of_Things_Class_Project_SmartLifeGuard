var AWS = require('aws-sdk');
var sns = new AWS.SNS();

var SNSTopic = process.env.sns;
const client = new AWS.Rekognition();

var iotdata = new AWS.IotData({endpoint: "a3346r7tb872oq-ats.iot.us-west-2.amazonaws.com"});
var name;
var agelow;
var agehigh;

exports.handler = (event, context, callback) => {

  var matchedFace = 0;
  var unmatchedFace = 0;
  event.Records.forEach((record) => {


    // Kinesis data is base64 encoded so decode here
    const load = new Buffer(record.kinesis.data, 'base64').toString('ascii');
    console.log(load);
    const payload = JSON.parse(load);
    console.log(payload);
    console.log(payload.FaceSearchResponse);
    console.log(payload.FaceSearchResponse[0]);

    for(const p in payload.FaceSearchResponse[0]) {
      if (p.match("MatchedFaces")){
        if (typeof (p, ((((payload.FaceSearchResponse[0])[p])[0]))) !== "undefined"){
          name =((((payload.FaceSearchResponse[0])[p])[0]).Face).ExternalImageId;
          console.log (p, ((((payload.FaceSearchResponse[0])[p])[0]).Face).ExternalImageId);
          console.log("name is "+name);
        }
      }
    }

    if(payload.FaceSearchResponse != null)
    {
      payload.FaceSearchResponse.forEach((face) =>  {

        if(face.MatchedFaces != null &&
          Object.keys(face.MatchedFaces).length > 0)
          {
            matchedFace++;
          }
          else
          {
            unmatchedFace++;
          }
        });
      }
    });

    if(matchedFace > 0 || unmatchedFace > 0)
    {
      var params = {
        Message: matchedFace + ' Known Person(s) found ' + unmatchedFace + ' Unknown Person(s) on Video Feed', /* required */
        TopicArn: SNSTopic
      };
      sns.publish(params, function(err, data) {
        if (err){
          console.log(err, err.stack); // an error occurred
          callback(err);
        }
        else{
          console.log(data);           // successful response
          callback(null, `Successfully processed ${event.Records.length} records.`);
        }
      });

      if (name !== undefined && name.match("Lena")){

        const photo = 'Lena.jpg'
        const params3 = {
          Image: {
            S3Object: {
              Bucket: "faces532",
              Name: photo
            },
          },
          Attributes: ['ALL']
        }
        client.detectFaces(params3, function(err, response) {

          if (err) {
            console.log("Errrrrooooooor");
            console.log(err, err.stack); // an error occurred
          } else {
            console.log(`Detected faces for: ${photo}`)
            response.FaceDetails.forEach(data => {
              let low = data.AgeRange.Low
              agelow=low
              let high = data.AgeRange.High
              agehigh=high
              console.log(`The detected face is between: ${low} and ${high} years old`)
            }) // for response.faceDetails
          } //
        });

        var params2 = {
          topic: "/topic/CameraFace",
          payload: JSON.stringify({payload:name + " has been detected, whose age seems to be between " + agelow + " and "+ agehigh}),
          qos: 1
        };
        name="";
      }


      else if (name !== undefined && name.match("Henedy")){

        const photo = 'Henedy.jpeg'
        const params3 = {
          Image: {
            S3Object: {
              Bucket: "faces532",
              Name: photo
            },
          },
          Attributes: ['ALL']
        }
        client.detectFaces(params3, function(err, response) {

          if (err) {
            console.log(err, err.stack); // an error occurred
          } else {
            console.log(`Detected faces for: ${photo}`)
            response.FaceDetails.forEach(data => {
              let low = data.AgeRange.Low
              agelow=low
              let high = data.AgeRange.High
              agehigh=high
              console.log(`The detected face is between: ${low} and ${high} years old`)
            }) // for response.faceDetails
          } //
        });

        var params2 = {
          topic: "/topic/CameraFace",
          payload: JSON.stringify({payload:name + " has been detected, whose age seems to be between " + agelow + " and "+ agehigh}),
          qos: 1
        };
        name="";
      }

      else{
        var params2 = {
          topic: "/topic/CameraFace",
          payload: JSON.stringify({payload:name + " has been detected"}),
          qos: 1
        };
        name="";
      }

      return iotdata.publish(params2, function(err, data) {
        if(err){
          console.log(err);
        }
        else{
          console.log("Success, I guess.");
        }
      });
    }
  };
