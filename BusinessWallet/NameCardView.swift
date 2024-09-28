//
//  NameCardView.swift
//  BusinessWallet
//
//  Created by elice76 on 9/28/24.
//

import SwiftUI

struct NameCardView: View {
    @State var user: GithubUser?
    @State var name: String
    
    var body: some View {
        
       
        VStack {
            
            //프로필 이미지
            AsyncImage(url: URL(string: user?.avaterUrl ?? "")) {
                image in
                    image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                 } placeholder:{
                Circle()
                    .foregroundStyle(.secondary)
                    .frame(width: 150)
            }
           
            // 이름
            Text(user?.name ?? "")
                .font(.title)
                .bold()
            //회사
            Text(user?.name ?? "회사없음")
            NavigationLink{
                DetailView(username: name);
                
            }label: {
                Text("View More")
                    .padding(.horizontal,70)
                    .padding(.vertical,10)
                    .background{
                        Capsule()
                            .foregroundStyle(.cyan)
                        
                    }
                    .foregroundStyle(.white)
            }
            .padding(.bottom,50)
            
            HStack{
                Text(user?.htmlUrl ?? "없음")
                Spacer()
            }
            Divider()
            
            HStack{
                Text(user?.email ?? "없음" )
                Spacer()
            }
            
           
         
            
        }
        .padding(.horizontal,30)
        .task {
            //task : 비동기 함수를 실행시킴
            self.user = try? await getUserData(name: name)
          
        }
    }
    
    func getUserData(name: String) async throws -> GithubUser {
        
        guard let url = URL(string: "https://api.github.com/users/\(name)")else{
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
        decoder.keyDecodingStrategy =
            .convertFromSnakeCase
        
        return try decoder.decode(GithubUser.self, from: data)
    }
}

#Preview {
    
  
    
   
}

struct FamilyRow: View {
  var name: String
  
  var body: some View {
    Text("사용자: \(name)")
  }
}


struct GithubUser: Codable {
    let avaterUrl:String?
    let name:String?
    let company:String?
    let htmlUrl:String
    let email:String?
    
    
}
