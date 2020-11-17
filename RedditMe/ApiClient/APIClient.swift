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

class APIClient {
    
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
        guard let fullUrl = requestType.path.asURLWithComponents(params: params?.asDictionary()) else { return }
        var request = URLRequest(url: fullUrl)
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
        perform(request: request) { (data, error) in
            do {
                completion(try JSONDecoder().decode(T.self, from: data ?? Data()), error)
            } catch {
                completion(nil, CustomError.generalError)
            }
        }
    }
    
    private func perform(request: URLRequest, completion: @escaping (Data?,Error?) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }

}

    
