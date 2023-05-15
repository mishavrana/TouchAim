//
//  URLManager.swift
//  TouchMe
//
//  Created by Misha Vrana on 11.05.2023.
//

import Foundation

class URLManager: ObservableObject {
    @Published var response: Response?
    var fetchedResponse: Response? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.response = self?.fetchedResponse
            }
        }
    }
    
    func getPlayerStatuses() async throws {
        guard let url = URL(string: "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod") else {
            fatalError("Missing URL")
        }
        
        let URLRequest = URLRequest(url: url)
        let(data, response) = try await URLSession.shared.data(for: URLRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        let decodedData = try JSONDecoder().decode(Response.self, from: data)
        fetchedResponse = decodedData
    }
}
// Model of the respond
struct Response: Codable {
    var winner: String
    var loser: String
}
