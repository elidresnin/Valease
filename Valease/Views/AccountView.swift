//
//  AccountView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/13/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct AccountView: View {
    @EnvironmentObject var user: User
    @State var showSheet = false
    var body: some View {
        VStack{
            Image(uiImage: user.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 320)
            Spacer()
            Button{
                showSheet.toggle()
            } label: {
                Text("Update Picture")
                    .font(Constants.mediumFont)
            }.padding(10)
            
            
            Spacer()
            
            TextField("name", text: $user.name)
                .font(Constants.mediumFont)
                .padding()
                .multilineTextAlignment(.center)
                .font(Constants.mediumFont)
                .border(Color.valeaseOrange, width: 4)
                .padding()
//                .onSubmit {
//                    guard let uid = Auth.auth().currentUser?.uid else {return}
//
//                    Database.database().reference().child("users/\(uid)/nameData").setValue(user.name)
//                }
            Spacer()
            
            Button {
                guard let uid = Auth.auth().currentUser?.uid else {return}
                         
                Database.database().reference().child("users/\(uid)/nameData").setValue(user.name)
            } label: {
                Text("Update Account")
                    .font(Constants.mediumFont)
                    .foregroundColor(Color.textColor)
                    .padding([.leading, .trailing], 60)
                    .padding([.top, .bottom], 10)
                    .background(Color.valeaseTeal)
                    .cornerRadius(20)
            }
            Button {
                let success: ()? = try? Auth.auth().signOut()
                if let _ = success{
                    user.loggedIn = false
                }
            } label: {
                Text("Sign out")
                    .font(Constants.mediumFont)
                    .foregroundColor(Color.textColor)
                    .padding(.horizontal, 105)
                    .padding(.vertical, 10)
                    .background(Color.valeaseTeal)
                    .cornerRadius(20)
            }
            Spacer()
            
        }
        .padding()
        .background(Color.background)
        .sheet(isPresented: $showSheet, onDismiss: {
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            guard let imageData = user.image.jpegData(compressionQuality: 0.5) else {return}
            Storage.storage().reference().child("users/\(uid)").putData(imageData){ meta, error in
                if let _ = meta{
                    Storage.storage().reference().child("users/\(uid)").downloadURL { url, error in
                        if let u = url{
                            Database.database().reference().child("users/\(uid)/imagepath").setValue(u.absoluteString)
                        }
                    }
                }
            }
        }, content: {
            ImagePicker(selectedImage: $user.image)
        })
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(User())
    }
}
