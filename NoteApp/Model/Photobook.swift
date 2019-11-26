//
//  Photobook.swift
//  NoteApp
//
//  Created by MAC on 29/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
class Photobook{
    private var photos: [UIImage]
    
    public func get_photos() -> [UIImage]{
        return photos
    }
    public func delete(at: Int){
        photos.remove(at: at)
    }
    public func add(img: UIImage){
        photos.append(img)
    }
    init() {
        photos = [UIImage]()
    }
    public func fileSave(){
        var i = 0
        for img in photos{
            saveImage(imageName: String(i), image: img)
            i+=1
        }
    }
    public func fileload(){
        var i = 0
        while let img = loadImageFromDiskWith(fileName: String(i)+".jpeg") {
            add(img: img)
            i+=1
        }
    }
    func saveImage(imageName: String, image: UIImage) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("error saving file with error", error)
            }
        }
        
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
}
