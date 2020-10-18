//
//  Decoder.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

final class Decoder {
    
    static func decodeUser(from data: Data) {
        guard let dataModel = try? JSONDecoder().decode(SignUpModel.self, from: data) else { return }
        User.shared.name = dataModel.data.name
        User.shared.accessToken = dataModel.data.access_token
        User.shared.save()
    }
    
    static func decodeText(from data: Data) -> String {
        guard let textModel = try? JSONDecoder().decode(TextModel.self, from: data) else { return "" }
        return textModel.data
    }
    
}
