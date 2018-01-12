
//
//  Created by by Keyur on 05/01/18.
//  Copyright © 2018 jTechappz. All rights reserved.
//

import Foundation

public enum METHOD_TYPE: Int {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum API_STATUS: Int {
    
    case NEED_TOKEN = 0
    case SUCCESS = 1
    case EXPIRED_TOKEN = 2
    case NOT_EXIST_TOKEN = 3
    case DUMMY = 4
}

public enum MK_RIGHT_SIDE_MENU: Int {
    case mk_SIDE_MENU_INFO_CENTRE
    case mk_SIDE_MENU_AGENDA
    case mk_SIDE_MENU_SPEAKER
    case mk_SIDE_MENU_PARTICIPENTS
    case mk_SIDE_MENU_GALLERY
    case mk_SIDE_MENU_SURVEYS
    case mk_SIDE_MENU_POLLS
    case mk_SIDE_MENU_DOWNLOAD_CENTER
    case mk_SIDE_MENU_PROFILE
    case mk_SIDE_MENU_LOGOUT
}

public enum K_SIDE_MENU: Int {
    case k_SIDE_MENU_INFO_CCENTER
    case k_SIDE_MENU_AGENDA
    case k_SIDE_MENU_SPEAKER
    case k_SIDE_MENU_PARTICIPANTS
    case k_SIDE_MENU_GALLERY
    case k_SIDE_MENU_SURVEYS
    case k_SIDE_MENU_POLLS
    case k_SIDE_MENU_DOWNLOAD_CENTER
    case k_SIDE_MENU_PROFILE
    case k_SIDE_MENU_LOGOUT
}

public enum PAGE_TYPE: Int {
    case REGISTER
    case EDIT_PROFILE
}

public enum SITE_TYPE: Int {
    case dummy
    case terms_CONDITIONS
    case privacy_POLICY
}


public enum Model : String {
    case simulator = "simulator/sandbox",
    iPod1          = "iPod 1",
    iPod2          = "iPod 2",
    iPod3          = "iPod 3",
    iPod4          = "iPod 4",
    iPod5          = "iPod 5",
    iPad2          = "iPad 2",
    iPad3          = "iPad 3",
    iPad4          = "iPad 4",
    iPhone4        = "iPhone 4",
    iPhone4S       = "iPhone 4S",
    iPhone5        = "iPhone 5",
    iPhone5S       = "iPhone 5S",
    iPhone5C       = "iPhone 5C",
    iPadMini1      = "iPad Mini 1",
    iPadMini2      = "iPad Mini 2",
    iPadMini3      = "iPad Mini 3",
    iPadAir1       = "iPad Air 1",
    iPadAir2       = "iPad Air 2",
    iPhone6        = "iPhone 6",
    iPhone6plus    = "iPhone 6 Plus",
    iPhone6S       = "iPhone 6S",
    iPhone6Splus   = "iPhone 6S Plus",
    unrecognized   = "?unrecognized?"
}
