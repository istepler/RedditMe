//
//  APIClient.swift
//  RedditMe
//
//  Created by Andrey Krit on 16.11.2020.
//

import Foundation

enum RequestType {
    case token(clientId: String, body: TokenRequestModel)
    case topEntries
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
}

extension RequestType {
    
    var method: Method {
        switch self {
        case .token:
            return .post
        case .topEntries:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .token:
            return "https://www.reddit.com/api/v1/access_token"
        default:
            return ""
        }
    }
    
}

enum CustomError: Error {
    case generalError
}

class APICLient {
    
    private var session: URLSession!
    
    init() {
        let config = URLSessionConfiguration.default
        session = .init(configuration: config, delegate: nil, delegateQueue: nil)
    }
    
    func execute<T:Codable>(
        requestType: RequestType,
        body: Codable? = nil,
        params: Codable? = nil,
        response: T.Type,
        completion: @escaping (T?, Error?) -> Void
    ) {
        guard let url = URL(string: requestType.path) else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let params = params?.asDictionary() {
            components?.queryItems = []
            for (key, value) in params {
                components?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = requestType.method.rawValue
        var authorizationHeader = ""
        switch requestType {
        case .token(let clientId, let body):
            guard let data = "\(clientId):".data(using: String.Encoding.utf8) else { return }
            let encodedString = data.base64EncodedString()
            authorizationHeader = "Basic \(encodedString)"
            request.httpBody = body.urlEncoded
        default:
            request.httpBody = body?.encoded()
            authorizationHeader = "Bearer"
        }
        request.addValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        execute(request: request) { (data, error) in
            do {
                completion(try JSONDecoder().decode(T.self, from: data ?? Data()), error)
            } catch {
                completion(nil, CustomError.generalError)
            }
        }
    }
    
    private func execute(request: URLRequest, completion: @escaping (Data?,Error?) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }

}

    