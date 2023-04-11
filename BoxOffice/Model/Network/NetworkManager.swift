//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/21.
//

import Foundation

final class NetworkManager {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(request: URLRequest?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard var request = request else {
            completion(.failure(NetworkError.urlError))
            return
        }
        request.cachePolicy = .returnCacheDataElseLoad
        let cache = URLCacheManager.getURLCache(type: type)
        if let data = cache.cachedResponse(for: request)?.data {
            completion(self.decode(data: data, type: type))
        } else {
            session.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return }
                
                self.checkError(with: data, response, error) { result in
                    guard let response = response else { return }
                    
                    switch result {
                    case .success(let data):
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        completion(self.decode(data: data, type: type))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponseError))
            return
        }
        
        guard (200...299).contains(response.statusCode) else {
            completion(.failure(NetworkError.invalidHttpStatusCode(response.statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.emptyData))
            return
        }
        
        completion(.success(data))
    }
    
    private func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(type, from: data)
            return .success(decodedData)
        } catch {
            return .failure(NetworkError.decodeError)
        }
    }
}
