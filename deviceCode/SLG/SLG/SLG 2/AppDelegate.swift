import Foundation
import UIKit
import AWSCognito
import AWSCore
import AWSIoT
import AVFoundation

@UIApplicationMain

class AppDelegate: UIResponder , UIApplicationDelegate{

    var window: UIWindow?
    var audioPlayer:AVAudioPlayer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest1,identityPoolId:"us-west-1:ffeb5d17-ae85-4172-a7fa-39b1aba73a48")
        //let configuration = AWSServiceConfiguration(region:.USWest1, credentialsProvider:credentialsProvider)
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
           identityPoolId:"us-west-2:12a23d24-fb4d-471b-952f-e55d21bfae85")

        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
        AWSServiceManager.default()?.defaultServiceConfiguration = configuration
        
        let syncClient = AWSCognito.default()
        let dataset = syncClient.openOrCreateDataset("myDataset")
        dataset.setString("myValue", forKey: "myKey")

        // Initialising AWS IoT And IoT DataManager
        AWSIoT.register(with: configuration!, forKey: "kAWSIoT")

        //let iotEndPoint = AWSEndpoint(urlString: "wss://a3346r7tb872oq-ats.iot.us-west-1.amazonaws.com/mqtt")
        //let iotDataConfiguration = AWSServiceConfiguration(region: .USWest1,endpoint: iotEndPoint,credentialsProvider: credentialsProvider)
        
        let iotEndPoint = AWSEndpoint(urlString: "wss://a3346r7tb872oq-ats.iot.us-west-2.amazonaws.com/mqtt")
        let iotDataConfiguration = AWSServiceConfiguration(region: .USWest2,endpoint: iotEndPoint,credentialsProvider: credentialsProvider)

        AWSIoTDataManager.register(with: iotDataConfiguration!, forKey: "kDataManager")
        // Access the AWSDataManager instance as follows:
        let dataManager = AWSIoTDataManager(forKey: "kDataManager")

        credentialsProvider.getIdentityId().continueWith(block: { (task:AWSTask<NSString>) -> Any? in
            if let error = task.error as NSError? {
                print("Failed to get client ID => \(error)")
                return nil  // Required by AWSTask closure
            }

            let clientId = task.result! as String
            print("Got client ID => \(clientId)")
            func mqttEventCallback(_ status: AWSIoTMQTTStatus ) {
                switch status {
                case .connecting: print("Connecting to AWS IoT")
                case .connected:
                    print("Connected to AWS IoT")
                    // Register subscriptions here
                    // Publish a boot message if required
                case .connectionError: print("AWS IoT connection error")
                case .connectionRefused: print("AWS IoT connection refused")
                case .protocolError: print("AWS IoT protocol error")
                case .disconnected: print("AWS IoT disconnected")
                case .unknown: print("AWS IoT unknown state")
                default: print("Error - unknown MQTT state")
                }
            }
            DispatchQueue.global(qos: .background).async {
                do {
                    print("Attempting to connect to IoT device gateway with ID = \(clientId)")
                    let dataManager = AWSIoTDataManager(forKey: "kDataManager")
                    dataManager.connectUsingWebSocket(withClientId: clientId,
                                                      cleanSession: true,
                                                      statusCallback: mqttEventCallback)
                    
                } catch {
                    print("Error, failed to connect to device gateway => \(error)")
                }
            }
            return nil // Required by AWSTask closure
        })
        registerSubscriptions()
        return true
    }
    
    func getAWSClientID(completion: @escaping (_ clientId: String?,_ error: Error? ) -> Void) {
            // Depending on your scope you may still have access to the original credentials var

        //let credentials = AWSCognitoCredentialsProvider(regionType:.USWest1,identityPoolId:"us-west-1:ffeb5d17-ae85-4172-a7fa-39b1aba73a48")
        
        let credentials = AWSCognitoCredentialsProvider(regionType:.USWest2,
           identityPoolId:"us-west-2:12a23d24-fb4d-471b-952f-e55d21bfae85")
        
            credentials.getIdentityId().continueWith(block: { (task:AWSTask<NSString>) -> Any? in
                if let error = task.error as NSError? {
                    print("Failed to get client ID => \(error)")
                    completion(nil, error)
                    return nil  // Required by AWSTask closure
                }
                
                let clientId = task.result! as String
                print("Got client ID => \(clientId)")
                completion(clientId, nil)
                return nil // Required by AWSTask closure
            })
        }
    
    func mqttEventCallback(_ status: AWSIoTMQTTStatus ) {
        print("connection status = \(status.rawValue)")
    }
    
    func connectToAWSIoT(clientId: String!) {
            
            func mqttEventCallback(_ status: AWSIoTMQTTStatus ) {
                switch status {
                case .connecting: print("Connecting to AWS IoT")
                case .connected:
                    print("Connected to AWS IoT")
                    // Register subscriptions here
                    // Publish a boot message if required
                case .connectionError: print("AWS IoT connection error")
                case .connectionRefused: print("AWS IoT connection refused")
                case .protocolError: print("AWS IoT protocol error")
                case .disconnected: print("AWS IoT disconnected")
                case .unknown: print("AWS IoT unknown state")
                default: print("Error - unknown MQTT state")
                }
            }
            
            // Ensure connection gets performed background thread (so as not to block the UI)
            DispatchQueue.global(qos: .background).async {
                do {
                    print("Attempting to connect to IoT device gateway with ID = \(clientId)")
                    let dataManager = AWSIoTDataManager(forKey: "kDataManager")
                    dataManager.connectUsingWebSocket(withClientId: clientId,
                                                      cleanSession: true,
                                                      statusCallback: mqttEventCallback)
                    
                } catch {
                    print("Error, failed to connect to device gateway => \(error)")
                }
            }
        }
    
    func registerSubscriptions() {
            func messageReceived(payload: Data) {
                let payloadDictionary = jsonDataToDict(jsonData: payload)
                print("Message received: \(payloadDictionary)")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                let systemSoundID: SystemSoundID = 1016
                AudioServicesPlaySystemSound (systemSoundID)
            }
            
            let topicArray = ["$aws/things/RaspberryPi/shadow/detectedFace/", "$aws/things/RaspberryPi/shadow/order/" /*, "topicThree"*/]
            let dataManager = AWSIoTDataManager(forKey: "kDataManager")
            
            for topic in topicArray {
                print("Registering subscription to => \(topic)")
                dataManager.subscribe(toTopic: topic,
                                      qoS: .messageDeliveryAttemptedAtLeastOnce,  // Set according to use case
                                      messageCallback: messageReceived)
            }
    }

    func jsonDataToDict(jsonData: Data?) -> Dictionary <String, Any> {
            // Converts data to dictionary or nil if error
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: jsonData!, options: [])
                let convertedDict = jsonDict as! [String: Any]
                return convertedDict
            } catch {
                // Couldn't get JSON
                print(error.localizedDescription)
                return [:]
            }
    }
}
