//
//  FileManagerView.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 19.11.2023.
//

import SwiftUI

class LocalFileManager {
    // static let instance = LocalFileManager() // Singleton
    let folderName = "MyApp_Images"
    
    init() {
        createFolder()
    }
    
    // Create new Folder for images
    func createFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName, directoryHint: .isDirectory)
                .path
        else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Folder create error: \(error)")
            }
        }
    }
    
    // Delete the folder
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName, directoryHint: .isDirectory)
                .path
        else { return }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder")
        } catch let error {
            print("Error deleting folder:\(error)")
        }
    }
    
    // Save Image in FileManager
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0), // resmin boyutu
            let path = getPathForImage(name: name) // do-try icinde path'in cagirilmasi ve optional olan funcin kontrolu
        else {
            return "Error getting data.."
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving"
        } catch let error {
            return "Error is: \(error)"
        }
    }
    
    // Delete Image in FileManager
    func deleteImage(name: String) -> String{
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path)
        else {
            return "Error getting path..."
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            return "Successfully deleted."
        } catch let error {
            return "Error deleting item: \(error)"
        }
    }
    
    // File Manager'dan image'i getirme
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    // resmin kaydedilecegi alan
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName)
                .appending(path: "\(name).jpg", directoryHint: .isDirectory)
        else {
            print("Error")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageName = "steve-jobs"
    
    @Published var infoMessage = ""
    
    // Dependecy Injection
    let manager: LocalFileManager
    init(manager: LocalFileManager) {
        self.manager = manager
        getImageFromAssets()
        // getImageFromFileManager()
    }
    
    // Uygulama uzerinde bulunan resmi getirme
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    
    // file managerda kaydedilen resmi getirme
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    // file manager'a kaydetme
    func saveImage() {
        guard let image = image else { return }
        // LocalFileManager class'indan funcin cagirilmasi
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    // Delete image in LocalFileManager
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
    }
}

struct FileManagerView: View {
    @StateObject var vm: FileManagerViewModel
    let navigationTitle = "File Manager"
    
    // Dependecy Injection
    init(manager: LocalFileManager) {
        _vm = StateObject(wrappedValue: FileManagerViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
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
                        vm.saveImage()
                    }, label: {
                        CustomButtonText(textName: "Save to File Manager", backgroundColor: .blue)
                    })
                    // Delete button
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        CustomButtonText(textName: "Delete from File Manager", backgroundColor: .red)
                    })
                }
                
                // Info message with Text
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .foregroundStyle(.red
                    )
                Spacer()
            }
            .navigationTitle(navigationTitle)
        }
    }
}

#Preview {
    FileManagerView(manager: LocalFileManager())
}
