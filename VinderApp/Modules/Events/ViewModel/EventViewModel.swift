//
//  EventViewModel.swift
//  VinderApp
//
//  Created by iOS Dev on 16/10/2023.
//

import Foundation
import UIKit

class EventViewModel {
    
    private var apiService = APIService()
    var url = String()
    
    private(set) var eventList: EventList! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var eventDetail: EventDetail! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var inviteResponse: UserList! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    init(eventType: EventType, eventID: Int? = 0) {
        switch eventType {
        case .allEvents:
            url = APIURL.EventList + "?skip_my_joined_event=true&pagination=false"
            callFuncToGetEvents()
        case .hotEvents:
            url = APIURL.HotEventList + "?skip_my_joined_event=true&pagination=false"
            callFuncToGetEvents()
        case .upcoming:
            url = APIURL.UpcomingEventList
            callFuncToGetEvents()
        case .past:
            url = APIURL.PastEventList
            callFuncToGetEvents()
        case .eventDetail:
            url = APIURL.EventList + "?event_id=\(eventID ?? 0)"
            callFuncToGetEventDetail()
        case .joinEvent:
            url = APIURL.JoinEvent
            callFuncToPostJoinEvent(eventID: eventID ?? 0)
        case .inviteEvent:
            url = APIURL.InviteEvent
            callFuncToGetEvents()
        case .acceptedEvent:
            url = APIURL.AcceptedEventList + "?per_page=100"
            callFuncToGetEvents()
        }
    }
    
    init(eventType: EventType, parameters: [String:Any], eventImage: UIImage? = nil) {
        switch eventType {
        case .allEvents:
            callFuncToCreateEvent(parameters: parameters, eventImage: eventImage ?? UIImage())
        case .inviteEvent:
            callFuncToInviteEvent(parameters: parameters)
        default:
            break
        }
        
    }
    
    // uploadImageToServer
    // API call to get different types of Events list
    func callFuncToGetEvents() {
        self.apiService.request(EventListModel.self, url: self.url, httpMethod: HTTPMethodType.get) { (result : Result<EventListModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.eventList = result.response
                    //   print("RESPONSE---> \(String(describing: self.userList))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    func callFuncToGetEventDetail() {
        self.apiService.request(EventDetailModel.self, url: self.url, httpMethod: HTTPMethodType.get) { (result : Result<EventDetailModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.eventDetail = result.response
                       print("Event detail RESPONSE---> \(String(describing: self.eventDetail))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    func callFuncToPostJoinEvent(eventID: Int) {
        let params = JoinOrInviteEventRequest(eventId: eventID).dictionary
      //  let params = ["event_id": eventID]
        self.apiService.request(EventDetailModel.self, url: self.url, httpMethod: HTTPMethodType.post, params: params) { (result: Result<EventDetailModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.eventDetail = result.response
                       print("RESPONSE---> \(String(describing: self.eventDetail))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    func callFuncToCreateEvent(parameters: [String:Any], eventImage: UIImage) {
        self.apiService.uploadImageToServer(url: APIURL.CreateEvent, parameters: parameters, image: ["banner" : eventImage]) { (result: Result<EventDetailModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.eventDetail = result.response
                     //  print("RESPONSE---> \(String(describing: self.eventDetail))")
                    print("RESPONSE ERROR---> \(String(describing: result.error))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    func callFuncToInviteEvent(parameters: [String:Any]) {
        self.apiService.uploadImageToServer(url: APIURL.InviteEvent, parameters: parameters) { (result: Result<UserListModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.inviteResponse = result.response
                       print("RESPONSE INVITE---> \(String(describing: self.inviteResponse))")
                 //   print("RESPONSE ERROR---> \(String(describing: result.error))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
