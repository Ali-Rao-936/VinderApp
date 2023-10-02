//
//  EventsRequestModel.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import Foundation

struct CreateEventRequest{
    var name: String?
    var latitude: String?
    var longitude : String?
    var date : String?
    var time : String?
//    var banner : String?
    var isPaid : Int?
    var address : String?
    var invitees : [Int]?
    var description : String?

    init(name: String?,description: String, address: String, date: String, time: String, isPaid: Int, latitude: String?, longitude: String?, invitees : [Int] ){
        self.name = name
        self.description = description
        self.address = address
        self.date = date
        self.time = time
        self.isPaid = isPaid
        self.address = address
        self.invitees = invitees
        self.latitude = latitude
        self.longitude = longitude
    }
    // photo[0], banner
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["name": name ?? emptyStr,
                                 "description": description ?? emptyStr,
                                 "address": address ?? emptyStr,
                                 "is_paid": isPaid ?? zero,
                                 "date": date ?? emptyStr,
                                 "time_column": time ?? emptyStr,
                                 "latitude": latitude ?? emptyStr,
                                 "longitude": longitude ?? emptyStr,
                                 "invitee": invitees ?? []]
        return dict
    }
}


struct JoinEventRequest{
    var eventId: Int?

    init(eventId: Int?){
        self.eventId = eventId
    }

    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["event_id": eventId ?? emptyStr]
        return dict
    }
}

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


struct EventModel: Codable {

    let eventId: Int? // 1
    let userId: Int? // 2
    let locationId: Int? // 3
    let address: String? // 4
    let latitude: Double? // 5
    let longitude: Double? // 6
    let isPaid: String? // 8
    let date: String? // 9
    let time: String? // 10
    let isPublished: String? // 11
    let bannerImage: ImageUrls? // 12
    let description: String? // 13
    let name: String? // 14
    let attending: Bool? // 14
    let invited: Bool? // 14

    init(eventId: Int, userId: Int, locationId: Int, address: String, latitude: Double, longitude: Double, isPaid: String, date: String, time: String, isPublished: String, bannerImage: ImageUrls, description: String, name: String, attending: Bool, invited: Bool){
        self.eventId = eventId
        self.userId = userId
        self.locationId = locationId
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.isPaid = isPaid
        self.date = date
        self.time = time
        self.isPublished = isPublished
        self.bannerImage = bannerImage
        self.description = description
        self.name = name
        self.invited = invited
        self.attending = attending
    }

    init(with data: [String: Any]?) {
        self.eventId = data?["id"] as? Int ?? zero
        self.userId = data?["user_id"] as? Int ?? zero
        self.locationId = data?["location_id"] as? Int ?? zero
        self.name = data?["name"] as? String ?? emptyStr
        self.address = data?["address"] as? String ?? emptyStr
        self.description = data?["description"] as? String ?? emptyStr
        self.longitude = data?["longitude"] as? Double ?? 0.0
        self.latitude = data?["latitude"] as? Double ?? 0.0
        self.isPaid = data?["is_paid"] as? String ?? emptyStr
        self.isPublished = data?["is_published"] as? String ?? emptyStr
        self.date = data?["date"] as? String ?? emptyStr
        self.time = data?["time_column"] as? String ?? emptyStr
        self.invited = data?["invited"] as? Bool ?? false
        self.attending = data?["attending"] as? Bool ?? false
        let urls = ImageUrls(with: data?["banner_image"] as? [String:Any])
        self.bannerImage = urls
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : eventId ?? zero,
            "user_id": userId ?? zero,
            "location_id": locationId,
            "name": name ?? emptyStr,
            "address": address ?? emptyStr,
            "description": description ?? emptyStr,
            "longitude": longitude ?? 0.0,
            "latitude": latitude ?? 0.0,
            "is_paid": isPaid ?? emptyStr,
            "is_published": isPublished ?? emptyStr,
            "date": date ?? emptyStr,
            "time_column": time ?? emptyStr,
            "attending" : attending ?? false,
            "invited" : invited ?? false,
            "banner_image": bannerImage ?? [:]
        ] as [String : Any]
    }
}

