//
//  RequestManager.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import Foundation

enum RequestError: Error {
    case invalidURL
    case requestFailure
}

final class RequestManager {
    
    func signUpWith(name: String, email: String, password: String, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        let urlString = "https://apiecho.cf/api/signup/"
        guard let url = URL(string: urlString) else { completionHandler(.failure(.invalidURL)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
        request.httpBody = parameters.percentEncoded() 
        URLSession.shared.dataTask(with: request) { (data, request, error) in
            guard let data = data, error == nil else { completionHandler(.failure(.requestFailure)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func logInWith(email: String, password: String, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        let urlString = "https://www.apiecho.cf/api/login/"
        guard let url = URL(string: urlString) else { completionHandler(.failure(.invalidURL)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        request.httpBody = parameters.percentEncoded()
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { completionHandler(.failure(.requestFailure)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func fetchText(locale: String, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        let urlString = "https://apiecho.cf/api/get/text/"
        guard var urlComp = URLComponents(string: urlString) else { completionHandler(.failure(.invalidURL)); return }
        urlComp.queryItems = [URLQueryItem(name: "locale", value: locale)]
        urlComp.percentEncodedQuery = urlComp.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComp.url else { return }
            var request = URLRequest(url: url)
        request.setValue("Bearer \(User.shared.accessToken)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { completionHandler(.failure(.requestFailure)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
}
