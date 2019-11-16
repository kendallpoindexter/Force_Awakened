//
//  NetworkManager.swift
//  Project_Force_Awakened
//
//  Created by Kendall Poindexter on 11/15/19.
//  Copyright © 2019 Kendall Poindexter. All rights reserved.
//

import Foundation
import PromiseKit

struct NetworkManager {

    func fetchFilm( with id: Int) -> Promise<Film> {
        let filmURLString = "https://swapi.co/api/films/\(id)/"

        return Promise { seal in
            firstly {
                fetchObjectFromData(with: filmURLString, type: Film.self)
            }.done { film in
                seal.fulfill(film)
            }.catch { error in
                seal.reject(error)
            }

        }
    }

    func fetchCharacters( with urlString: [String]) -> Promise<[SWCharacter]> {
        let characterPromises = urlString.map {
            fetchCharacter(with: $0)
        }

        return Promise { seal in
            firstly {
                when(fulfilled: characterPromises)
            }.done { characters in
                seal.fulfill(characters)
            }.catch { error in
                seal.reject(error)
            }

        }
    }

  private func fetchCharacter( with urlString: String) -> Promise<SWCharacter> {
        return Promise { seal in
            firstly {
                fetchObjectFromData(with: urlString, type: APIcharacter.self)
            }.then { character in
                self.fetchSpecies(with: character.species).map { (character, $0) }
            }.then { character, species in
                self.fetchPlanet(with: character.homeworld).map { (character, species, $0)}
            }.done { character, species, planet in
                let swCharacter = SWCharacter(name: character.name, gender: character.gender, homeworld: planet.name, species: species)
                seal.fulfill(swCharacter)
            }.catch { error in
                seal.reject(error)
            }

        }
    }

   private func fetchSpecies( with urlStrings: [String]) -> Promise<[Species]> {
        let speciesPromises = urlStrings.map {
            fetchObjectFromData(with: $0, type: Species.self)
        }

        return Promise { seal in
            firstly {
                when(fulfilled: speciesPromises)
            }.done { species in
                seal.fulfill(species)
            }.catch { error in
                seal.reject(error)
            }

        }
    }

   private func fetchPlanet( with urlString: String) -> Promise<Planet> {
        return Promise { seal in
            firstly {
                fetchObjectFromData(with: urlString, type: Planet.self)
            } .done { planet in
                seal.fulfill(planet)
            }.catch { error in
                seal.reject(error)
            }
        }
    }

   private func fetchObjectFromData<T: Decodable>(with urlString: String, type: T.Type) -> Promise<T> {
        return Promise { seal in
            guard let url = URL(string: urlString) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                } else if let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode {
                    guard let data = data, let decodedData = self.decodeData(with: data, type: type) else { return }
                    seal.fulfill(decodedData)
                } else {
                    return
                }
            }
            task.resume()
        }
    }

   private func decodeData<T: Decodable>( with data: Data, type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            //How would I handle this error better
            print(error)
            return nil
        }
    }
}
