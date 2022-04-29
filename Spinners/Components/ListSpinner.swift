//
//  ListSpinner.swift
//  Spinners
//
//  Created by Omar on 29/04/2022.
//

import SwiftUI

/// A Loading component that shows the users the steps of the loading
///
struct ListSpinner: View {
    
    /// A list of the strings for each step
    var loadingStrings:[String]
    
    /// A binding variable that allows you to navigate through steps
    /// In the view that will use this create a state variable starting from zero then increment that for each step
    @Binding var step:Int
    
    /// the direction of the list
    /// the default is leading but you can also make it trainling
    var direction:HorizontalAlignment = .leading
    
    @State private var texts:[String] = []
    
    var body: some View {
        VStack(alignment: direction){
            ForEach(Array(texts.enumerated()), id:\.offset){ i,t in
                HStack{
                    
                    if direction == .trailing || direction == .center {
                        Text(t).opacity(step == i ? 1 : 0.5)
                    }
                    
                    if step == i {
                        RingSpinner(duration: 0.75, color:.black, size:8).padding(.horizontal,4)
                    }else{
                        Image(systemName: "checkmark").foregroundColor(.blue)
                    }
                    
                    if direction == .leading {
                        Text(t).opacity(step == i ? 1 : 0.5)
                    }
                    
                }
                .padding(4)
            }
        }
        .onAppear{
            texts.append(loadingStrings[step])
        }
        .onChange(of: step) { newValue in
            if step < loadingStrings.count{
                withAnimation {
                    texts.append(loadingStrings[step])
                }
            }
        }
    }
}
