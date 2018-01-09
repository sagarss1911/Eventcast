//
//  CreatAccountViewController.swift
//  eventcast
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 jTechAppz. All rights reserved.
//

import UIKit

class CreatAccountViewController: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtFullname: UITextField!
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var txtCompany: UITextField!
    @IBOutlet var txtYouCanCallme: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtCountry: UITextField!
    @IBOutlet var txtRigion: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtHobbies: UITextField!
    @IBOutlet var txtBiography: UITextField!
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let obj_OperationWeb = OperationWeb()
    fileprivate let _VKAlertActionView = VKAlertActionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnCreatAccountAction(_ sender: UIButton) {
//        if ((txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)! || (txtFullname.text?.isEmpty)! || (txtTitle.text?.isEmpty)! || (txtCompany.text?.isEmpty)! || (txtMobile.text?.isEmpty)!  ){
//            self._VKAlertActionView.showOkAlertView(MSG_TEXT_NOT_BLANK, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
//        }
//        else {
//            self._VKAlertActionView.showOkAlertView(MEST_TEST, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
//        }
        
        var params = typeAliasStringDictionary()
        params["image"] = ""
        params["name"] = txtFullname.text
        params["position"] = "writer"
        params["company"] = txtCompany.text
        params["callme"] = txtYouCanCallme.text
        params["city"] = txtCity.text
        params["country"] = txtCountry.text
        params["region"] = txtRigion.text
        params["mobile"] = txtMobile.text
        params["email"] = txtEmail.text
        params["hobbies"] = txtHobbies.text
        params["bio"] = txtBiography.text
        params["password"] = txtPassword.text
        params["device_type"] = "iPhone"
        params["device_id"] = DataModel.getUDID()
        params["method"] = "Register"
        print(params)
        
        
        obj_OperationWeb.callRestApi(JWebService, methodType: .POST, parameters: params, viewActivityParent: self.navigationController!.view, onSuccess: { (dictServiceContent) in
            
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
}
