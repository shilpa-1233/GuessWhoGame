//
//  ViewController.swift
//  FlipKartTest
//
//  Created by Shilpa Garg on 04/07/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit


class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        
        let secondViewControllerObject = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        navigationController?.pushViewController(secondViewControllerObject, animated: false)
        
    }
    
}

