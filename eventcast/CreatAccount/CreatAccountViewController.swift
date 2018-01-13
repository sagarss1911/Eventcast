//
//  CreatAccountViewController.swift
//  eventcast
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 jTechAppz. All rights reserved.
//

import UIKit
import Alamofire

class CreatAccountViewController: UIViewController,UITextFieldDelegate,AppNavigationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, VKAlertActionViewDelegate {
    
    @IBOutlet var scrollViewBG: UIScrollView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var lblTitle: UILabel!
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
    
    @IBOutlet var btnCreatAccount: UIButton!
     @IBOutlet var btnSaveProfile: UIButton!
    @IBOutlet var imageProfile: UIImageView!
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let obj_OperationWeb = OperationWeb()
    fileprivate let _VKAlertActionView = VKAlertActionView()
    fileprivate var imagePicker = UIImagePickerController()
    var image:UIImage!
    internal var page_type: PAGE_TYPE!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        _VKAlertActionView.delegate = self
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.registerForKeyboardNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch page_type {
        case .REGISTER:
            btnSaveProfile.isHidden = true
            btnCreatAccount.isHidden = false
            lblTitle.text  = TEXT_TITLE_REGISTER
        case .EDIT_PROFILE:
            btnSaveProfile.isHidden = false
            btnCreatAccount.isHidden = true
            lblTitle.text  = TEXT_EDIT_PROFILE
            self.callUpdateUserProfile()
           self.setNavigationBar()
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        obj_AppDelegate.navigationController.setCustomTitle("EventCast")
        obj_AppDelegate.navigationController.setSideMenu()
        obj_AppDelegate.navigationController.navigationDelegate = self
         obj_AppDelegate.navigationController.setRightBackButton()
        
    }
    func appNavigationController_SideMenuAction() {
        let _MKSideMenu = MKSideMenu()
        self.navigationController?.view.addSubview(_MKSideMenu)
    }
    func appNavigationController_RightBackAction() {
        let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(homeVc, animated: false)
    }
    
    fileprivate func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc internal func keyboardWasShown(_ aNotification: Notification) {
        let info: [AnyHashable: Any] = (aNotification as NSNotification).userInfo!;
        var keyboardRect: CGRect = ((info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue)
        keyboardRect = self.view.convert(keyboardRect, from: nil);
        
        var contentInset: UIEdgeInsets = scrollViewBG.contentInset
        contentInset.bottom = keyboardRect.size.height
        scrollViewBG.contentInset = contentInset
    }
    
    @objc internal func keyboardWillBeHidden(_ aNotification: Notification) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
            self.scrollViewBG.contentInset = UIEdgeInsets.zero
        }, completion: nil)
    }

    //MARK: UITEXTFIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail { txtPassword.becomeFirstResponder() }
        else if textField == txtPassword { txtConfirmPassword.becomeFirstResponder() }
        else if textField == txtConfirmPassword { txtFullname.becomeFirstResponder() }
        else if textField == txtFullname { txtTitle.becomeFirstResponder() }
        else if textField == txtTitle { txtCompany.becomeFirstResponder() }
        else if textField == txtCompany { txtYouCanCallme.becomeFirstResponder() }
        else if textField == txtYouCanCallme { txtCity.becomeFirstResponder() }
        else if textField == txtCity { txtCountry.becomeFirstResponder() }
        else if textField == txtCountry { txtRigion.becomeFirstResponder() }
        else if textField == txtRigion { txtMobile.becomeFirstResponder() }
        else if textField == txtMobile { txtHobbies.becomeFirstResponder() }
        else if textField == txtHobbies { txtBiography.becomeFirstResponder() }
        else if textField == txtBiography { txtBiography.resignFirstResponder() }
        return true}
    
//MARK: BUTTON ACTION
    
    @IBAction func btnCreatAccountAction(_ sender: UIButton) {
        DataModel.setUDID()
        let stUdid = DataModel.getUDID()
        if !(txtPassword.text == txtConfirmPassword.text) {
            self._VKAlertActionView.showOkAlertView(MSG_PASSWORD_NOT_MATCH, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        
        if ((txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)! || (txtFullname.text?.isEmpty)! || (txtTitle.text?.isEmpty)! || (txtCompany.text?.isEmpty)! || (txtMobile.text?.isEmpty)!) {
            self._VKAlertActionView.showOkAlertView(MSG_TEXT_NOT_BLANK, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        else {
            var strBase64: String = ""
            if imageProfile.image != nil {
                let imageData:NSData = UIImagePNGRepresentation(imageProfile.image!)! as NSData
                strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            }
 //           print(strBase64)
          
            let parameters: Parameters = ["image" : "\(strBase64)","name": "\( txtFullname.text ?? "")","position":"\( txtTitle.text ?? "")", "company" : "\( txtCompany.text ?? "")","callme" : "\( txtYouCanCallme.text ?? "")","city" : "\( txtCity.text ?? "")","country" : "\( txtCountry.text ?? "")","region" : "\( txtRigion.text ?? "")","mobile" : "\(txtMobile.text ?? "")","email":"\( txtEmail.text ?? "")","hobbies" : "\(txtHobbies.text ?? "")","bio" : "\(txtBiography.text ?? "")","password":"\( txtPassword.text ?? "")","device_type" : "iPhone","device_id" : "\(stUdid)","method":"Register"]
            
                DesignModel.startActivityIndicator(self.view)
                
                self.request = Alamofire.request(JWebService, method: .post, parameters:parameters)
                if let request = request as? DataRequest {
                    request.responseString { response in
                        switch response.result {
                        case .success:
                            DesignModel.stopActivityIndicator()
                            print(response)
                            print("dictResponse")
                            if let JSON = response.result.value {
                                print(JSON)
                                if JSON .contains("error") {
                                    self._VKAlertActionView.showOkAlertView(MSG_ENTER_PROPER_CREDENTIAL, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                                }else {
                                    DataModel.setFingerprint(JSON)
                                    let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
                                    self.navigationController?.pushViewController(homeVc, animated: true)
                                }
                            }
                        case .failure(let error):
                            print(error)
                            DesignModel.stopActivityIndicator()
                            self._VKAlertActionView.showOkAlertView(MSG_SOMETHING_WRONG, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                        }
                        
                    }
                }
        }
    }
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
        
    }
    
    @IBAction func btnChangeProfilePicAction(_ sender: UIButton) {
        _VKAlertActionView.showAlertView(["Take Photo","Gallery"], message: MSG_TITLE, isIncludeCancelButton : true, alertType: .DUMMY, object: "")
    }
  
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if !(txtPassword.text == txtConfirmPassword.text) {
            self._VKAlertActionView.showOkAlertView(MSG_PASSWORD_NOT_MATCH, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        
        if ((txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)! || (txtFullname.text?.isEmpty)! || (txtTitle.text?.isEmpty)! || (txtCompany.text?.isEmpty)! || (txtMobile.text?.isEmpty)!) {
            self._VKAlertActionView.showOkAlertView(MSG_TEXT_NOT_BLANK, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            return
        }
        else {
        var strBase64: String = ""
        let stFinger = DataModel.getFingerprint()
        if imageProfile.image != nil {
            let imageData:NSData = UIImagePNGRepresentation(imageProfile.image!)! as NSData
            strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        let parameters: Parameters = ["image" : "\(strBase64)","name": "\( txtFullname.text ?? "")","position":"\( txtTitle.text ?? "")", "company" : "\( txtCompany.text ?? "")","callme" : "\( txtYouCanCallme.text ?? "")","city" : "\( txtCity.text ?? "")","country" : "\( txtCountry.text ?? "")","region" : "\( txtRigion.text ?? "")","mobile" : "\(txtMobile.text ?? "")","email":"\( txtEmail.text ?? "")","hobbies" : "\(txtHobbies.text ?? "")","bio" : "\(txtBiography.text ?? "")","device_type" : "iPhone","password":"\( txtPassword.text ?? "")","fingerprint" : "\(stFinger)","method":"UpdateProfile"]
        
        DesignModel.startActivityIndicator(self.view)
        
        self.request = Alamofire.request(JWebService, method: .post, parameters:parameters)
        if let request = request as? DataRequest {
            request.responseString { response in
                switch response.result {
                case .success:
                    DesignModel.stopActivityIndicator()
                    print(response)
                    print("dictResponse")
                    if let JSON = response.result.value {
                        print(JSON)
                        if JSON .contains("error") {
                            self._VKAlertActionView.showOkAlertView(MSG_ENTER_PROPER_CREDENTIAL, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                        }else {
                            let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
                            self.navigationController?.pushViewController(homeVc, animated: true)
                        }
                    }
                case .failure(let error):
                    print(error)
                    DesignModel.stopActivityIndicator()
                    self._VKAlertActionView.showOkAlertView(MSG_SOMETHING_WRONG, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                }
                
            }
        }
    }

    }
    
    //MARK: Custom Button
    func callUpdateUserProfile() {
        let stQueryString: String = "?method=FetchProfile&fingerprint=\(DataModel.getFingerprint())"
        
        obj_OperationWeb.callRestApi(stQueryString, methodType: .GET, parameters: typeAliasStringDictionary(), viewActivityParent: self.navigationController!.view, onSuccess: { (dictServiceContent) in
            
            print(dictServiceContent)
            DataModel.setUserInfo(dictServiceContent )
           let userInfo: typeAliasDictionary = DataModel.getUserInfo()
            self.txtCity.text = (userInfo[RES_city] as! String)
            self.txtEmail.text = (userInfo[RES_email] as! String)
            self.txtFullname.text = (userInfo[RES_name] as! String)
            self.txtTitle.text = (userInfo[RES_position] as! String)
            self.txtCountry.text = (userInfo[RES_country] as! String)
            self.txtCompany.text = (userInfo[RES_company] as! String)
            self.txtRigion.text = (userInfo[RES_region] as! String)
            self.txtMobile.text = (userInfo[RES_mobile] as! String)
            self.txtHobbies.text = (userInfo[RES_hobbies] as! String)
            self.txtBiography.text = (userInfo[RES_bio] as! String)
            self.txtYouCanCallme.text = (userInfo[RES_callme] as! String)
//            let stImageName : String = (userInfo[RES_image] as! String)
//            let baseURL : String = LoadImage_URL + stImageName
//            self.imageProfile.image = self.setImageFromURl(baseURL)
        }, onFailure: { (errorCode) in
            self._VKAlertActionView.showOkAlertView(MSG_ERR_LOGIN, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
        })
       
       
    }
    
    func vkAlertViewAction(_ alertType: ALERT_TYPE, buttonIndex: Int, buttonTitle: String, object: String) {
        switch buttonIndex {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.delegate = self
                imagePicker.modalPresentationStyle = .fullScreen
                self.present(imagePicker,animated: true,completion: nil)
            } else {
                _VKAlertActionView.showOkAlertView("Sorry, this device has no camera", alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            }
            break
            
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            break
            
        default:
            break
        }
    }
    
    func vkActionSheetAction(_ actionSheetType: ACTION_SHEET_TYPE, buttonIndex: Int, buttonTitle: String, object: String) {
    }
    
    //MARK: - IMAGEPICKER DELEGATE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        NSLog("\(info)")
        if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            var chosenImage = UIImage()
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            chosenImage = chosenImage.resizeWithPercent(percentage: 0.2)!
            imageProfile.contentMode = .scaleAspectFit
            imageProfile.image = chosenImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
     //MARK: Load Image
    //(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
//    func setImageFromURl(_ stringImageUrl : String) -> UIImage{
//        var img:UIImage!
//        if let url = NSURL(string: stringImageUrl) {
//            if let data = NSData(contentsOf: url as URL) {
//                img = UIImage(data: data as Data)!
//            }
//        }
//        return img
//    }
}
