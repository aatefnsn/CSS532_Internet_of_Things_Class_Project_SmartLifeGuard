Ahmed Nada

Department of Computer Science,

University of Washington - Bothell,

18115 Campus Way NE,

Bothell,

98011,

WA, USA

Email: anada@uw.edu

[^1]

IoT enabled Smart Lifeguard surveillance system for drowning detection
and prevention

*Abstract*--- Across the United States there has been a lot of fatal
drowning cases, mostly kids under the age of 10 years old. There has
been a lot of trials and efforts to solve this problem and try to come
up with a system that is able to detect and instantly notify a drowning
event. A lot of related work tried to resolve this issue by using under
water cameras, using ultrasonic waves as well as wearables. These
systems, however, come at the cost of complexity, scalability,
notification delay and range. As a result, this paper will be discussing
a state-of-the-art IoT surveillance system that uses existing cloud IoT
services and infrastructure. This paper talks about a Smart Lifeguard
Surveillance system based on IoT. The system relies on some vibration
and motion sensors that can be placed inside and around the pool to
detect any activity while the pool is unattended by parents or if no
lifeguard is on duty. The system can be activated and deactivated
through an iOS app to start and stop receiving alerts. The system also
can be integrated with camera system scattered around the pools or at
the pool entrance that can help identify pre-labelled faces and send
alerts if a pre-labeled face has been detected. The system relies on
various AWS cloud services like AWS IoT core, Simple Notification
Service (SNS), Simple Storage Service (S3), Lambda, Rekognition as well
as Kinesis video streams.

This system can be used at homes, private or at public pools and can
significantly reduce the number of incidents and fatalities. In this
paper it was proven that Smart Lifeguard surveillance system can detect
and alert of a drowning incident with a delay ranging between 2 and 9
seconds. Using the IoT services, the alerts can be received instantly
anywhere in the world through email or pushed notification on the iOS
app.

*Index Terms*---Alarming, Cloud services, Facial recognition, IoT,
Surveillance, Swimming pool

# INTRODUCTION

Internet of Things (IoT) is an ecosystem of internet connected devices.
Together with 5G development which allows for very little latency, the
capabilities are endless. Many entities are beginning to recognize the
true opportunities on the Internet of Things market and started to
provide cloud services that accelerated the development of thousands of
applications that touched everyone's lives. According to Statista
Research Department, 31 billion connected devices will be in use by 2025
which is a huge number and provides the opportunity for more ideas.
\[2\]

According to the United States Center for Disease Control (CDC), there
are around 3,536 fatal unintentional drownings (non-boating related)
annually in the United States--- about ten deaths per day \[6\]. In
addition to thousands of cases that are swimming pool related injuries
reported which received emergency care.

With every enhancement in Internet in terms of speed and bandwidth, IoT
is taking the market on a new node and knocking the door with new
opportunities of inventions. The purpose of this paper is to utilize the
widespread IoT systems and the existing cloud services. Using the
services that was not available a few years back, will allow for more
facial detection and recognition-based systems that were not possible
before. Advancement in IoT based application has become the state-of-the
art technology among the research due to the availability of Internet
everywhere. To make the application more user friendly, web-, android-
and iOS-based technologies have gained their importance in this
cutting-edge technology. The availability and reliability of the cloud
infrastructure for IoT application has had a tremendous positive impact
on the number of IoT applications and contributed to the widespread and
usability of these applications. The huge number of IoT use cases have
led a lot of cloud infrastructure companies to develop their own IoT
platform. In 2015 and 2016, Amazon and Microsoft announced their IoT
platforms, AWS IoT core and Azure IoT Hub, respectively. A lot of the
existing research did not fully utilize the capabilities of IoT to
address this problem.

In this paper we will be discussing the IoT based Smart Lifeguard system
which can provide peace of mind for parents who have kids at home, or
public pools when no lifeguards are on duty. The available systems
depend mainly on ultra-sonic waves that can be sent into the water to
early detect drowning situations; however, such a system is expensive to
install and might not be suitable for upgrades on older existing pools.
Also, requires a lot of costs for installation and maintenance.

Throughout the paper, we will detail the development of a Smart
Lifeguard system that provides a surveillance capability for private as
well as public pools. These swimming pools can be indoor or outdoor and
of any size. The system can be armed and unarmed. Once armed, Smart
Lifeguard can be used to provide surveillance and save lives.

The system provides real-time monitoring through AWS IoT services that
can push email notifications as well as push iOS mobile app alerts
through the Smart Lifeguard app. The Smart Lifeguard system provides a
24x7 video-surveillance and sensor system for the detection of dangerous
situations, Smart Lifeguard system can alert parents or personnel in a
fast and effective way, providing immediate and targeted help to the
person in distress.

The Smart Lifeguard system depends on several sensors and camera that
are attached to a Raspberry Pi. The sensors can vary from vibration,
tilt, or motion sensors, also, any camera that provides the needed
resolution can be used. This paper will also be comparing between the
different features with respect to notifications and alerts delay which
is crucial for our use case.

# Related Work

In previous papers, AWS Kinesis and AWS Rekognition were commonly used
for facial recognition-based surveillance. For example, in some related
work AWS Rekognition was setup to identify common faces at the door and
report the facial emotions. Also, a lot of other related work delt with
different sensors but not for the purpose of providing an IoT enabled
Lifeguard system.

Liu et al \[1\] used a complex system composed of ultrasonic
transmitters and receivers as well as wearable hydraulic pressure
detectors to detect drowning incidents. The system depends on the
outside of the pool receivers to analyze the signals coming from the
underwater ultrasonic receivers as well as the hydraulic detectors to
calculate the position of the person and calculate the speed by which
this person is drowning. If the system detects that a person needs help,
it notifies the lifeguards over the radio.

Alshabatat et al \[3\], used wearable wrist bands as well as under water
cameras for drowning detection. The underwater cameras were used to
train models for drowning detection together with the wristbands that
can measure heart rate and body depth under water. If the wristband and
underwater cameras detect a drowning incident, it sets off an alarm to
the lifeguards.

The limitation of these studies is the accuracy of the detected cases,
as it can give a lot of false positives. It also might not work for
pools that were not designed to have underwater cameras. The
over-the-radio notification system can only be used if there is an
on-duty lifeguard who is in the range of the radio signal. It does not
utilize the IoT techniques that are available and can provide better
surveillance systems.

According to the study done by Karthik et al \[4\], using wearables is
not recommended for drowning systems. Wearables in most cases can easily
be missed to wear, provide inaccurate results or they can fall easily
into the water. Wearables cannot be worn for the entire time or have a
drained battery.

In this project, we have decided to combine some well-known use cases
and techniques to enable a complete Lifeguard surveillance system. A
system that does not require a costly addition to the existing
infrastructure, and a system that can be easily installed. The Smart
Lifeguard can be scaled to include other ideas and use cases. This
project can send alerts to the app owner regardless of his location and
does not require an on-duty lifeguard. It also does not require any
wearables, can be armed and unarmed at any time.

![Graphical user interface Description automatically generated with
medium confidence](./media/image1.png){width="2.798135389326334in"
height="1.543066491688539in"}

Figure 1: Possible System architecture

The Smart Lifeguard described in this paper is relaying on some hardware
as well as AWS cloud services to provide the intended functionality, a
simple design of the system is shown in Figure 1. Smart Lifeguard uses
Raspberry Pi 4 with a few sensors attached to it on a bread board that
send signals to alert about a specific incident. In addition to the
sensors, attached to the Raspberry Pi a Raspberry Pi camera that is used
for sending frames to the AWS cloud services for facial detection and
recognition. The alerts are then sent to an iOS app that can loaded on
any device to start receiving the Smart Lifeguard system alerts.

For one part of the system to work, the Raspberry Pi is running a python
script that detects any signal on the RaspberryPi GPIO. The Raspberry Pi
is connected to the AWS IoT Core endpoint to be able to publish
incidents to the IoT core. The python script is configured to send MQTT
messages to AWS IoT Core if an incident has been detected on the
Raspberry Pi GPIO.

The iOS app running on the device is connected to the same IoT Core
endpoint and is subscribed to some topics that AWS Core IoT publishes
on. Once the Raspberry Pi fires the MQTT message towards the AWS IoT
Core, IoT Core republishes the received message on a topic that the iOS
app is subscribed to and consequently the iOS app gets notified and
alerts the user of the incident.

For the other part of the system to work, there is a Raspberry Pi Camera
attached to the Raspberry Pi to provide streamed frames to AWS Kinesis
video stream. The Raspberry Pi is running the C++ kinesis SDK to be able
to compress the frames and **securely** send them to the AWS Kinesis
endpoint. The Kinesis data stream output will be used by a Lambda
function to decide whether a known face has been detected; if there was
a known face detected, it will notify the iOS app with the name and age
range of the detected face.

# System Model, Problem statement and analysis

## System Components

The Smart Lifeguard surveillance system consists of three main
components hardware, Cloud services and iOS app. The hardware consists
of Raspberry Pi 4, Comimark Tilt/vibration Sensor Module, SW-420
Vibration Sensor Module, Raspberry Pi V2 camera with 8 Megapixels as
shown in Figure 2. The Raspberry Pi is responsible for running a Python
script that lets the Raspberry Pi read the signals coming from the
sensors and sending alerts to the cloud service. The Raspberry Pi camera
is used to provide live streaming that will be analyzed on the cloud and
be used to generate alerts.

![Diagram Description automatically
generated](./media/image2.png){width="3.1834306649168855in"
height="2.070931758530184in"}

Figure 2: Hardware design

For the vibration and tilt sensors, as soon as a signal has been
received on the Raspberry Pi from these sensors, Raspberry Pi will
publish MQTT message to the AWS IoT core on some MQTT topics that it is
listening on. The system can utilize some of the available on the market
waterproof vibration sensors that can float on the pool surface and send
signals to the surveillance system as soon as a body causes disturbance
to the water and causes vibrations. Raspberry Pi will flash a LED light
to provide visual alerts as well.

The iOS app developed specially for this project, show in Figure 4, is
used to let the system operator to arm, unarm the notifications and
acknowledge the alerts. The iOS app will connect to the IoT core
endpoint and subscribe to the MQTT topics which it expects IoT core will
send the alerts on. AWS IoT core will republish to these topics if it
gets triggered by the Raspberry Pi for a sensor related alert or if it
gets triggered by the Lambda function if a known face has been detected.
The iOS app can unarm the system and stop receiving these alerts from
the IoT core as well as acknowledging the alerts back to the Raspberry
Pi so the Raspberry Pi can turn off the LED.

![Graphical user interface, application Description automatically
generated](./media/image3.png){width="2.422176290463692in"
height="4.214285870516186in"}

Figure 4: SLG iOS app

## Mathematical Model

### Total Delay

> The delay (T refers to the time taken) for the case of using sensor
> only notification will be equivalent to:
>
> *T~sensor~ = T~Raspberry\ Pi\ Publish\ Time~+
> T~Trip\ time\ to\ IoT\ core~ +* *T~Trip\ time\ to\ iOS\ app~*
>
> *T~video~ = T~Kinesis~ + T~Rekognition~ + T~Lambda~ + T~IoT\ Core~ +
> T~Trip\ time\ to\ iOS\ app~*
>
> The system design will depend on utilizing the available cloud
> services to provide accurate and fast surveillance for drowning
> detection. The assumptions is that the delay within the AWS cloud
> services is equal across the different regions. In this paper, the
> system was developed and tested on AWS us-west-2/Oregon.

# Design and Implementation

The design of the system is that the Raspberry Pi will be running a
Python script that detects GPIO voltage fall if one of the connected
sensors sent a voltage signal to indicate a certain action, like the
motion sensor detecting a movement or the vibration sensor detecting a
vibration. The Python script allows the Raspberry Pi to publish on topic
"alert" on the AWS IoT core, as well as topic "emailNotification". The
IoT Core has an act rule defined that listens to the topic "alert" and
re-publishes on topic "order". Raspberry Pi received the "order" MQTT
message and start to blink the LED light to indicate the occurrence of
an event.

![Diagram Description automatically
generated](./media/image4.png){width="3.223215223097113in"
height="2.0108409886264216in"}

Figure 3: System design

The used cloud services, as shown in Figure 3, are all provide by Amazon
Web Services (AWS), those cloud services are AWS Kinesis, AWS Lambda,
AWS S3, AWS Rekognition, AWS IoT Core and AWS SNS. AWS Kinesis is used
to provide secure channel to upstream live capture. As mentioned above,
the captured frames will be passed to AWS Rekognition and the Lambda
function will be used to trigger AWS SNS service to send email
notifications. AWS IoT core will be used to receive notifications from
Raspberry Pi for sensor triggered notifications as well as the Lambda
related notifications when a known face is detected. IoT core will then
republish those messages to the iOS app that is connected to the AWS
endpoint and listening for these notifications by subscribing to MQTT
topics.

The iOS app was developed on XCode using Swift/Swift UI. Inside the app
AppDelegate class, the iOS SLG app connects to the IoT core endpoint
after getting the client ID. After the iOS app is connected to the AWS
IoT core, it will register the subscribed topics "order" and
"detectedFace".

The iOS app provides three buttons for three options as shown in Figure
4. First button is **"arm"** which lets the iOS app endpoint
re-subscribe to the "order" and "detectedFace" topics. Second button is
to **"unarm"** which lets the iOS app unsubscribe from the topics
"order" and "detectedFace" and so no alerts are received. Third button
is "acknowledged" which published on a **"acknowledge"** topic that is
subscribed by the Raspberry Pi so it can turn off the LED.

If the iOS app is subscribed to either of the topics "order" or
"faceDetected" it plays a water splash sound to alert the subscribed
phone and logs a message on the XCode console for the received event.

**Message received: \[\"Message\": A vibration at the pool sensor has
been detected\]**

The IoT core has another rule for SNS email notification that allows it
to send email notifications in case an MQTT message received for the
"emailNotification" topic. As shown in Figure 5 below, a received email
from AWS SNS service indicating a detected vibration.

![Graphical user interface, text, application, email Description
automatically generated](./media/image5.png){width="3.262110673665792in"
height="1.4707261592300962in"}

Figure 5: SNS Notify

The second feature in the design is the Smart Lifeguard video
surveillance. For that we used a Raspberry Pi v2 camera attached to the
Raspberry Pi 4 to send a live feed to AWS Kinesis Video Stream. In
addition to the AWS Kinesis, we used another AWS provided cloud service
which is AWS Simple Storage Service (S3). We created a new S3 bucket to
store the faces we want to get notified whenever seen on camera feed.
The S3 bucket will be used to help creating a face collection on AWS
Rekognition using the photos we uploaded into that bucket.

The Raspberry Pi camera is used to provide video surveillance
capabilities to the system as such it will be used to provide live
streaming videos uploaded to AWS Kinesis. The AWS Kinesis will then pass
the frames to AWS Rekognition for processing. The results will be passed
to AWS Kinesis data stream, AWS Rekognition will use a pre-labelled face
collection to detect pre-labelled faces. A Lambda function will be used
and triggered every time there is new information from the AWS Kinesis
data stream. Lambda function will process the FaceSearchResponse in the
returned data. If the returned Faces array is not empty, then the Lambda
function will check, if the detected faces are unknown faces or some
known (previously pre-labelled) faces. The Lambda function will extract
the ExternalImageId from the MatchedFaces output. If a known face has
been detected, it will alert the AWS SNS function to send an email to
the operator as well as a MQTT message to the IoT core.

The Rekognition Video stream processor will output messages to the
Kinesis Data Stream for each video stream fragment. Below is an example
from the data fetched from Kinesis data stream by our Lambda function
when Amazon Rekognition Video identifies a face in the live video
stream. In the Lambda function, only the FaceSearchResponse output is
analyzed.

As shown in Figure 6, the Kinesis data stream outputs three different
fields, InputInformation, StreamProcessorInformation and
FaceSearchResponse. In this paper, we will only describe the
FaceSearchResponse as this is what is used in our Smart Lifeguard video
surveillance system and utilized by our Lambda function.

![Text Description automatically
generated](./media/image6.png){width="3.3703182414698163in"
height="0.9301323272090989in"}

Figure 6: CloudWatch Response

**FaceSearchResponse**: This section contains the list of faces found in
the live video feed. Each face found in the feed includes metadata for
the bounding boxes, confidence scores, landmark locations, as well as
which faces it matched (if any) from the faces collection used when
starting the stream processor.

As a demo for the Smart Lifeguard surveillance, we have uploaded a photo
of a girl named Lena to the previously created S3 bucket and added it
the AWS Rekognition face collection. After being registered in the AWS
Rekognition, Lambda function should be able to fetch the
FaceSearchResponse with the name/label if a face matching that face is
detected in the video stream. As shown in Figure 7 below, an output from
CloudWatch for the MatchedFaces information, we see the external image
id ("Lena" in this example) as well as the matched confidence score
(99.98%) that determined that the face was indeed a match for a
pre-labelled face.

![Text Description automatically
generated](./media/image7.png){width="3.274686132983377in"
height="1.6494706911636046in"}

Figure 7

In the Lambda function, after the face has been successfully detected
and matched, Lambda function will run the AWS Rekognition FaceDetails
function on the photo and return the AgeRange of the detected face.

The facial detection feature is mainly used to detect if there are
unattended kids around the pool. The AWS Rekognition can recognize an
age range for faces with some accuracy. However, as stated by Anda et al
\[5\], there might be a lot of factors affecting the reported age range.
These factors vary between facial expressions, picture noise and facial
make up. If Lambda function will be used to filter out the alerts, it
needs to take into consideration the age range variance output by AWS
Rekognition.

The Lambda function will then publish a MQTT message containing the
name/label of the matched face as well as the AWS Rekoginition age range
to the AWS IoT Core which in turn will re-publish the message to the iOS
app.

As shown below in Figure 8 from XCode console, the received message from
Lambda function was the age range of the detected face was between 2 - 8
years old.

![Text Description automatically
generated](./media/image8.png){width="3.637762467191601in"
height="0.9163560804899388in"}

Figure 8: XCode notification

In addition to the iOS app alert, Lambda function will also trigger an
email notification using AWS SNS, as shown below in Figure 9.

![Graphical user interface, text, application, email Description
automatically
generated](./media/image9.png){width="3.3472222222222223in"
height="1.6111111111111112in"}

Figure 9: SNS Notify

# Evaluation

The test setup was as listed below for the hardware, cloud services and
iOS app.

## Hardware

The Smart Lifeguard system has been implemented using Raspberry Pi 4
running Raspbian OS version 10 (Buster). A Raspberry Pi version 2 camera
with 8 Mega Pixels still resolution, with V4L2 driver. Sensors used for
the demonstration were Comimark Tilt/vibration Sensor Module, SW-420
Vibration Sensor Module.

## Cloud Services - Kinesis Video Streams

Video streaming to AWS Kinesis video streaming was over WIFI, and had
the below values:

format=I420,

width=640,

height=480,

framerate=5/1

omxh264enc control-rate=1

target-bitrate=5120000

periodicity-idr=45

inline-header=FALSE

stream-format=avc,

alignment=au,

profile=baseline

## Test Environment

- Raspberry Pi was connected to NetGear router Nighthawk AX8000, 600
  Mbps DL rate, 45 Mbps UL rate.

- All AWS cloud services used were in US-West (Oregon)/us-west-2 region.

- iOS app developed using XCode (Version 12.4 -12D4e) running on MacBook
  pro (16-inch, 2019).

- iOS app installed and tested on iPhone 12 OS 14.4.

## Evaluation Metrics

Due to the sensitivity of the purpose of the app, the evaluation metrics
were the reliability of the system, availability, and delay. Since every
second matters in saving the life of someone in distress, delay was the
major factor that I wanted to measure and maybe try to optimize. AWS has
taken good measures to ensure the availability and reliability of their
services.

Reliability was close to 99.9%. I have almost got the
notifications/alerts for all events that was supposed to trigger the
alert on the iOS app. AWS cloud services were also available all the
time.

As shown below in Figure 10, a comparison between the delay experienced
with each of the supported use cases of the Smart Lifeguard surveillance
system. The sensor-initiated alerts were the fastest and had an average
delay of 1.5 -- 2 seconds between the actual event and the time of
receiving the alert about the event. On the other hand, the camera video
surveillance-initiated alerts had significantly higher delay since the
alerts were triggered after the stream has been uploaded to the Kinesis
video stream, processed by AWS Rekognition, data fetched by Lambda
function from the Kinesis data stream and if a matched face's been
detected then it alerts the IoT core which finally notifies the iOS app
about the incident. This process does require a lot of time which might
need further optimization to reduce the time required for video
surveillance to send alerts to the iOS app. The video surveillance took
around 6-8 seconds for a frame with only one face to match. When the
number of faces in the frame was two, the time taken to receive the
alert was close to 9-12 seconds.

Figure 10: iOS app delay comparison

SNS notification for both features had similar results. The time taken
to receive a SNS email notification when one sensor detected an event
was around 2 seconds. While the time taken to receive the notification
for the video surveillance was around 6 seconds as show in Figure 11
below.

Figure 11: SNS delay comparison

The video surveillance features took considerably more time to send the
notification to the iOS app as well as it did take more time to send the
SNS notification compared to the alerts sent due to sensor related
alerts. The sensor related alerts went straight from the Raspberry Pi to
the IoT core then to the SNS service. However, for the video
surveillance case, the stream was uploaded to the Kinesis video stream,
then was processed by the AWS Rekognition, and the data was sent out to
the data stream. The Lambda function had to fetch the data from the data
stream and process it to get the matched face then notify the SNS
service. As a result, the alerts were at least three times faster if the
system was dependent on the sensor-based notifications. For practical
purposes the system should depend more on the sensors and rely less on
the video surveillance.

# Conclusion and Future work

The Smart Lifeguard was successful in detecting the events that will
require the attention of the app owner. It was proven that the
surveillance system was able to detect the events using the sensor
activated events as well as using the video surveillance.

There was a significant delay to the video surveillance-initiated alerts
compared to the sensor-initiated alerts. The delay was introduced since
video surveillance uses more AWS services that require further
processing as opposed to the sensor use case which relies on the
messages published straight from the Raspberry Pi to the IoT core. Hence
the system should be more dependents upon the use of sensors since it
provides faster alerts and notification which is more important for
Smart Lifeguard use case.

Future work includes:

- Including more features in the system by adding microphones that can
  detect water splash and send alerts to the iOS app and SNS service.

## Adding a feature on top of the video surveillance that lets the Smart Lifeguard system sends notifications to the iOS app without the need for pre-labelled pictures and face collections. The system shall be able to detect all people in the streamed video to Kinesis video stream and process the faces using AWS Rekognition, notifications shall be sent if the age range of the detected face is less than a predefined age while the system is armed.

# References {#references .Reference-Head}

\[1\] H. Liu, M. B. H. Frej, and B. Wen, "A Novel Method for
Recognition, Localization, and Alarming to Prevent Swimmers from
Drowning," in *2019 IEEE Cloud Summit*, Washington, DC, USA, Aug. 2019,
pp. 65--71, doi:
[10.1109/CloudSummit47114.2019.00017](https://doi.org/10.1109/CloudSummit47114.2019.00017).

\[2\] "• Global IoT and non-IoT connections 2010-2025 \| Statista."
<https://www.statista.com/statistics/1101442/iot-number-of-connected-devices-worldwide/>.

\[3\] A. I. N. Alshbatat, S. Alhameli, S. Almazrouei, S. Alhameli, and
W. Almarar, "Automated Vision-based Surveillance System to Detect
Drowning Incidents in Swimming Pools," in *2020 Advances in Science and
Engineering Technology International Conferences (ASET)*, Dubai, United
Arab Emirates, Feb. 2020, pp. 1--5, doi:
[10.1109/ASET48392.2020.9118248](https://doi.org/10.1109/ASET48392.2020.9118248).

\[4\] S. Karthik, D. Priya E.L., G. Anand K.R., and A. Sharmila, "IoT
Based Safety Enhanced Swimming Pool with Embedded Techniques to reduce
drowning accidents," in *2020 International Conference on Smart
Electronics and Communication (ICOSEC)*, Trichy, India, Sep. 2020, pp.
843--847, doi:
[10.1109/ICOSEC49089.2020.9215247](https://doi.org/10.1109/ICOSEC49089.2020.9215247).

\[5\] F. Anda, B. A. Becker, D. Lillis, N.-A. Le-Khac, and M. Scanlon,
"Assessing the Influencing Factors on the Accuracy of Underage Facial
Age Estimation," in *2020 International Conference on Cyber Security and
Protection of Digital Services (Cyber Security)*, Dublin, Ireland, Jun.
2020, pp. 1--8, doi:
[10.1109/CyberSecurity49315.2020.9138851](https://doi.org/10.1109/CyberSecurity49315.2020.9138851).

\[6\] "Unintentional Drowning: Get the Facts \| Home and Recreational
Safety \| CDC Injury Center."
<https://www.cdc.gov/homeandrecreationalsafety/water-safety/waterinjuries-factsheet.html>.

[^1]:
