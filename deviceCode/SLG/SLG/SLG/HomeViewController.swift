//
//  HomeViewController.swift
//  SLG
//
//  Created by Ahmed Nada on 2/6/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let label : UILabel = {
        let label = UILabel(frame: CGRect(x:0,y:0,width: 300, height: 100))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Welcome to the Smart Lifeguard"
        return label
    //view.backgroundColor = .white
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.center = view.center
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }


}
