//
//  ContentView.swift
//  Spinners
//
//  Created by Omar on 29/04/2022.
//

import SwiftUI

/// An example of using the list spinner
struct ContentView : View {
    
    var body : some View {
        NavigationView{
            List{
                //spinner list
                NavigationLink("Spinner List") {
                    SpinnerListArabicScreen()
                }
                //ring spinner
                NavigationLink("Ring Spinner") {
                    RingSpinner()
                }
                //loading button
                NavigationLink("Loading Button"){
                    LoadingButtonExampleScreen()
                }
                //achived effect
                NavigationLink("Achived Effect"){
                    AchivedEffectExampleScreen()
                }
            }
            .navigationTitle("UI Componenets")
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
