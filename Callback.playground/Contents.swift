import UIKit

class Firebase {
    
    func createUser(username: String, password: String, completion: (Bool, Int)->()) {
 
        var isSuccess = true
        var userID = 123444
        
        completion(isSuccess, userID)
        
    }
    
}

class MyApp {
    
    func registerButtonPressed() {
        
        let firebase = Firebase()
        
        firebase.createUser(username: "Konstantin", password: "123", completion: completed)
    
        firebase.createUser(username: "Konstantin", password: "123") {print("\($0) \($1)")}
        
    }
    
    func completed(isSuccess: Bool, userID: Int) {
        print("func completed")
    }
    
}

let app = MyApp()

app.registerButtonPressed()
