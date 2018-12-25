//
//  ViewController.swift
//  qrpay
//
//  Created by imac1 on 19.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var QrOpen: UIButton!
    var user=User_Credentials()
    var value:String?
    @IBAction func QrOpen(_ sender: Any) {
        
        let  storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "QRView") as! QRViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

