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
        if ((txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)! || (txtFullname.text?.isEmpty)! || (txtTitle.text?.isEmpty)! || (txtCompany.text?.isEmpty)! || (txtMobile.text?.isEmpty)!  ){
            self._VKAlertActionView.showOkAlertView(MSG_TEXT_NOT_BLANK, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
        }
        else {
            self._VKAlertActionView.showOkAlertView(MEST_TEST, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
        }
    }
}
