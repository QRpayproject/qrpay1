//
//  SignUpViewController.swift
//  qrpay
//
//  Created by imac1 on 25.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {

    @IBOutlet weak var TF_tc: UITextField!
    @IBOutlet weak var TF_name: UITextField!
    @IBOutlet weak var TF_surname: UITextField!
    @IBOutlet weak var TF_password: UITextField!
    @IBOutlet weak var TF_mail: UITextField!
    @IBOutlet weak var TF_phonenumber: UITextField!
    @IBOutlet weak var TF_gender: UISegmentedControl!
    @IBOutlet weak var TF_birdth: UITextField!
    
    
    @IBAction func btn_SignUp(_ sender: Any) {
        
        let user=getUserInfo();
        postUserJson(user: user)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUserInfo() -> User_Credentials {
    
        let user=User_Credentials()
       
         if let tc=TF_tc.text { user.User_Credential_Number=Int(tc)!}
        
         if let birdth=TF_birdth.text {user.User_Birth_Date=birdth}
        
         if let mail=TF_mail.text {  user.User_Email=mail}
       
         if let name=TF_name.text { user.User_Name=name}
        
         if let surname=TF_surname.text {user.User_Surname=surname}
        
         if let password=TF_password.text {user.User_Password=password}
        
        if let phonenumber=TF_phonenumber.text {user.User_Phone_Number=Int(phonenumber)!}
        
        if let gender:Int=TF_gender.selectedSegmentIndex{
            if gender==0
            {
                user.User_Gender="Erkek"
            }
            else{
                user.User_Gender="Kadın"
            }
        }
    
        return user;
    
    }
    
  
    func postUserJson(user:User_Credentials){

        let url="http://qrparam.net/User_Credentials/Insert/?User_Name="+user.User_Name+"&User_Surname="+user.User_Surname
        let url2="&User_Email="+user.User_Email+"&User_Password="+user.User_Password
        let url3="&User_Phone_Number="+String(user.User_Phone_Number)
        let url4="&User_Gender="+user.User_Gender+"&User_Birth_Date="+user.User_Birth_Date
        let url5="&User_Credential_Number="+String(user.User_Credential_Number)+"&Pass1=0"+"&Pass2=1"
        
        let totalurl=url+url2+url3+url4+url5
        
     let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                if json.count>0
                {
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc")
                    self.present(vc,animated: true,completion: nil);
                }
                
            case .failure(let error):
                print(error)
                
                
                
            }
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
