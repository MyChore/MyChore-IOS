//
//  FirebaseStorageManager.swift
//  MyChore
//
//  Created by 유상 on 2023/08/18.
//

import Foundation
import FirebaseStorage
import Firebase

class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    
    func uploadImage(image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd_HHmmssss"
        let pathRoot = dateFormatter.string(from: Date())
        
        let imageName = pathRoot
        
        let firebaseReference = Storage.storage().reference().child(imageName)
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
}
