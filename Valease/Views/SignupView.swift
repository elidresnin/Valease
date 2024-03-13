//
//  SignupView.swift
//  Valease
//
//  Created by Penelope Cohen (student LM) on 3/13/24.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @EnvironmentObject var user: User
    @State var forgotPassword: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.background)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(40)
                
                
                TextField("email address", text: $user.email)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                SecureField("password", text: $user.password)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(Constants.mediumFont)
                    .border(Color.valeaseOrange, width: 4)
                    .padding()
                Spacer()
                
                Button {
                    Auth.auth().sendPasswordReset(withEmail: user.email){ _ in
                        forgotPassword.toggle()
                    }
                } label: {
                    Text("Forgot password?")
                        .font(Constants.mediumFont)
                        .opacity(!forgotPassword ? 0 : 1)
                        .disabled(forgotPassword ? false : true)
                }
                .padding(10)
                
                Button {
                    Auth.auth().createUser(withEmail: user.email, password: user.password){user, error in
                        if let u = user{
                            print("successfully signed up!")
                            self.user.loggedIn = true
                        } else if let e = error{
                            print(e.localizedDescription)
                        }
                    }
                } label: {
                    Text("Sign up")
                        .font(Constants.mediumFont)
                        .foregroundColor(Color.textColor)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 10)
                        .background(Color.valeaseTeal)
                        .cornerRadius(20)
                }
                .padding()
                
                Button {
                    Auth.auth().signIn(withEmail: user.email, password: user.password){user, error in
                        if let u = user{
                            print("successfully logged in!")
                            self.user.loggedIn = true
                        } else if let e = error{
                            self.forgotPassword = true
                            print(e.localizedDescription)
                        }
                    }
                    
                } label: {
                    Text("Log in")
                        .font(Constants.mediumFont)
                        .foregroundColor(Color.textColor)
                        .padding(.horizontal, 114)
                        .padding(.vertical, 10)
                        .background(Color.valeaseTeal)
                        .cornerRadius(20)
                }
                
                
                Spacer()
                
                
                
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(User())
    }
}
