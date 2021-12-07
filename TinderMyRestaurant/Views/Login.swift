import SwiftUI
import Firebase

struct Login: View {
    @ObservedObject var session: SessionStore
    @State var email = ""
    @State var password = ""
    @State var loading = false
    @State var error = false
    
    var body: some View {
        if(loading){
            ActivityIndicator().foregroundColor(.green)
        } else {
            VStack {
                TextField("Email", text: $email).autocapitalization(.none)
                SecureField("Password", text: $password)
                Button(action: { login() }) {
                    Text("Sign in")
                }
            }
            .padding()
        }
        
    }
    
    func login() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.error = true
            } else {
                self.email = ""
                self.password = ""
                print("success")
            }
        }
    }
}
