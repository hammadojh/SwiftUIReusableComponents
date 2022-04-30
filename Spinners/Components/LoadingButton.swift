//
//  Component.swift
//  Spinners
//
//  Created by Omar on 30/04/2022.
//

import SwiftUI
import Combine

struct LoadingButton: View {
    
    var text:String
    var loadingText:String
    var tintColor:Color
    var backgroundColor:Color
    var action:()->()
    
    @State private var from: CGFloat = 0.0
    @State private var to: CGFloat = 0.0
    @State var timer:Publishers.Autoconnect<Timer.TimerPublisher>
    let increment = 0.01
    let speed = 1.5
    @State var loading = false
    @State var buttonDisplayedText:String
    @State var buttonDisabled = false
    
    init(text:String, loadingText:String = "Loading..", tintColor:Color = .blue, backgroundColor:Color = Color(red: 0.9, green: 0.9, blue: 0.9), action:@escaping ()->()){
        self.text = text
        self.loadingText = loadingText
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.action = action
        timer = Timer.publish(every: increment, on: .main, in: .common).autoconnect()
        buttonDisplayedText = self.text
    }
    
    var body: some View {
        Button {
            
            //animation
            loading.toggle()
            from = 0
            to = 0
            
            if loading {
                buttonDisplayedText = loadingText
                buttonDisabled = true
            }else{
                buttonDisplayedText = text
            }
            
            // run action
            action()
            
        } label: {
            Text(buttonDisplayedText)
                .foregroundColor(buttonDisabled ? .gray : tintColor)
                .frame(maxWidth:.infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: from, to: to)
                        .stroke(tintColor, lineWidth: 2)
                        .padding(.horizontal,2)
                )
                
        }
        .disabled(buttonDisabled)
        .padding()
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: increment)) {
                if loading {
                    if to < 1 {
                        to += increment*speed
                    }else{
                        from += increment*speed
                    }
                }
            }
            
            if from >= 1 && to >= 1 {
                from = 0
                to = 0
            }
            
        }

    }
}

struct Component_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(text: "Click Me") {
            //
        }
    }
}
