//
//  LoginViewController.swift
//  eventcast
//
//  Created by apple on 01/01/18.
//  Copyright © 2018 jTechAppz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var viewSubview: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let obj_OperationWeb = OperationWeb()
    fileprivate let _VKAlertActionView = VKAlertActionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func btnLoginAction(_ sender: Any) {
        let finale: Bool = self.isValidEmail(testStr: txtEmail.text! )
        if finale == false {
            self._VKAlertActionView.showOkAlertView(MSG_VALID_EMAIL, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        if (txtEmail.text?.isEmpty)! {
            
            self._VKAlertActionView.showOkAlertView(MSG_VALID_EMAIL, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        else if (txtPassword.text?.isEmpty)! {
            self._VKAlertActionView.showOkAlertView(MSG_ERR_Password, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
            let stEmail: String = txtEmail.text!.trim()
            let stPwd: String = txtPassword.text!.trim()
            let deviceId: String = DataModel.getUDID()
            
            let stQueryString: String = "?method=Login&email=\(stEmail)&device_id=\(deviceId)&device_type=iPhone&password=\(stPwd)"
            
            obj_OperationWeb.callRestApi(stQueryString, methodType: .GET, parameters: typeAliasStringDictionary(), viewActivityParent: self.navigationController!.view, onSuccess: { (dictServiceContent) in
                
                print(dictServiceContent)
                DataModel.setFingerprint(dictServiceContent[RES_fingerprint] as! String)
                DataModel.setIsLaunchFirstTime("1")
                DataModel.setUsername(dictServiceContent[RES_name] as! String)
                let creatVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
                self.navigationController?.pushViewController(creatVc, animated: true)
            }, onFailure: { (errorCode) in
                self._VKAlertActionView.showOkAlertView(MSG_ERR_LOGIN, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            })
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: UIButton) {
        let creatVc = CreatAccountViewController(nibName: "CreatAccountViewController",bundle:nil)
        navigationController?.pushViewController(creatVc, animated: true)
    }
}
