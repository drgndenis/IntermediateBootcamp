//
//  Alerts.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 12.11.2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class UserViewModel: ObservableObject {
    @Published var userData: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    
    init() {
        getData()
        updateFilteredArray()
    }
    
    func getData() {
        let user1 = UserModel(name: "Denis", points: 99, isVerified: true)
        let user2 = UserModel(name: "Samet", points: 100, isVerified: false)
        let user3 = UserModel(name: "Yılmaz", points: 80, isVerified: false)
        let user4 = UserModel(name: "İlkkan", points: 86, isVerified: false)
        let user5 = UserModel(name: "Aysenur", points: 50, isVerified: true)
        let user6 = UserModel(name: "Gizem", points: 65, isVerified: true)
        let user7 = UserModel(name: "Caner", points: 72, isVerified: false)
        let user8 = UserModel(name: "Bulut", points: 34, isVerified: false)
        let user9 = UserModel(name: "Rabia", points: 14, isVerified: true)
        let user10 = UserModel(name: "Seyma", points: 39, isVerified: false)
        
        userData.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
    
    func updateFilteredArray() {
        //sort
//        filteredArray = userData.sorted(by: { $0.points > $1.points })
        
        //filter
        filteredArray = userData.filter({ !$0.isVerified })
        //map
    }
}

struct Arrays: View {
    @StateObject var vm = UserViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.filteredArray) { index in
                    VStack(alignment: .leading) {
                        Text(index.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(index.points)")
                            Spacer()
                            if index.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
            }
        }
    }
}
    
    #Preview {
        Arrays()
    }
