//
//  DownloadWithCombine.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 17.11.2023.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var cancellables = Set<AnyCancellable>()
       
        // Combine discussion
        /*
         // 1. Sign up for monthly subscription for package to be delivired
         // 2. the compony would make the package behind the scene
         // 3. receive the package at your front door
         // 4. make sure the box isn't damaged
         // 5. open and make sure the item is correct
         // 6. use the item!!
         // 7. cancellable any time!!
         */
        
        // 1. create the publisher
        URLSession.shared.dataTaskPublisher(for: url)
        // 2.subscribe the publisher on background thread (Actually we don't need do)
//            .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. receive on main thread
            .receive(on: DispatchQueue.main)
        // 4. tryMap (Check the data is good)
            .tryMap(handleOutput)
        // 5. decode (decode data into PostModel)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        // 6. sink (put the item into our app)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
        // 7. store (cancel subscription if needed)
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.posts) { post in
                    LazyVStack(alignment: .leading ,spacing: 20) {
                        HStack {
                            Text("User ID: \(post.userId)")
                            Spacer()
                            Text("ID: \(post.id)")
                        }
                        .foregroundStyle(.red)
                        
                        Text(post.title)
                        Text(post.body)
                            .foregroundStyle(.gray)
                    }
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle("JSONHolders Data")
        }
    }
}

#Preview {
    DownloadWithCombine()
}
