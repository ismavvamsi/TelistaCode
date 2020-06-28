//
//  FactsServiceTest.swift
//  TelistaCodeBaseTests
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

import XCTest
import SystemConfiguration

@testable import TelistaCodeBase


class FactsServiceTest: XCTestCase{
    
    var canadaFactsList : FactsModel?
    var service : FactsService = FactsService()
    var sessionUnderTest : URLSession?



    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworkRechability(){
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com") else { return }
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if(flags.contains(.reachable)){
            print("Internet connection is active")
        }
        else{
            print("No Internet connection")
        }
    }
    
    func testUrl() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let facctsJsonString: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let factsUrl = URL(string: facctsJsonString)
        let urlRequest : URLRequest? = URLRequest(url: factsUrl!)
        XCTAssert(urlRequest != nil)
    }
    
    func testJsonContent(){
        var data : NSData? = NSData()
        data =  NSData(contentsOf: URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!)
        XCTAssert(data != nil)
    }
    
    func testServiceMethodCall() {
        service.fetchJsonObject()
    }
    
    func testService() {
        
        let facctsJsonString: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let factsUrl = URL(string: facctsJsonString)
        let urlRequest = URLRequest(url: factsUrl!)
        
        let promise = expectation(description: "data != nil")
        
        let task = sessionUnderTest?.dataTask(with: urlRequest)
        {
            (data, response, error) in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
            promise.fulfill()
        }
        task?.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

    
}
