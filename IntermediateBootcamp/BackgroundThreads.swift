//
//  BackgroundThreads.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 15.11.2023.
//

import SwiftUI

class BackgroundThreadsViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let data = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = data
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreads: View {
    @StateObject var vm = BackgroundThreadsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .padding(.horizontal)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    BackgroundThreads()
}
