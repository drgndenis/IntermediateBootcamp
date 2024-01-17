//
//  CacheView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 19.11.2023.
//

import SwiftUI

class CacheManager {

    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added the cache")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from cache!")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    @Published var cachedImage: UIImage? = nil
    let imageName = "steve-jobs"
    let manager: CacheManager
    
    // Dependecy Injection
    init(manager: CacheManager) {
        self.manager = manager
        getImage()
    }
    
    func getImage() {
        image = UIImage(named: imageName)
    }
    
    func addToCache() {
        guard let image = image else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

struct CacheView: View {
    @StateObject var vm: CacheViewModel
    
    // Dependecy Injection
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
                        vm.addToCache()
                    }, label: {
                        CustomButtonText(textName: "Save to Cache", backgroundColor: .blue)
                    })
                    // Delete button
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        CustomButtonText(textName: "Delete from Cache", backgroundColor: .red)
                    })
                }
                
                Button(action: {
                    vm.getImage()
                }, label: {
                    CustomButtonText(textName: "Get from Cache", backgroundColor: .green)
                })
                
                Spacer()
            }
            .navigationTitle("Cache")
        }
    }
}

#Preview {
    CacheView(manager: CacheManager())
}
