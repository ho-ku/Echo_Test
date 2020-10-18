//
//  Decoder.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

final class Decoder {
    
    static func decodeUser(from data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
        guard let dataModel = try? JSONDecoder().decode(SignUpModel.self, from: data) else { return }
        User.shared.name = dataModel.data.name
        User.shared.accessToken = dataModel.data.access_token
        User.shared.save()
    }
    
}
