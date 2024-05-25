//
//  ContentView.swift
//  FBNails
//
//  Created by Daniele Sebastio on 25/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            } else {
                VStack {
                    Spacer()
                    
                    Text("FB")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Text("nails")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(.bottom, 40)
                    
                    Spacer()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding(.bottom, 5)
                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal, 20)
                                .textContentType(.password)
                                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.isPasswordVisible.toggle()
                                        }) {
                                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 20)
                                        }
                                        .padding(.trailing, 15) // Aggiungi un padding alla destra dell'icona dell'occhio
                                    }
                                , alignment: .trailing // Allinea l'overlay alla destra
                                )
                        } else {
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal, 20)
                                .textContentType(.password)
                                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.isPasswordVisible.toggle()
                                        }) {
                                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(.black)
                                                .padding(.trailing, 20)
                                        }
                                        .padding(.trailing, 15) // Aggiungi un padding alla destra dell'icona dell'occhio
                                    }
                                , alignment: .trailing // Allinea l'overlay alla destra
                                )
                        }

                    }
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        // Action when login button is tapped
                    }) {
                        Text("Login")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .background(.primaryPink)
                .edgesIgnoringSafeArea(.all)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
}

struct OutlinedTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var nextField: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .foregroundColor(.gray)
                .font(isFocused ? .caption : .subheadline)
                .offset(y: isFocused ? -20 : 0)
                .scaleEffect(isFocused ? 0.8 : 1)
                .animation(.easeInOut(duration: 0.2))
            
            TextField("", text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .focused($isFocused)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .submitLabel(.next)
                .onSubmit {
                    isFocused = false
                    isFocused = true
                    nextField = text
                    
                }
        }
        .padding(.vertical, 5)
    }
}

struct OutlinedSecureField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var nextField: String?
    @FocusState var isFocused: Bool
    @State private var isSecured = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .foregroundColor(.gray)
                .font(isFocused ? .caption : .subheadline)
                .offset(y: isFocused ? -20 : 0)
                .scaleEffect(isFocused ? 0.8 : 1)
                .animation(.easeInOut(duration: 0.2))
            
            ZStack(alignment: .trailing) {
                if isSecured {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .focused($isFocused)
            .textContentType(.password)
            .keyboardType(.default)
            .submitLabel(.done)
            .onSubmit {
                isFocused = false
                nextField = text
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
}
