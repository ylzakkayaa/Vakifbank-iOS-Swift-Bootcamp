//
//  Client.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 23.11.2022.
//

import Foundation

final class Client {
    
    enum Endpoints {
        static let base = "https://www.breakingbadapi.com/api/"
        
        case allCharacters
        case characterQuotes(String) //Bu case'de bir outhor değişkeni bekliyorum.
        case allEpisodes
        
        var stringValue: String {
            switch self {
            case .allCharacters:
                return Endpoints.base + "characters"
            case .characterQuotes(let author):
                return Endpoints.base + "quote?author=\(author)"
            case .allEpisodes:
                return Endpoints.base + "episodes"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    //Karakterleri getiren fonksiyon.
    class func getCharacters(completion: @escaping ([CharacterModel]?, Error?) -> Void) {
        print("Buraya girdi")
        taskForGETRequest(url: Endpoints.allCharacters.url, responseType: [CharacterModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    //Cümleleri getiren fonksyion.
    class func getQuotes(author: String, completion: @escaping ([QuoteModel]?, Error?) -> Void) {
        let formattedString = author.replacingOccurrences(of: " ", with: "+")
        taskForGETRequest(url: Endpoints.characterQuotes(formattedString).url, responseType: [QuoteModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    //Bölümleri getiren fonksiyon.
    class func getEpisodes(completion: @escaping ([EpisodesModel]?, Error?) -> Void) {
        print("Buraya girdi episodes")
        taskForGETRequest(url: Endpoints.allEpisodes.url, responseType: [EpisodesModel].self) { response, error in
            print(Endpoints.allEpisodes.url)
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
