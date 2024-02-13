//
//  FireBase.swift
//  m3hw
//
//  Created by Salman Abdullayev on 06.02.24.
//

import Foundation
import Firebase
import FirebaseAuth


class FireBase {
    
    func createNewUser(email: String, pass: String, complition: @escaping (Bool)-> ()) {
        Auth.auth().createUser(withEmail: email, password: pass) {res,err in
            if err != nil {
                print(err?.localizedDescription ?? "")
                let locError = err as? NSError
                print(locError?.code ?? "")
                complition(false)
                return
            }
            res?.user.sendEmailVerification()
            complition(true)
        }
    }
    
    func checkAuth () -> Bool {
        guard let _ = Auth.auth().currentUser else {
            return false
        }
        return true
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] res, err in
            
            if err != nil {
                print(err!.localizedDescription)
                
                let locError = err as? NSError
                print(locError?.code ?? "")
                completion(false)
                return
            }
            
            if let verify = res?.user.isEmailVerified {
                self?.checkAuth()
                completion(true)
            } else {
               print("not verify")
            }
            
        }
    }
    
    func signInOut(){
        try? Auth.auth().signOut()
    }
    
}

