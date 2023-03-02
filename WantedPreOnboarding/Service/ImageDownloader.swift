//
//  ImageDownloader.swift
//  WantedPreOnboarding
//
//  Created by dudu on 2023/03/02.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidStatusCode
}

struct ImageDownloader {
    static func getImage(with id: Int) async throws -> Data {
        guard let url = URL(string: "https://picsum.photos/id/\(id)/200/200") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              statusCode ~= 200 else {
            throw NetworkError.invalidStatusCode
        }
        
        return data
    }
}
