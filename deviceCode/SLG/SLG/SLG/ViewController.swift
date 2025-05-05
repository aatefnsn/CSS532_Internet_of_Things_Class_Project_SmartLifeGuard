//
//  ViewController.swift
//  SLG
//
//  Created by Ahmed Nada on 1/29/21.
//

import UIKit
import AWSCore
import AWSCognito
import AWSIoT
import AVFoundation
var audioPlayer2 = AVAudioPlayer()
var audioPlayer = AVAudioPlayer()

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:150,height:150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    let label : UILabel = {
        let label = UILabel(frame: CGRect(x:0,y:0,width: 300, height: 100))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "Welcome to the Smart Lifeguard"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(label)
        label.center = view.center
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {self.animtate()})
    }
    
    private func animtate(){
        UIView.animate(withDuration: 2, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if !done{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let viewController = HomeViewController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true)
                })
            }
        }) //
    }

    @IBAction func arm(sender:UIButton){
        
        let sound2 = Bundle.main.path(forResource: "fischio_rigore", ofType: "mp3")
        do{
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        }
        catch{
            print(error)
        }
        audioPlayer2.play()
        
        
        
        let sound = Bundle.main.path(forResource: "Cannonball-Splash-A1-www.fesliyanstudios.com (2)", ofType: "mp3")
        
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        catch{
            print(error)
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
        
        
        
        func messageReceived(payload: Data) {
            audioPlayer.play()
            let payloadDictionary = jsonDataToDict(jsonData: payload)
            print("Message received: \(payloadDictionary)")

            // Handle message event here...
        }
        audioPlayer2.play()
        let topicArray = ["$aws/things/RaspberryPi/shadow/order/", "$aws/things/RaspberryPi/shadow/detectedFace/"/*, "topicThree"*/]
        let dataManager = AWSIoTDataManager(forKey: "kDataManager")
        
        for topic in topicArray {
            print("Registering subscription to => \(topic)")
            dataManager.subscribe(toTopic: topic,
                                  qoS: .messageDeliveryAttemptedAtLeastOnce,  // Set according to use case
                                  messageCallback: messageReceived)
        }
        audioPlayer2.play()
        func registerSubscriptions() {

        }
    }
    
    @IBAction func unarm(sender: UIButton){
        print("Unsubscribing")
            let topicArray = ["$aws/things/RaspberryPi/shadow/order/"/*, "topicTwo", "topicThree"*/]
            let dataManager = AWSIoTDataManager(forKey: "kDataManager")
            
            for topic in topicArray {
                print("Registering subscription to => \(topic)")
                dataManager.unsubscribeTopic(topic)
            }
    }
    
    @IBAction func Acknowledge(sender: UIButton){
        
    }
    @IBAction func Ack(_ sender: UIButton) {
        print("Acknowledging")
            let dataManager = AWSIoTDataManager(forKey: "kDataManager")
        dataManager.publishString("Acknowledge, Turn LED Off",onTopic: "$aws/things/RaspberryPi/shadow/acknowledge/", qoS:.messageDeliveryAttemptedAtLeastOnce)
    }
    
}

