////
////  DownloadWithEscaping.swift
////  IntermediateBootcamp
////
////  Created by Denis DRAGAN on 17.11.2023.
////
//
//import SwiftUI
//
//struct PostsModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//
//class DownloadWithEscapingViewModel: ObservableObject {
//    @Published var posts: [PostsModel] = []
//    
//    init() {
//        getPosts()
//    }
//    
//    func getPosts() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//        
//        downloadData(fromURL: url) { data in
//            if let data = data {
//                guard let newPosts = try? JSONDecoder().decode([PostsModel].self, from: data) else { return }
//                DispatchQueue.main.async { [weak self] in
//                    self?.posts = newPosts
//                }
//            } else {
//                print("No data returned")
//            }
//        }
//    }
//}
//
//func downloadData(fromURL url: URL, completion: @escaping (_ data: Data?) -> ()) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard
//            let data = data,
//            let response = response as? HTTPURLResponse,
//            error == nil,
//            response.statusCode >= 200 && response.statusCode < 300
//        else {
//            print("Error downloading data...")
//            completion(nil)
//            return
//        }
//        
//        completion(data)
//        
//    }.resume()
//}
//
//
//struct DownloadWithEscaping: View {
//    @StateObject var vm = DownloadWithEscapingViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(vm.posts) { post in
//                    VStack(alignment: .leading ,spacing: 20) {
//                        HStack {
//                            Text("User ID: \(post.userId)")
//                            Spacer()
//                            Text("ID: \(post.id)")
//                        }
//                        .foregroundStyle(.red)
//                        
//                        Text(post.title)
//                        Text(post.body)
//                            .foregroundStyle(.gray)
//                    }
//                    .font(.headline)
//                    .fontWeight(.semibold)
//                    .padding()
//                }
//            }
//            .scrollIndicators(.hidden)
//            .listStyle(.plain)
//            .navigationTitle("JSONHolders Data")
//        }
//    }
//}
//
//#Preview {
//    DownloadWithEscaping()
//}
