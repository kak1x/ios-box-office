//
//  MovieInfoDataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import UIKit

final class MovieInfoDataLoader {
    private let networkManager = NetworkManager()
    
    func loadMovieInfo(movieCode: String?,
                       completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let movieCode = movieCode else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMovieInfo(movieCode: movieCode)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
            result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadMoviePosterImage(movieName: String?,
                            completion: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let movieName = movieName else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMoviePoster(movieName: movieName)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: MoviePoster.self) {
            [weak self] result in
            switch result {
            case .success(let data):
                let urlText = self?.searchPosterURL(data: data)
                self?.loadImage(urlText: urlText) { image in
                    completion(.success(image))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func searchPosterURL(data: MoviePoster) -> String? {
        guard let firstItem = data.items.first else { return nil }
        
        let urlText = firstItem.imageURLText
        
        return urlText
    }
    
    private func loadImage(urlText: String?, completion: @escaping (UIImage?) -> ()) {
        guard let urlText = urlText, let url = URL(string: urlText) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let cachedKey = NSString(string: urlText)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                completion(cachedImage)
            } else {
                guard let data = try? Data(contentsOf: url) else {
                    completion(nil)
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                completion(image)
            }
        }
    }
}
