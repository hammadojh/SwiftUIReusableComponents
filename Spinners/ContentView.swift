//
//  ContentView.swift
//  Spinners
//
//  Created by Omar on 29/04/2022.
//

import SwiftUI

/// An example of using the list spinner
struct ContentView : View {
    
    @State var step = 0
    
    var body : some View {
        ListSpinner(
            loadingStrings: ["Loading user information","Processing Data", "Preparing your feed"],
            step: $step, direction: .leading)
            .task {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                    step += 1
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
        }
    }
}
