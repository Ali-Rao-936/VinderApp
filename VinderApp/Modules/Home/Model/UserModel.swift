//
//  UserDetailModel.swift
//  VinderApp
//
//  Created by iOS Dev on 12/10/2023.
//

import Foundation
// MARK: - Users List
struct UserListModel: Codable {
    let response: UserList?
}

struct UserList: Codable {
    let code: Int?
    let messages: [String]?
    let data: [User]?
}

// MARK: - UserData
struct UserDetailModel: Codable {
    let response: UserDetailResponse
}

struct UserDetailResponse: Codable {
    let messages: [String]?
    let data: User?
}

// MARK: - LikedUser
struct LikedUserModel: Codable {
    let response: LikedUser?
}

struct LikedUser: Codable {
    let messages: String?
    let data: User?
}

struct User: Codable {
    let id, level, likedTo: Int?
    let name, about: String?
    let email: String?
    let location: String?
    let profileImg: String?
    let sportsInterest: [SportsInterest]?
    let eventList: [Event]?
        
    enum CodingKeys: String, CodingKey {
        case id, name, email, about, level
        case location = "location_name"
        case profileImg = "profile_img"
        case sportsInterest = "sports_interest"
        case eventList = "myevents"
        case likedTo = "liked_to"
    }
}

struct SportsInterest: Codable {
    let id: Int?
    let name: String?
    let sportImage: ImageURLS?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case sportImage = "image_urls"
    }
}

struct ImageURLS: Codable {
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "3x"
    }
}

/* {
    "response": {
        "data": {
            "id": 9,
            "name": null,
            "email": "ankita2@gmail.com",
            "email_verified_at": null,
            "password": "$2y$10$.YFUsFhicTYbmI5D6mEak.jETbtTcNirgL4HcFOjQr/kmg3L6mof.",
            "remember_token": null,
            "created_at": "2023-09-23 11:40:55",
            "updated_at": "2023-09-23 12:31:29",
            "phone_number": "28736127545",
            "age": null,
            "otp": 822,
            "otp_verified": 0,
            "otp_verified_at": null,
            "gender": "",
            "about": null,
            "allow_notification": 0,
            "login_purpose": "",
            "location_id": null,
            "location_name": null,
            "latitude": null,
            "longitude": null,
            "turn_on_location": 0,
            "level": null,
            "profile_img": "http://45.76.178.21:5070/assets/images/placeholder.png",
            "preffered_language": null,
            "block": 0,
            "last_password_updated": null,
            "recover_password_key": "7iVDIzGFs",
            "recover_attempt_at": "2023-09-23 12:31:29",
            "login_via": null,
            "deleted": null,
            "deleted_at": null,
            "last_login_at": "2023-09-23 11:40:55",
            "last_logout_at": null,
            "access_token": "10|oNGtYDY7PmK7JtSxgEeq988ClnqHtltSzTPbeG1C44d67ce4",
            "signup_via": "email",
            "image_urls": {
                "2x": "http://45.76.178.21:5070/assets/images/placeholder.png",
                "3x": "http://45.76.178.21:5070/assets/images/placeholder.png",
                "1x": "http://45.76.178.21:5070/assets/images/placeholder.png"
            },
            "sports_interest": [
                {
                    "id": 1,
                    "name": "volley ball",
                    "img": "PPMGn5MXeAXWgOqIcRHhnAiDTfjYrI6MkfgxDZAn.jpg",
                    "active": "1",
                    "created_at": "2023-09-16 12:02:02",
                    "updated_at": "2023-09-16 12:02:02",
                    "image_urls": {
                        "1x": "http://45.76.178.21:5070//storage/sports//PPMGn5MXeAXWgOqIcRHhnAiDTfjYrI6MkfgxDZAn.jpg",
                        "2x": "http://45.76.178.21:5070//storage/sports//PPMGn5MXeAXWgOqIcRHhnAiDTfjYrI6MkfgxDZAn@2x.jpg",
                        "3x": "http://45.76.178.21:5070//storage/sports//PPMGn5MXeAXWgOqIcRHhnAiDTfjYrI6MkfgxDZAn@3x.jpg"
                    }
                }
            ],
            "photos": [],
            "myevents": [
                {
                    "id": 18,
                    "user_id": 7,
                    "name": "test events",
                    "description": "What is Lorem Ipsum?\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    "location_id": 1,
                    "address": "test address",
                    "latitude": 40.7128,
                    "longitude": 74.006,
                    "banner": null,
                    "is_paid": "0",
                    "date": "2023-10-06",
                    "time_column": "03:30:00",
                    "is_published": "1",
                    "created_at": "2023-10-05 06:25:15",
                    "updated_at": "2023-10-05 06:25:15",
                    "interest_id": 3,
                    "price": "10.00",
                    "event_start_time_utc": "2023-10-06 03:30:00",
                    "banner_image": {
                        "2x": "https://45.76.178.21:5070/assets/images/placeholder.png",
                        "3x": "https://45.76.178.21:5070/assets/images/placeholder.png",
                        "1x": "https://45.76.178.21:5070/assets/images/placeholder.png"
                    },
                    "attendees_count": 0,
                    "creator": {
                        "id": 7,
                        "name": "21sasasa",
                        "email": "mk@mailinator.com",
                        "age": 0,
                        "gender": "",
                        "location_id": 3,
                        "location_name": "Afghanistan",
                        "latitude": null,
                        "longitude": null,
                        "level": null,
                        "profile_img": "http://45.76.178.21:5070//storage/users//nnrlroN8cWdx4HXtcSbDohiMYpHncdrFPahdlXiH@3x.png",
                        "preffered_language": null,
                        "block": 0,
                        "login_via": null,
                        "deleted": null,
                        "signup_via": "email",
                        "image_urls": {
                            "1x": "http://45.76.178.21:5070//storage/users//nnrlroN8cWdx4HXtcSbDohiMYpHncdrFPahdlXiH.png",
                            "2x": "http://45.76.178.21:5070//storage/users//nnrlroN8cWdx4HXtcSbDohiMYpHncdrFPahdlXiH@2x.png",
                            "3x": "http://45.76.178.21:5070//storage/users//nnrlroN8cWdx4HXtcSbDohiMYpHncdrFPahdlXiH@3x.png"
                        }
                    },
                    "interest": {
                        "id": 3,
                        "name": "Tennis",
                        "img": "YqkwtE6BtnFKaHYg084d1z0ZrNfnVrmiPJtNTO36.png",
                        "active": "1",
                        "created_at": "2023-09-28 10:15:00",
                        "updated_at": "2023-09-28 10:15:00",
                        "image_urls": {
                            "1x": "http://45.76.178.21:5070//storage/sports//YqkwtE6BtnFKaHYg084d1z0ZrNfnVrmiPJtNTO36.png",
                            "2x": "http://45.76.178.21:5070//storage/sports//YqkwtE6BtnFKaHYg084d1z0ZrNfnVrmiPJtNTO36@2x.png",
                            "3x": "http://45.76.178.21:5070//storage/sports//YqkwtE6BtnFKaHYg084d1z0ZrNfnVrmiPJtNTO36@3x.png"
                        }
                    }
                }
            ]
        },
        "code": 200,
        "messages": [
            "User list supplied successfully"
        ]
    }
}
*/
