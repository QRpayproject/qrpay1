//
//  LoginViewController.swift
//  qrpay
//
//  Created by imac1 on 19.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var label_mistake: UILabel!
    @IBOutlet weak var tf_password: UITextField!
    var user:User_Credentials = User_Credentials()
    var value2:String=""
    @IBAction func btn_login(_ sender: Any) {
        
       login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
user.User_Password="aaaa"
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
 
    func login()  {
       
        var isLogin:String=""
        let url="http://qrparam.net/User_Credentials/Login/?User_Email="+tf_username.text!+"&User_Password="+tf_password.text!
        print(url)
        Alamofire.request(url,method:.get).validate().responseJSON{
            response in
           
            switch response.result{
                
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                print("success")
                 isLogin=String(json["hata"].stringValue);
                if json.count>0{
                    
                        self.user.User_Email=json["User_Email"].stringValue
                        self.user.User_Credential_Number=json["User_Credential_Number"].intValue
                        self.user.User_Gender = json["User_Gender"].stringValue
                        self.user.User_Phone_Number=json["User_Phone_Number"].intValue
                        self.user.User_Birth_Date=json["User_Birth_Date"].stringValue
                        self.user.User_Name = json["User_Name"].stringValue
                        self.user.User_Surname = json["User_Surname"].stringValue
                        self.user.User_ID = json["User_ID"].intValue
                        self.user.User_Password =  json["User_Password"].stringValue
                    
                   
                    print(json["User_Email"].stringValue)
                    let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! ViewController
                      self.performSegue(withIdentifier: "HomePageSegue", sender: self)
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    self.label_mistake.isHidden = false;
                    let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! ViewController
                    self.value2 = "merhaba"
                    self.performSegue(withIdentifier: "HomePageSegue", sender: self)

                    self.present(vc, animated: true, completion: nil)
                }
                
            case .failure(let error):
                 self.label_mistake.isHidden = false;
                print(error)
            }

            
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "HomePageSegue"){
             guard let homvc = segue.destination as? ViewController else{return}
             homvc.value=self.value2
            print("segue")
            print(self.user.User_Email)
             homvc.user=self.user
        }
    
        
        
    }

}
