//
//  APICaller.swift
//  NewsApp
//
//  Created by Leysan Latypova on 01.09.2022.
//

import Foundation
import UIKit

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ddea133b58794b9ab3297af298e5328b")
    }
    
    private init () {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}



