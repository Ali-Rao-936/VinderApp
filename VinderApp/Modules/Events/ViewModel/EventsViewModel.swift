//
//  EventsViewModel.swift
//  VinderApp
//
//  Created by ios Dev on 02/10/2023.
//

import Foundation
import UIKit

class EventsViewModel {
    
    // MARK: - Properties
    
    private var eventsListResponse: [[String: Any]]? {
        didSet {
            guard let e = eventsListResponse else { return }
            self.didFinishFetchforList?(e)
        }
    }
    
    private var createEventResponse: [String: Any]? {
        didSet {
            guard let c = createEventResponse else { return }
            self.didFinishFetch?(c)
        }
    }
    
    private var getEventDetailResponse: [String: Any]? {
        didSet {
            guard let g = getEventDetailResponse else { return }
            self.didFinishFetch?(g)
        }
    }
    
    private var joinEventResponse: [String: Any]? {
        didSet {
            guard let j = joinEventResponse else { return }
            self.didFinishFetch?(j)
        }
    }
    
    private var apiService: EventsWebServices?

    // MARK: - Constructor
    
    init(apiService: EventsWebServices) {
        self.apiService = apiService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (([String: Any]) -> ())?
    var didFinishFetchforList: (([[String: Any]]) -> ())?

    // MARK: - Network call
    
    func getEventsList(subUrl: String) {
    
        print("getEventsList....")
        self.apiService?.getEventsList(subUrl: subUrl, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.eventsListResponse = response["data"] as? [[String : AnyObject]]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func getEventDetail(subUrl: String) {
    
        print("getEventDetail....")
        self.apiService?.getEventsList(subUrl: subUrl, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.getEventDetailResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func createEvent(params: [String: Any], subUrl: String) {
    
        print("createEvent....")
        self.apiService?.postEventAPIs(parameters: params, subUrl: subUrl, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.createEventResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func joinEvent(params: [String: Any], subUrl: String) {
    
        print("joinEvent....")
        self.apiService?.postEventAPIs(parameters: params, subUrl: subUrl, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.joinEventResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
  
}




