//
//  EventModel.swift
//  VinderApp
//
//  Created by iOS Dev on 16/10/2023.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}

struct JoinEventRequest: Codable {
    var eventId: Int?

//    var dictionary: [String: Any] {
//        return ["event_id": eventId ?? 0]
//     }
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
    }
}

//
//struct CreateEventRequest: Codable {
//    var name: String?
//    var locationId: Int?
//    var latitude: Double?
//    var longitude : Double?
//    var date : String?
//    var time : String?
////    var banner : String?
//    var isPaid : Int?
//    var address : String?
////    var invitees : [Int]?
//    var description : String?
//    var interestId : Int?
//
//    enum CodingKeys: String, CodingKey {
//        case name, description, address
//        case latitude, longitude, date
//        case isPaid = "is_paid"
//        case time = "time_column"
//        case locationId = "location_id"
//        case interestId = "interest_id"
//    }
//}

// MARK: - Events List
struct EventListModel: Codable {
    let response: EventList?
}

struct EventList: Codable {
    let messages: [String]?
    let data: [Event]?
    let code: Int?
}

// MARK: - Event Detail
struct EventDetailModel: Codable {
    let response: EventDetail?
    let error: ErrorResponse?
}

struct EventDetail: Codable {
    let messages: [String]?
    let data: Event?
    let code: Int?
}

struct ErrorResponse: Codable {
    let code: Int?
    let messages: [String]?
}

//"error": {
//        "code": 406,
//        "messages": [
//            "Name required",
//            "validation.required",
//            "validation.required",
//            "The is paid is required and must be 0,1",
//            "The address is required with max length of of 255",
//            "The latitude is required",
//            "The longitude is required",
//            "The interest id is required"
//        ]
//    }
struct Event: Codable {
    var eventId, userId, locationId: Int?
    var address, date, time: String?
    var latitude, longitude: Double?
    var isPaid: Int?
    var bannerImage: ImageURLS?
    var name, description: String?
    var attending, invited: Bool?
    var interestId, peopleJoinedCount: Int?
    var price: Float?
    var creator: User?
    var interest: SportsInterest?
    var invitee: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case userId = "user_id"
        case locationId = "location_id"
        case name, address, description, interest
        case longitude, latitude, date, invitee
        case isPaid = "is_paid"
        case time = "time_column"
        case invited, attending, price, creator
        case bannerImage = "banner_image"
        case interestId = "interest_id"
        case peopleJoinedCount = "attendees_count"
    }
    
    init(name:String, description:String, interestId:Int, latitude:Double, longitude:Double, date:String, time:String, address: String, isPaid: Int, price: Float) {
        self.name = name
        self.description = description
        self.interestId = interestId
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.time = time
        self.address = address
        self.isPaid = isPaid
        self.price = price
    }
}

//Response
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
