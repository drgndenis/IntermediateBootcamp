//
//  CacheView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 19.11.2023.
//

import SwiftUI

class CacheManager {
    
    init() {

    }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    }()
}

class CacheViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let name = "steve-jobs"
    let manager: CacheManager

    init(manager: CacheManager) {
        self.manager = manager
        getImage()
    }
    
    func getImage() {
        image = UIImage(named: name)
    }
}

struct CacheView: View {
    @StateObject var vm: CacheViewModel
    
    init(manager: CacheManager) {
        _vm = StateObject(wrappedValue: CacheViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Get image in CacheViewModel
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                // Buttons
                HStack {
                    // Save button
                    Button(action: {
                        
                    }, label: {
                        CustomButtonText(textName: "Save to Cache", backgroundColor: .blue)
                    })
                    // Delete button
                    Button(action: {
                        
                    }, label: {
                        CustomButtonText(textName: "Delete from Cache", backgroundColor: .red)
                    })
                }
                
                Spacer()
            }
            .navigationTitle("Cache")
        }
    }
}

#Preview {
    CacheView(manager: CacheManager())
}
