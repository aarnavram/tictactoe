//
//  AppLaunchViewController.swift
//  tictactoe
//
//  Created by Aarnav Ram on 15/11/16.
//  Copyright © 2016 Aarnav Ram. All rights reserved.
//

import UIKit

class AppLaunchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "dataPasser" {
            let svc = segue.destination as! ViewController
            
            svc.toPass = "Hello"
        }
    }

}
