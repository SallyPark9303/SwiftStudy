//
//  ContentView.swift
//  BusinessWallet
//
//  Created by elice76 on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("규니"){
                    NameCardView(name: "seunggyun-jeong")
                }
                NavigationLink("미숫가루"){
                    NameCardView(name: "misutgaru")
                }
                NavigationLink("미라"){
                    NameCardView(name: "miramazing")
                }
               }
        }
    }
}



#Preview {
    
   
}
