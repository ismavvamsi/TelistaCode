//
//  ListService.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire


protocol FetchJsonObjectDelegate: AnyObject {
    func UpdateFactsDataInUI(factsData : ListModel)
    func serviceFailedWithError(error : Error)
    func networkfailureAlert(message : String)
}

public class ListService: NSObject{
    
    weak var delegate:FetchJsonObjectDelegate?
    var responceData : URLResponse?
    
    public func fetchJsonObjectWithoutAlomofire(){
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com") else { return }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if(flags.contains(.reachable)){
            let facctsJsonString: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
            let factsUrl = URL(string: facctsJsonString)
            let urlRequest = URLRequest(url: factsUrl!)
            // set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            // make the request
            let task = session.dataTask(with: urlRequest)
            {
                (data, response, error) in
                // check for any errors
                if (data == nil) {
                    self.delegate?.serviceFailedWithError(error: error!)
                } else{
                    let stringData = NSString.init(data: data!, encoding: String.Encoding.ascii.rawValue)
                    let encodedData = stringData?.data(using: String.Encoding.utf8.rawValue)!

                    do{
                        let factsModelData : ListModel = try ListModel.init(data: encodedData!)
                        self.delegate?.UpdateFactsDataInUI(factsData: (factsModelData))
                    }
                    catch{
                        self.delegate?.serviceFailedWithError(error: error)
                    }
                    guard error == nil else {
                        self.delegate?.serviceFailedWithError(error: error!)
                        return
                    }
                    return
                }
            }
            task.resume()
        }else{
            self.delegate?.networkfailureAlert(message: "Please check your internet connection and try again")
        }

    }
    
    // With Alamofire

    public func fetchJsonObjectWithAlomofire(){
        let todoEndpoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        AF.request(todoEndpoint)
          .responseJSON { response in
            let stringData = NSString.init(data: response.data!, encoding: String.Encoding.ascii.rawValue)
            let encodedData = stringData?.data(using: String.Encoding.utf8.rawValue)!
            
            do{
                let factsModelData : ListModel = try ListModel.init(data: encodedData!)
                self.delegate?.UpdateFactsDataInUI(factsData: (factsModelData))
            }
            catch{
                self.delegate?.serviceFailedWithError(error: response.error!)
            }
          }
          .responseString { response in
            if let error = response.error {
              print(error)
            }
            if let value = response.value {
              print(value)
            }
          }
}
}
