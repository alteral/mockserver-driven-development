//
//  ContentView.swift
//  TestMockServer
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var usernameIdentifier: String = ""
    @State private var userCurrentStatus: String = "person.crop.circle.fill.badge.questionmark"
    @State private var userLoggedIn: String = "person.crop.circle.badge.checkmark.fill"
    
    var body: some View {
        Image(systemName: "gamecontroller.fill")
            .resizable()
            .frame(width: 120, height: 80, alignment: .center)
            .accessibility(identifier: "gamecontroller")
            .onTapGesture(perform: onTap)
        
        Label {
            Text(text)
                .font(.system(size: 36, weight: .bold, design: .monospaced))
        } icon: {
            Image(systemName: userCurrentStatus)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
        }
        .frame(width: 400, height: 200)
        .accessibility(identifier: usernameIdentifier)
    }
    
    func onTap() {
        let usersEndpoint = "/api/v2/users"
        let task = URLSession.shared.dataTask(with:  apiUrl(usersEndpoint)) {(data, response, error) in
            let json = String(data: data!, encoding: .utf8)!.json
            text = json["first_name"] as! String
            userCurrentStatus = userLoggedIn
            usernameIdentifier = "username"
            print("\nGAME STARTED 🏈\n\(json.toString(prettyPrinted: true))")
        }
        task.resume()
    }
    
    func apiUrl(_ endpoint: String) -> URL {
        var urlString = "https://random-data-api.com"
        #if DEBUG
          if ProcessInfo.processInfo.arguments.contains("MOCK_SERVER") {
              urlString = "http://localhost:4567"
          }
        #endif
        let url = URL(string: urlString + endpoint)!
        return url
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


