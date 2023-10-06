//
//  EventsRequestModel.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import Foundation

struct CreateEventRequest{
    var name: String?
    var locationId: Int?
    var latitude: Double?
    var longitude : Double?
    var date : String?
    var time : String?
//    var banner : String?
    var isPaid : Int?
    var address : String?
//    var invitees : [Int]?
    var description : String?
    var interestId : Int?

    init(name: String?,description: String, locationId: Int, address: String, date: String, time: String, isPaid: Int, latitude: Double?, longitude: Double?,interestId: Int ){
        self.name = name
        self.description = description
        self.address = address
        self.date = date
        self.time = time
        self.locationId = locationId
        self.isPaid = isPaid
        self.address = address
//        self.invitees = invitees
        self.latitude = latitude
        self.longitude = longitude
        self.interestId = interestId
    }
    // photo[0], banner
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["name": name ?? emptyStr,
                                 "description": description ?? emptyStr,
                                 "address": address ?? emptyStr,
                                 "is_paid": isPaid ?? zero,
                                 "date": date ?? emptyStr,
                                 "location_id": locationId,
                                 "time_column": time ?? emptyStr,
                                 "latitude": latitude ?? 0.0,
                                 "longitude": longitude ?? 0.0,
//                                 "invitee": invitees ?? []
                                 "interest_id": interestId ?? 0.0]
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
    let interestId : Int
    let price: String
    let attendeesCount: Int
    let creator : UserModel
    
    init(eventId: Int, userId: Int, locationId: Int, address: String, latitude: Double, longitude: Double, isPaid: String, date: String, time: String, isPublished: String, bannerImage: ImageUrls, description: String, name: String, attending: Bool, invited: Bool, interestId: Int, price: String, attendeesCount: Int, creator: UserModel){
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
        self.interestId = interestId
        self.price = price
        self.attendeesCount = attendeesCount
        self.creator = creator
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
        self.interestId = data?["interest_id"] as? Int ?? zero// interest_id
        self.price = data?["price"] as? String ?? emptyStr
        self.attendeesCount = data?["attendees_count"] as? Int ?? 0
        
        let user = UserModel(with: data?["creator"] as? [String: Any])
        self.creator = user
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
            "banner_image": bannerImage ?? [:],
            "interest_id" : interestId ?? 0,
            "price" : price ?? "",
            "attendees_count" : attendeesCount ?? 0,
            "creator" : creator
        ] as [String : Any]
    }
}

//"id": 15,
// "user_id": 36,
// "name": "we're we're",
// "description": "eerie we’re erwew",
// "location_id": 1,
// "address": "testeteuywqt",
// "latitude": 40,
// "longitude": 89,
// "banner": null,
// "is_paid": "0",
// "date": "2023-10-26",
// "time_column": "10:20:00",
// "is_published": "1",
// "created_at": "2023-10-04 06:23:33",
// "updated_at": "2023-10-04 06:23:33",
// "interest_id": 0,
// "price": "0.00",
// "event_start_time_utc": null,
// "banner_image": {
//     "2x": "https://45.76.178.21:5070/assets/images/placeholder.png",
//     "3x": "https://45.76.178.21:5070/assets/images/placeholder.png",
//     "1x": "https://45.76.178.21:5070/assets/images/placeholder.png"
// },
// "attendees_count": 0,
// "creator": {
//     "id": 36,
//     "name": "5555555ewrw",
//     "email": "5@mailinator.com",
//     "age": null,
//     "gender": "",
//     "level": null,
//     "profile_img": null,
//     "preffered_language": null,
//     "block": 0,
//     "login_via": null,
//     "deleted": null,
//     "signup_via": "email",
//     "image_urls": {
//         "2x": "https://45.76.178.21:5070/assets/images/placeholder.png",
//         "3x": "https://45.76.178.21:5070/assets/images/placeholder.png",
//         "1x": "https://45.76.178.21:5070/assets/images/placeholder.png"
//     }
