//  MKSideMenu.swift
//
//
//  Created by keyur on 26/11/16.
//  Copyright © 2016 jtechAppz. All rights reserved.
//

let TEXT_COLOUR                          = RGBCOLOR(104, g: 104, b: 104)
//let TAG_SUB_TITLE                        = 1003

let TAG_ICON                             = 100

let TEXT_SUB: CGFloat                    = 14
let TEXT_MAIN: CGFloat                   = 14
let VK_SIDE_MENU_DURATION_TIME           = 0.3

let COLOUR_BG                           = RGBCOLOR(255, g: 255, b: 255)
let COLOUR_BLACK_TRANSPARENT            = RGBCOLOR(0, g: 0, b: 0, alpha: 0.4)

let SELECTION_SUPER_VIEW_TAG            = 10001
let SELECTION_SUB_VIEW_TAG              = 110001

let IS_EXAPANDABLE: String               = "IS_EXAPANDABLE"
let IS_EXPANDED: String                  = "IS_EXPANDED"

import UIKit

class MKSideMenu: UIView, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: CONSTANT
    internal let TAG_SUPPER: Int = 10000
    
    //MARK: PROPERTIES
    @IBOutlet var viewBG: UIView!
    @IBOutlet var tableViewList: UITableView!
    
    //MARK: VARIABLES
    fileprivate let obj_AppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate
    
    var width: CGFloat = 0
    fileprivate var arrList = [typeAliasDictionary]()
    fileprivate var constrintTrailing: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func loadXIB() {
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(view)
        
        //TOP
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        
        //Trailing
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
        
        //WIDTH
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        
        //HEIGHT
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
        self.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        //self.loadXIB()
        let frame: CGRect = FRAME_SCREEN
        self.frame = frame
        
        self.addSubview(Bundle.main.loadNibNamed("MKSideMenu", owner: self, options: nil)!.last! as! UIView)
        self.backgroundColor = COLOUR_BLACK_TRANSPARENT
        
        let gestureTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideMenuAction))
        
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        self.tag = SELECTION_SUPER_VIEW_TAG
        gestureTap.delegate = self
        self.addGestureRecognizer(gestureTap)
        
        width = frame.width * 2.8 / 4
        let dict: typeAliasDictionary! = DesignModel.setConstraint_Leading_Top_ConWidth_ConHeight(subView: viewBG, superView: self, leading: (-width), top: 0, width: width, height: self.frame.height)
        self.constrintTrailing = dict[CONSTRAINT_LEADING] as! NSLayoutConstraint
        self.loadData()
        
        self.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {() -> Void in
            self.alpha = 1
        }, completion: {(finished: Bool) -> Void in
            self.constrintTrailing.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {() -> Void in
                self.layoutIfNeeded()
            }, completion: nil)
        })
    }
    
    internal func loadData()
    {
        let dict: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_INFO_CENTRE.rawValue as AnyObject, LIST_TITLE : "Info Center" as AnyObject, LIST_IMAGE : "ic_infocenter" as AnyObject]
        
        let dict1: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_AGENDA.rawValue as AnyObject, LIST_TITLE : "Agenda" as AnyObject, LIST_IMAGE : "ic_agenda" as AnyObject]
        
        let dict2: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_SPEAKER.rawValue as AnyObject, LIST_TITLE : "Speakers" as AnyObject, LIST_IMAGE : "ic_speaker" as AnyObject]
        
        let dict3: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_PARTICIPENTS.rawValue as AnyObject, LIST_TITLE : "participants" as AnyObject, LIST_IMAGE : "ic_participant" as AnyObject]
        
        let dict4: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_GALLERY.rawValue as AnyObject, LIST_TITLE : "Gallery" as AnyObject, LIST_IMAGE : "ic_gallery" as AnyObject]
        
        let dict5: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_SURVEYS.rawValue as AnyObject, LIST_TITLE : "Surveys" as AnyObject, LIST_IMAGE : "ic_survey" as AnyObject]
        
        let dict6: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_POLLS.rawValue as AnyObject, LIST_TITLE : "Polls" as AnyObject, LIST_IMAGE : "ic_polls" as AnyObject]
        
        let dict7: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_DOWNLOAD_CENTER.rawValue as AnyObject, LIST_TITLE : "Download Center" as AnyObject, LIST_IMAGE : "ic_downloadcenter" as AnyObject]
        
        let dict8: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_PROFILE.rawValue as AnyObject, LIST_TITLE : "Profile" as AnyObject, LIST_IMAGE : "ic_profile" as AnyObject]
        
        let dict9: typeAliasDictionary = [LIST_ID :MK_RIGHT_SIDE_MENU.mk_SIDE_MENU_LOGOUT.rawValue as AnyObject, LIST_TITLE : "Logout" as AnyObject, LIST_IMAGE : "ic_logout" as AnyObject]
        
        arrList = [dict as typeAliasDictionary, dict1 as typeAliasDictionary, dict2 as typeAliasDictionary, dict3 as typeAliasDictionary, dict4 as typeAliasDictionary, dict5 as typeAliasDictionary, dict6 as typeAliasDictionary, dict7 as typeAliasDictionary, dict8 as typeAliasDictionary, dict9 as typeAliasDictionary]
        
        self.tableViewList.rowHeight = HEIGHT_MK_RIGT_SUDE_MENU
        self.tableViewList.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewList.register(UINib.init(nibName: CELL_IDENTIFIER_MKRIGHT_SIDE_MENU, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_MKRIGHT_SIDE_MENU)
        self.tableViewList.reloadData()
        self.tableViewList.backgroundColor = COLOUR_BG
    }
    
    @objc internal func hideMenuAction() {
        constrintTrailing.constant = -width
        UIView.animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.beginFromCurrentState, animations: {() -> Void in
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.beginFromCurrentState, animations: {() -> Void in
                self.alpha = 0
            }, completion: {(finished: Bool) -> Void in
                self.removeFromSuperview()
                self.layer.removeAllAnimations()
            })
        })
    }
    
    //MARK: UI GESTURE RRECOGNIZER
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let view: UIView = touch.view!
        let viewTag: Int = Int(view.tag)
        print("Touch View Tag : \(viewTag)")
        if viewTag != SELECTION_SUPER_VIEW_TAG{
            return false
        }
        return true
    }
    
    //MARK: TABLE VIEW DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.arrList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed(CELL_IDENTIFIER_MKRIGHT_SIDE_MENU, owner: self, options: nil)?[0] as! MKRightSideMenuCell
        let dict = self.arrList[indexPath.row]
        cell.imageName.image = UIImage(named: dict[LIST_IMAGE] as! String)
        cell.lblTitle.text! = dict[LIST_TITLE] as! String
        
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { cell.separatorInset = UIEdgeInsets.zero; cell.preservesSuperviewLayoutMargins = false; cell.layoutMargins = UIEdgeInsets.zero }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.hideMenuAction()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.6 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
        })
        print("You selected cell #\(indexPath.row)!")
    }
}
