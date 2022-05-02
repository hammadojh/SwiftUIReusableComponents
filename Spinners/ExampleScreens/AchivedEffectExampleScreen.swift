//
//  AchivedEffectExampleScreen.swift
//  Spinners
//
//  Created by Omar on 01/05/2022.
//

import SwiftUI

struct AchivedEffectExampleScreen: View {
    
    @State var speed:Double = 1
    @State var numCircles = 1000
    @State var maxSize:CGFloat  = 44
    @State var minSize:CGFloat = 5
    @State var colors:[Color] = [.red,.blue,.green,.orange,.yellow]
    
    @State var showEffect: Bool = false
    @State var buttonLabel:String = "مفاجأة"
    
    var body: some View {
       
        ZStack(alignment:.top){
            
            if showEffect {
                
                AchivedEffect(speed:speed,
                              numCircles:numCircles,
                              maxSize:maxSize,
                              minSize: minSize)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .drawingGroup()
                    .ignoresSafeArea(.all)
            }
            
            
            
            VStack{
                
                Spacer()
                
                Text("عيدكم مباااااارك").bold().font(.system(size: 64)).multilineTextAlignment(.center)
                Button {
                    showEffect.toggle()
                    buttonLabel = "..."
                    
                    //reset
                    DispatchQueue.main.asyncAfter(deadline: .now() + speed*2.0) {
                        showEffect.toggle()
                        buttonLabel = "مرة ثانية"
                    }
                    
                } label: {
                    Text(buttonLabel)
                }
                
                Spacer()
                
                VStack{
                    
                    

                    
                    HStack{
                        Text("# Shapes")
                        TextField("", value: $numCircles, formatter: NumberFormatter())
                    }
                    
                    HStack{
                        Text("Delay")
                        Slider(value: $speed, in: 0.1...2)
                    }
                    
                    HStack{
                        Text("Min Size")
                        Slider(value: $minSize, in: 1...100)
                    }
                    
                    HStack{
                        Text("Max Size")
                        Slider(value: $maxSize, in: 1...100)
                    }
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .padding(.bottom,52)
            
            
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
    }
}

struct AchivedEffectExampleScreen_Previews: PreviewProvider {
    static var previews: some View {
        AchivedEffectExampleScreen()
    }
}
