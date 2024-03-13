//
//  User.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/13/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class User: ObservableObject{
    @Published var email: String
    @Published var password: String
    @Published var name: String = ""
    @Published var image: UIImage = UIImage(named: "user") ?? UIImage()
    @Published var loggedIn: Bool = false
    @Published var uid: String = ""
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.uid = uid
        self.loggedIn = true
        
        Task{
            guard let n = try? await Database.database().reference().child("users/\(uid)/nameData").getData() else {return}
            self.name = n.value as? String ?? ""


            guard let i = try? await Database.database().reference().child("users/\(uid)/imagepath").getData() else {return}

            let url = i.value as? String ?? ""
            print(url)

            Storage.storage().reference(forURL: url).getData(maxSize: 1 * 2048 * 2048) { data, error in
                guard let imageData = data else {return}
                guard let image = UIImage(data: imageData) else {return}
                self.image = image
            }

        }
    }
}

