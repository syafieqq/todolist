//
//  ViewController.swift
//  TodoList
//
//  Created by Megat Syafiq on 13/07/2019.
//  Copyright © 2019 Megat Syafiq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startDidTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "todolistNav") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    
}

