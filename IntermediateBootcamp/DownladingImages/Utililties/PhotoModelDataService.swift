//
//  PhotoModelDataService.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 21.11.2023.
//

import Foundation
import Combine

class PhotoModelDataService {
    @Published var photoModels: [PhotoModel] = []
    static let istance = PhotoModelDataService()
    let url = "https://jsonplaceholder.typicode.com/photos"
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error is: \(error)")
                }
            } receiveValue: { [weak self] returnedPostModels in
                self?.photoModels = returnedPostModels
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
