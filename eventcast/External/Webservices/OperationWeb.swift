
//
//  OperationWeb.swift


@objc protocol OperationWebDelegate {
    @objc optional func operationWebCountryList(_ array: [typeAliasStringDictionary])
}

import UIKit

class OperationWeb: NSObject, XMLParserDelegate , NSURLConnectionDelegate , NSURLConnectionDataDelegate {
    
    //MARK: PROPERTIES
    var delegate: OperationWebDelegate! = nil
    
    //MARK: VARIABLES
    let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let _VKAlertActionView = VKAlertActionView.init()
    internal var resultURL: URL!
    internal var _methodName: String!
    
//    internal var webData:Data!
    internal var theRequest: URLRequest!
    internal var theSession = URLSession()
    
    //MARK: CUSTOME METHODS
    func callRestApi(_ url: String, methodType: METHOD_TYPE, parameters: typeAliasStringDictionary, viewActivityParent: UIView, onSuccess: @escaping (_ dictServiceContent: typeAliasDictionary) -> Void, onFailure: @escaping (_ errorCode: String) -> Void) {
        
        DesignModel.startActivityIndicator(viewActivityParent)
        var stUrl: String = JWebService
        stUrl = "\(stUrl)\(url)"
        
        var stMethodName: String = ""
        switch methodType {
        case .GET:
            stMethodName = "GET"   
            self.theRequest = URLRequest(url: URL(string: stUrl)!)
            self.theRequest.httpMethod = stMethodName
            self.theRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            self.theRequest.addValue("no-cache", forHTTPHeaderField: "cache-control")
            break
            
        case .POST:
            var stData: String = ""
            if !parameters.isEmpty {
                var i: Int = 0
                for (pKey, var pValue) in parameters {
                    let joiner: String = i == 0 ? "" : "&"
                    stData += "\(joiner)\(pKey)=\(pValue.encode())"
                    i += 1
                }
            }
            print("call \(stMethodName)")
            self.theRequest.httpMethod = stMethodName
            self.theRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            self.theRequest.addValue("no-cache", forHTTPHeaderField: "cache-control")
            self.theRequest.httpMethod = "POST"

        default:
            break
        }
        
        self.theSession = URLSession.shared
        
        let task = self.theSession.dataTask(with: self.theRequest, completionHandler: { (data, response, error) -> Void in
            print("\(stMethodName) : \(JWebService)")
            DispatchQueue.main.async(execute: {
                if (error != nil) {
                    let errorNS: NSError = error! as NSError
                    let errorCode: String = "\(errorNS.code)"
//                    print("Error : \(error)")
                    DesignModel.stopActivityIndicator()
                    self._VKAlertActionView.showOkAlertView(MSG_ERR_CONNECTION, alertType: .DUMMY, object: "", isCallDelegate: false);
                    onFailure(errorCode)
                }
                else {
                    if data != nil {
                        let SERVICE: String = "SERVICE"
                        var stData: String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                        
                        DesignModel.stopActivityIndicator()
                        if stData.uppercased() == "ERROR" { onFailure("000") }
                        else {
                            stData = "{ \"\(SERVICE)\":\(stData) }"
                            let dict = stData.convertToDictionary2()
                            let dictService: typeAliasDictionary = dict[SERVICE] as! typeAliasDictionary
                            onSuccess(dictService)
                        }
                    }
                    else { DesignModel.stopActivityIndicator(); onFailure("000"); }
                }
            })
        })
        task.resume()
    }
    
    func getcodeforkeys(_ stCode: String) -> String {
        var st_Code: String = stCode
        st_Code = st_Code.replace("&", withString: "&amp;")
        st_Code = st_Code.replace("<", withString: "&lt;")
        st_Code = st_Code.replace(">", withString: "&gt;")
        st_Code = st_Code.replace("'", withString: "&apos;")
        st_Code = st_Code.replace("\"", withString: "&quot;")
        return stCode
    }
}
