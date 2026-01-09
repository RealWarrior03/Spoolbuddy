//
//  NetworkManager.swift
//  Spoolman
//
//  Created by Henry Krieger on 09.01.26.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct NetworkManager {
    
  static let shared = NetworkManager()
  private init() {}
  
  func request<T: Decodable>(
    url: URL,
    method: HTTPMethod = .GET,
    body: Data? = nil
  ) async throws -> T {
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    
    // Setting headers
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    // Decoding the response data
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let response = try decoder.decode(T.self, from: data)
    
    return response
  }
}
