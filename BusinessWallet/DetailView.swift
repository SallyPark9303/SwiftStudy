//
//  DetailView.swift
//  BusinessWallet
//
//  Created by elice76 on 9/28/24.
//

import SwiftUI
struct DetailView: View {
    
    @State var username :String
    @State var firstrepo: Repos?
    var body: some View {
        VStack {
            Text(firstrepo?.htmlUrl ?? "")
            Text("별개수\(firstrepo?.stargazersCount ?? 0)")
        } .task {
            //task : 비동기 함수를 실행시킴
            do {
                firstrepo = try await getUserDetail()
            } catch {
                print(error)
            }
            
          
        }
        
        
    }

    func getUserDetail() async throws -> Repos? {
        
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos")else{
            throw URLError(.badURL)
        }
        
        let(data, response)=try await
        URLSession.shared.data(from: url)
        guard
            let response = response as? HTTPURLResponse, response.statusCode==200
        else {
            throw URLError(.badServerResponse)
        }
        
        //data  까보기
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Repos].self, from: data).last
    }
}

struct Repos: Codable {
    let htmlUrl:String?
    let stargazersCount:Int
    
    
}

#Preview {
    DetailView(username: "seunggyun-jeong")
}
