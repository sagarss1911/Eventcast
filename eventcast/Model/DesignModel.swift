//
//  DesignModel.swift
//

//http://krakendev.io/blog/the-right-way-to-write-a-singleton

import UIKit

let HEIGHT_IPHONE_5                     = 568
let HEIGHT_IPHONE_4                     = 480

let FRAME_SCREEN                        = UIScreen.main.bounds

let IS_IPAD                             = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE                           = UIDevice.current.userInterfaceIdiom == .phone
let IS_IPHONE_5                         = Int(UIScreen.main.bounds.size.height) == HEIGHT_IPHONE_5
let IS_IPHONE_5_UP                      = Int(UIScreen.main.bounds.size.height) >= HEIGHT_IPHONE_5

let IS_PORTRAIT                         = UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
let IS_LANDSCAPE                        = UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)

let systemVerion                        = (UIDevice.current.systemVersion as NSString).floatValue
let IS_OS_6_OR_ABOVE                    = systemVerion >= 6.0
let IS_OS_6_BELOW                       = systemVerion < 6.0
let IS_OS_7_OR_ABOVE                    = systemVerion >= 7.0
let IS_OS_7_BELOW                       = systemVerion < 7.0
let IS_OS_8_OR_ABOVE                    = systemVerion >= 8.0
let IS_OS_7_To_8                        = systemVerion >= 7.0 && systemVerion < 8.0

//**************************COLOR******************************************

public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

let COLOUR_NAV                              = RGBCOLOR(53, g: 170, b: 200)



//MARK: CELL IDENTIFIER
//**************************CELL IDENTIFIER***********************************
let CELL_IDENTIFIER_MKRIGHT_SIDE_MENU       = "MKRightSideMenuCell"

//**************************FONT********************************************


let FONT_CENTURY_GOTHIC                = "CenturyGothic"
let FONT_SOURCE_SANS_PRO_REGULAR       = "SourceSansPro-Regular"
let FONT_SOURCE_SANS_PRO_LIGHT         = "SourceSansPro-Light"



//*************************CELL HEIGHT***************************************

let HEIGHT_MK_RIGT_SUDE_MENU:CGFloat        = 50

//***************************************************************************

let WIDTH_PRODUCT_CELL:CGFloat              = 160
let WIDTH_RESULT_DASHBOARD_CELL:CGFloat     = 165
let WIDTH_PRODUCT_LIST_CELL:CGFloat         = 149
let WIDTH_CLOSET_DESIGN_LIST_CELL:CGFloat   = 240



//MARK: CONSTRINT CONSTANT
//******************CONSTRINT CONSTANT******************************************
let CONSTRAINT_TOP                          = "CONSTRAINT_TOP"
let CONSTRAINT_BOTTOM                       = "CONSTRAINT_BOTTOM"
let CONSTRAINT_LEADING                      = "CONSTRAINT_LEADING"
let CONSTRAINT_TRAILING                     = "CONSTRAINT_TRAILING"
let CONSTRAINT_WIDTH                        = "CONSTRAINT_WIDTH"
let CONSTRAINT_HEIGHT                       = "CONSTRAINT_HEIGHT"
let CONSTRAINT_HORIZONTAL                   = "CONSTRAINT_HORIZONTAL"
let CONSTRAINT_VERTICAL                     = "CONSTRAINT_VERTICAL"

let PRIORITY_LOW: UILayoutPriority              = UILayoutPriority(rawValue: 555)
let PRIORITY_HIGH: UILayoutPriority             = UILayoutPriority(rawValue: 999)
//*******************************************************************************

//MARK POPOVER CONSTANT
//*******************************************************************************
let VK_POPOVER_ANIMATION                    = "POPOVER_ANIMATION_BOTTOM_TO_TOP"
let VK_SELECTION_ANIMATION                  = "SELECTION_ANIMATION_BOTTOM_TO_TOP"
let VK_IMAGE_ZOOMER_ANIMATION               = "IMAGE_ZOOMER_CROSS_DISSOLVE"
let VK_FILTER_ANIMATION                     = "FILTER_ANIMATION_FADE_IN_OUT"
let VK_POPOVER_DURATION:Double              = 0.3        //0.5
let VK_POPOVER_BG_TRANSPARENT:Bool          = true
let VK_POPOVER_BORDER_COLOR                 = UIColor.red
//change keyur
let VK_POPOVER_BORDER_WIDTH:CGFloat         = 0
let VK_POPOVER_CORNER_RADIUS:CGFloat        = 0
let VK_POPOVER_OUT_SIDE_CLICK_HIDDEN:Bool   = true
//*******************************************************************************

let TAG_LAYER_TOP                           = "700"
let TAG_LAYER_BOTTOM                        = "800"


//MARK: CLASS
class DesignModel: NSObject {
    
    //MARK: NSLAYOUTCONSTRAINT METHODS
    class func setConstraint_ConWidth_ConHeight_Horizontal_Vertical(_ subView: UIView, superView: UIView, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        //HORZONTAL
        let constraintHorizontal: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        superView.addConstraint(constraintHorizontal)
        
        //VERTICAL
        let constraintVertical: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        superView.addConstraint(constraintVertical)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight,
                CONSTRAINT_HORIZONTAL:constraintHorizontal,
                CONSTRAINT_VERTICAL:constraintVertical]
    }
    
    
    class func setConstraint_ConWidth_ConHeight_Leading_Top(_ subView: UIView, superView: UIView, width: CGFloat, height: CGFloat , top:CGFloat , leading:CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        //HORZONTAL
        let constraintHorizontal: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintHorizontal)
        
        //VERTICAL
        let constraintVertical: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintVertical)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight,
                CONSTRAINT_HORIZONTAL:constraintHorizontal,
                CONSTRAINT_VERTICAL:constraintVertical]
    }
    
    class func setConstraint_Leading_Top_ConWidth_ConHeight(subView: UIView, superView: UIView, leading: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //LEADING - TO SUPERVIEW
        let constraintLeading: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintLeading)
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop)
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_LEADING:constraintLeading,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
        
    }
    
    class func setConstraint_Trailing_Top_ConWidth_ConHeight(subView: UIView, superView: UIView, trailing: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //TRAILING - TO SUPERVIEW
        let constraintTrailing: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: trailing)
        superView.addConstraint(constraintTrailing)
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop)
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_TRAILING:constraintTrailing,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
    }
    
    
    class func setScrollSubViewConstraint(_ subView: UIView, superView :UIView, toView: UIView, leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //LEADING - TO SUPERVIEW
        let constraintLeading: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintLeading)
        
        //TRAILING - TO SUPERVIEW
        let constraintTrailing: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: trailing)
        superView.addConstraint(constraintTrailing);
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop);
        
        //BOTTOM - TO SUPERVIEW
        let constraintBottom: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: bottom)
        superView.addConstraint(constraintBottom);
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth);
        
        //HEIGHT - CONSTANT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight);
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_LEADING:constraintLeading,
                CONSTRAINT_TRAILING:constraintTrailing,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_BOTTOM:constraintBottom,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
    }
    
}



