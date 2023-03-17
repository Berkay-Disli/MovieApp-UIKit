//
//  APICaller.swift
//  MovieApp-UIKit
//
//  Created by Berkay Disli on 17.03.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "b8ddd900f1e2cd21afe5458ee0fe67dd"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (TrendingTitleResponse) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
            
            do {
                let trendingMovies = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(trendingMovies)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getTrendingTVs(completion: @escaping (TrendingTitleResponse) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
            
            do {
                let trendingTVs = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(trendingTVs)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (TrendingTitleResponse) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
            
            do {
                let upcomingMovies = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(upcomingMovies)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (TrendingTitleResponse) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
            
            do {
                let populars = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(populars)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (TrendingTitleResponse) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
            
            do {
                let topRateds = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(topRateds)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
