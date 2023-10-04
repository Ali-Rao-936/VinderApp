//
//  OtherResponseModels.swift
//  VinderApp
//
//  Created by ios Dev on 04/10/2023.
//

import Foundation

struct Locations : Codable {

    let id: Int? // 1
    let code: String? // 2
    let name: String? // 3
    
    init(id: Int, name: String, code: String){
        self.id = id
        self.code = code
        self.name = name
    }

    init(with data: [String: Any]?) {

        self.id = data?["id"] as? Int ?? zero
        self.name = data?["name"] as? String ?? emptyStr
        self.code = data?["code"] as? String ?? emptyStr
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : id ?? zero,
            "name": name ?? emptyStr,
            "code": code ?? emptyStr
        ] as [String : Any]
    }
}
