//
//  AppNavigationController.swift
//
//  Created by keyur on 5/01/18.
//  Copyright © 2018 jTechappz. All rights reserved.
//

import UIKit
//UA-78834038-1
private let WIDTH_IMAGE_BUTTON: CGFloat                 = 40

@objc protocol AppNavigationControllerDelegate {
    @objc optional func appNavigationController_RightMenuAction()
    @objc optional func appNavigationController_BackAction()
    @objc optional func appNavigationController_SideMenuAction()
    @objc optional func appNavigationController_RightBackAction()
}

class AppNavigationController: UINavigationController {

    //MARK: PROPERTIES
    var navigationDelegate: AppNavigationControllerDelegate! = nil
    var lblTitle: UILabel!
    var imageTitle: UIImageView!
    var lblTitleLandscape: UILabel!
    var lblSubTitle: UILabel!
    var btnListGrid: UIButton! = nil
    var btnMore: UIButton!
    var btnRightMenu: UIButton!
    var btnSummary: UIButton!
    var btnDownload: UIButton!
    var btnDownArrow: UIButton!
    var btnCartOnRight: UIButton!
    var btnCounterRightCart: UIButton!
    var viewSubTitleViewPotrait: UIView!
    var viewPlaceOrderSummaryRight: UIView!
    
    //MARK: VARIABLE
    var frameTitleView = CGRect.zero
    var btnWidth = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = COLOUR_NAV
        self.navigationBar.isTranslucent = false;
        self.navigationBar.tintColor = UIColor.white
       
        let dict = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 22),
                    NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationBar.titleTextAttributes = dict
        
        btnWidth = 30;
        frameTitleView = CGRect(x: btnWidth, y: 0, width: self.navigationBar.frame.width - (btnWidth * 3), height: self.navigationBar.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var shouldAutorotate: Bool {
        return self.viewControllers.last!.shouldAutorotate
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
      
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.viewControllers.last!.supportedInterfaceOrientations
    }
    
    internal func setCustomTitle(_ title: String) {
        let viewController: UIViewController = self.viewControllers.last!
        //self.lblTitle.removeFromSuperview()
        self.lblTitle = UILabel(frame: frameTitleView)
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.text = title
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        //        self.lblTitle.layer.borderWidth = 1
        viewController.navigationItem.titleView = self.lblTitle
    }
    
    internal func setSideMenu() {
        let viewController: UIViewController = self.viewControllers.last!
        let btnSideMenu = self.createImageButton("menu")
        btnSideMenu.addTarget(self, action: #selector(btnSideMenuAction), for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnSideMenu)
    }
    
    internal func setRightBackButton(){
        let viewController: UIViewController = self.viewControllers.last!
        let btnBack = self.createImageButton("ic_back")
        btnBack.addTarget(self, action: #selector(btnRightBackButton), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    
    internal func createImageButton(_ imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        button.setImage(UIImage(named: imageName)!, for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }
        
    internal func btnBackAction() {
        self.navigationDelegate.appNavigationController_BackAction!()
    }
    
    @objc internal func btnSideMenuAction() {
        self.navigationDelegate.appNavigationController_SideMenuAction!()
    }
    @objc internal func btnRightBackButton() {
         self.navigationDelegate.appNavigationController_RightBackAction!()
    }
}
