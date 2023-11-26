//
//  LearnEscaping.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 16.11.2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
//        downloadData2 { data in
//            text = data
//        }
        
//        downloadData3 { [weak self] data in
//            self?.text = data
//        }
        
//        downloadData4 { [weak self] result in
//            self?.text = result.data
//        }
        
        downloadData5 { [weak self] DownloadResult in
            self?.text = DownloadResult.data
        }
    }
    
    func downloadData() -> String {
        return "Hello Guys"
    }
    
    func downloadData2(completion: (_ data: String) -> Void) {
            completion("Hello Guys")
    }
    
    func downloadData3(completion: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            completion("Hello Guys")
        })
    }
    
    func downloadData4(completion: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            let result = DownloadResult(data: "Hello Guys")
            completion(result)
        })
    }
    
    func downloadData5(completion: @escaping DownloadComplation) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            let result = DownloadResult(data: "Hello Guys")
            completion(result)
        })
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadComplation = (DownloadResult) -> ()

struct LearnEscaping: View {
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    LearnEscaping()
}
