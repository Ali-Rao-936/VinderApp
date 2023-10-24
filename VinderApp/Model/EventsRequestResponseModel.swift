//
//  EventsRequestModel.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import Foundation




struct InviteUsersForEventRequest{
    var eventId: Int?
    var invitees : [Int]?// invitee

    init(eventId: Int?, invitees: [Int]?){
        self.eventId = eventId
        self.invitees = invitees
    }

    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["event_id": eventId ?? emptyStr,
                                 "invitee" : invitees ?? []]
        return dict
    }
}




