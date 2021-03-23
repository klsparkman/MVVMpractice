//
//  CharacterController.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/17/21.
//

import UIKit

class CharacterController {
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://rickandmortyapi.com/api")
    static let characterEndpoint = "/character/"
    static var characters: [Character] = []
    
    // MARK: - Fetch Character
    static func fetchCharacter(withSearchTerm searchTerm: String, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
        // URL
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let characterURL = baseURL.appendingPathComponent(characterEndpoint)
        var urlComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "name", value: searchTerm)]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        // Data Task
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            // Error Handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // Check for data
            guard let data = data else {return completion(.failure(.noData))}
            
            // Decode data
            do {
                let characters = try JSONDecoder().decode(TopLevelObject.self, from: data).results
                self.characters = characters
                completion(.success(characters))
            } catch {
                print(error, error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    // MARK: - Fetch Image
    static func fetchImage(for character: Character, completion: @escaping (Result<UIImage, CharacterError>) -> Void) {
        guard let recipeImageURL = URL(string: character.image ) else {
            return completion(.failure(.noData)) }
        URLSession.shared.dataTask(with: recipeImageURL) { (data, _, error) in
            if let error = error {
                completion(.failure(.thrown(error)))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let image = UIImage(data: data) else {
                return completion(.failure(.noData))
            }
            completion(.success(image))
        }.resume()
    }
}// End of class
