//
//  FetchItemsViewModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import SwiftUI

struct FetchItemsViewModel {
    
    static let shared = FetchItemsViewModel()
    
    init() {}
    
    enum ModelType {
        case films
        case people
        case starships
        case planets
    }
    
    func fetchPerson(searchText: String, completion: @escaping(Result<[PersonModel], Error>) -> Void){
        request(modelType: .people, route: .people(searchText), completion: completion)
    }
    
    func fetchFilm(searchText: String, completion: @escaping(Result<[FilmModel], Error>) -> Void) {
        request(modelType: .films, route: .films(searchText), completion: completion)
    }

    func fetchPlanet(searchText: String, completion: @escaping(Result<[PlanetModel], Error>) -> Void) {
        request(modelType: .planets, route: .planets(searchText), completion: completion)
    }

    func fetchStarship(searchText: String, completion: @escaping(Result<[StarshipModel], Error>) -> Void) {
        request(modelType: .starships, route: .starships(searchText), completion: completion)
    }
    
    func fetchAll(searchText: String, completion: @escaping(([ItemModel]) -> ())) {
        var searchResult: [ItemModel] = []
        
        let group = DispatchGroup()
        
        group.enter()
        
        fetchFilm(searchText: searchText) { result in
            switch result {
            case .success(let success):
                for item in success {
                    let filmData = ItemModel(type: "Film",
                                             parameter1: "Title: \(item.title)",
                                             parameter2: "Director: \(item.director)",
                                             parameter3: "Producer: \(item.producer)")
                    searchResult.append(filmData)
                }
            case .failure(_):
                print("No film found")
            }
            group.leave()
        }
        group.enter()
        fetchPerson(searchText: searchText) { result in
            switch result {
            case .success(let success):
                for item in success{
                    let personData = ItemModel(type: "People",
                                               parameter1: "Name: \(item.name)",
                                               parameter2: "Gender: \(item.gender)",
                                               parameter4: "Starships piloted: \(item.starships?.count ?? 0)")
                    searchResult.append(personData)
                }
            case .failure(_):
                print("No person found")
            }
            group.leave()
        }
        group.enter()
        fetchPlanet(searchText: searchText) { result in
            switch result {
            case .success(let success):
                for item in success {
                    let planetData = ItemModel(type: "Planet",
                                               parameter1: "Name: \(item.name)",
                                               parameter2: "Diameter: \(item.diameter)",
                                               parameter3: "Population: \(item.population)")
                    searchResult.append(planetData)
                }
            case .failure(_):
                print("No planet found")
            }
            group.leave()
        }
        group.enter()
        fetchStarship(searchText: searchText) { result in
            switch result {
            case .success(let success):
                for item in success {
                    let starshipData = ItemModel(type: "Starships",
                                                 parameter1: "Name: \(item.name)",
                                                 parameter2: "Model: \(item.model)",
                                                 parameter3: "Manufacturer: \(item.manufacturer)",
                                                 parameter4: "Passengers: \(item.passengers)")
                    searchResult.append(starshipData)
                }
            case .failure(_):
                print("No starship found")
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(searchResult)
        }
    }
    
    private func createRequest(route: Route) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = URL(string: urlString) else { return nil }
        let urlRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    private func request<T:Codable> (modelType: ModelType, route: Route, completion: @escaping(Result<[T], Error>) -> Void) {

        guard let request = createRequest(route: route) else {
            completion(.failure(AppError.unknownError))
            return
        }
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            let decoder = JSONDecoder()
            if let data {
                    do {
                        let item = try decoder.decode(FetchResult<T>.self, from: data).results
                        completion(.success(item))
                    } catch {
                        completion(.failure(error))
                    }
                }
        }
        task.resume()
    }
    
        
}
