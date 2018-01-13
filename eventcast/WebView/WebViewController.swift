//
//  WebViewController.swift
//  eventcast
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 jTechAppz. All rights reserved.
//

import UIKit
import Alamofire

class WebViewController: UIViewController,AppNavigationControllerDelegate, UIWebViewDelegate, VKPopoverDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, VKAlertActionViewDelegate {

    @IBOutlet var webViewAll: UIWebView!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var btnAddPhoto: UIButton!
    @IBOutlet var viewImageTitle: UIView!
    @IBOutlet var txtImageTitle: UITextField!
    
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate let _VKAlertActionView = VKAlertActionView()
    fileprivate var _VKPopover = VKPopover()
    fileprivate var imagePicker = UIImagePickerController()
    fileprivate var strBase64: String = ""
    fileprivate var stImageCaptiontext: String = ""
    internal var url: String!
    internal var page_type: K_SIDE_MENU!
    var refController:UIRefreshControl = UIRefreshControl()
    var isUploadingImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _VKAlertActionView.delegate = self
        imagePicker.delegate = self
        
        self.setNavigationBar()
        refController.attributedTitle = NSAttributedString(string:"Pull to refresh", attributes: [
            NSAttributedStringKey.foregroundColor: COLOUR_NAV])
        refController.tintColor = COLOUR_NAV
        refController.addTarget(self, action: #selector(ForceRefresh), for: UIControlEvents.valueChanged)
        webViewAll.scrollView.addSubview(refController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageBackground.isHidden = true
        webViewAll.isHidden = false
        self.webViewShow()
    }
    
    
//MARK: APPNAVIGATION CONTROLLER DELEGATE
    fileprivate func setNavigationBar() {
        obj_AppDelegate.navigationController.setCustomTitle("EventCast")
        obj_AppDelegate.navigationController.setSideMenu()
        obj_AppDelegate.navigationController.navigationDelegate = self
        obj_AppDelegate.navigationController.setRightBackButton()
    }
    
//MARK: APPNAVIGATION CONTROLLER BUTTON
    func appNavigationController_SideMenuAction() {
        let _MKSideMenu = MKSideMenu()
        self.navigationController?.view.addSubview(_MKSideMenu)
    }
    
    func appNavigationController_RightBackAction() {
        if (webViewAll.canGoBack == false){
            let homeVc = HomeViewController(nibName: "HomeViewController",bundle:nil)
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(homeVc, animated: false)
        }else {
            webViewAll.goBack()
        }
    }
    
    @IBAction func btnViewImage_CancelAction() {
        _VKPopover.closeVKPopoverAction()
    }
    
    @IBAction func btnViewImage_OkAction() {
        _VKPopover.closeVKPopoverAction()
        stImageCaptiontext = txtImageTitle.text!
//
//            .add("caption", encoded_caption)
//            .add("image", image)
//            .add("fingerprint", fingerprint)
//            .add("method", "UploadImage");
        _VKAlertActionView.showAlertView(["Take Photo","Gallery"], message: MSG_TITLE, isIncludeCancelButton : true, alertType: .DUMMY, object: "")
        
    }
    
    @IBAction func btnAddPhotoAction() {
        self._VKPopover = VKPopover.init(viewImageTitle, animation: .popover_ANIMATION_CROSS_DISSOLVE, animationDuration: VK_POPOVER_DURATION, isBGTransparent: VK_POPOVER_BG_TRANSPARENT, borderColor: UIColor.clear, borderWidth: VK_POPOVER_BORDER_WIDTH, borderCorner: VK_POPOVER_CORNER_RADIUS, isOutSideClickedHidden: VK_POPOVER_OUT_SIDE_CLICK_HIDDEN)
        self._VKPopover.delegate = self
        self.navigationController?.view.addSubview(self._VKPopover)
    }
    
    //MARK: CUSTOME METHOD
    func webViewShow(){
        if obj_AppDelegate.isConnectedToNetwork() {
            switch page_type {
                
            case .k_SIDE_MENU_INFO_CCENTER:
                let baseURL : String = JWebParent_URL + JWebChild_InfoCenter_URL
                let MyURL = URL.init(string: baseURL)
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_AGENDA:
                let baseURL : String = JWebParent_URL + JWebChild_Agenda_URL + DataModel.getFingerprint()
                let agendaUrl :String = baseURL
                let MyURL = URL.init(string: agendaUrl)
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_SPEAKER:
                let baseURL : String = JWebParent_URL + JWebChild_Speaker_URL
                let MyURL = URL.init(string: baseURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_PROFILE:
                print("k_SIDE_MENU_PROFILE")
                
            case .k_SIDE_MENU_GALLERY:
                if isUploadingImage == true { break }
                let stPhoto: String = DataModel.getHomeDetail()["photo"] as! String
                btnAddPhoto.isHidden = stPhoto == "1" ? false : true
                let baseURL : String = JWebParent_URL + JWebChild_Gallery_URL + DataModel.getFingerprint()
                let galeryURL : String = baseURL
                let MyURL = URL.init(string: galeryURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_SURVEYS:
                let baseURL : String = JWebParent_URL + JWebChild_Survey_URL + DataModel.getFingerprint()
                let surveyURL : String = baseURL
                let MyURL = URL.init(string: surveyURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_PARTICIPANTS:
                let baseURL : String = JWebParent_URL + JWebChild_Participents_URL
                let MyURL = URL.init(string: baseURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_POLLS:
                let baseURL : String = JWebParent_URL + JWebChild_Polls_URL + DataModel.getFingerprint()
                let pollsURL : String = baseURL
                print(pollsURL)
                let MyURL = URL.init(string: pollsURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_DOWNLOAD_CENTER:
                let baseURL : String = JWebParent_URL + JWebChild_Download_URL + DataModel.getFingerprint()
                let downloadURL : String = baseURL
                print(downloadURL)
                let MyURL = URL.init(string: downloadURL )
                let loadUrl = URLRequest(url:MyURL!)
                webViewAll.loadRequest(loadUrl)
                
            case .k_SIDE_MENU_LOGOUT:
                let loginVc = LoginViewController(nibName: "LoginViewController",bundle:nil)
                DataModel.setIsLaunchFirstTime("0")
                self.navigationController?.pushViewController(loginVc, animated: true)
                
            case .none:
                break
                
            case .some(_):
                break
            }
        }
        else {
            self._VKAlertActionView.showOkAlertView(MSG_NO_INTERNET, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
            imageBackground.isHidden = false
            webViewAll.isHidden = true
        }
    }
    
    @objc func ForceRefresh(sender:AnyObject) {
        webViewAll.reload()
        refController.endRefreshing()
//        func ForceRefresh(refresh:UIRefreshControl)
    }
    
    //MARK: WEBVIEW DELEGATE
    func webViewDidStartLoad(_ webView: UIWebView) {
        DesignModel.startActivityIndicator(self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DesignModel.stopActivityIndicator()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let stError: String = error as! String;
        self._VKAlertActionView.showOkAlertView(stError, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
    }
    
    @IBAction func btnEventCastAction(_ sender: UIButton) { obj_AppDelegate.openSafari() }

    func vkPopoverClose() {
        txtImageTitle.text = ""
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
         self.isUploadingImage = true
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        chosenImage = chosenImage.resizeWithPercent(percentage: 0.6)!
        let imageData:NSData = UIImagePNGRepresentation(chosenImage)! as NSData
        strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        dismiss(animated:true, completion: nil)
        let stFinger = DataModel.getFingerprint()
        
        let parameters: Parameters = ["image" : "\(strBase64)","caption":"\(stImageCaptiontext)","fingerprint" : "\(stFinger)","method":"UploadImage"]
        
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
                        if JSON .contains("success") {
                     
                            self._VKAlertActionView.showOkAlertView(MSG_SUCCESS_UPLOAD_IMAGE, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                            self.webViewAll.reload()
                            self.isUploadingImage = false
                            
                        }else {
                             self._VKAlertActionView.showOkAlertView(MSG_SOMETHING_WRONG, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                             self.isUploadingImage = false
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                    DesignModel.stopActivityIndicator()
                    self._VKAlertActionView.showOkAlertView(MSG_SOMETHING_WRONG, alertType: ALERT_TYPE.DUMMY, object: "", isCallDelegate: false)
                     self.isUploadingImage = false
                }
                
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        isUploadingImage == false
    }
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
        
    }
}
