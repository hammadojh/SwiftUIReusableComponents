//
//  AchivedEffect.swift
//  Spinners
//
//  Created by Omar on 01/05/2022.
//

import SwiftUI

struct AchivedEffect: View {
    
    var speed:Double
    var numCircles:Int
    var maxSize:CGFloat
    var minSize:CGFloat
    
    var colors:[Color]
    
    @State var xs:[CGFloat]
    @State var ys:[CGFloat]
    @State var ss:[CGFloat]
    @State var os:[CGFloat]
    @State var cs:[Color]
    @State var rs:[CGFloat]
    
    init(speed:Double, numCircles:Int, maxSize:CGFloat, minSize:CGFloat, color:[Color] = [.red,.blue,.green,.orange,.yellow]){
                
        self.speed = speed
        self.numCircles = numCircles
        self.maxSize = maxSize
        self.minSize = minSize
        self.colors = color
        
        // initialize arrays to middle
        xs = (0..<numCircles).map( { _ in 0 } )
        ys = (0..<numCircles).map( { _ in 0 } )
        ss = (0..<numCircles).map( { _ in 0 } )
        os = (0..<numCircles).map( { _ in 1 } )
        cs = (0..<numCircles).map( { _ in .white } )
        rs = (0..<numCircles).map( { _ in 0 } )
        cs = (0..<numCircles).map( { _ in colors[Int.random(in: 0..<colors.count)] } )
    }
    
    var body: some View {
        ZStack{
            ForEach(0..<numCircles){ i in
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: ss[i], height: ss[i])
                    .opacity(os[i])
                    .foregroundColor(cs[i])
                    .offset(x: xs[i], y: ys[i])
                    .rotationEffect(.degrees(rs[i]))
            }
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: speed)) {
                xs = (0..<numCircles).map( { _ in CGFloat.random(in: -1500...1500) } )
                ys = (0..<numCircles).map( { _ in CGFloat.random(in: -1500...1500) } )
                ss = (0..<numCircles).map( { _ in CGFloat.random(in: minSize...maxSize) } )
                cs = (0..<numCircles).map( { _ in colors[Int.random(in: 0..<colors.count)] } )
                rs = (0..<numCircles).map( { _ in CGFloat.random(in: 0...360) } )
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + speed*0.75) {
                withAnimation {
                    os = (0..<numCircles).map( { _ in 0 } )
                }
            }
            
            
            //reset
            DispatchQueue.main.asyncAfter(deadline: .now() + speed*2.0) {
                xs = (0..<numCircles).map( { _ in 0 } )
                ys = (0..<numCircles).map( { _ in 0 } )
                ss = (0..<numCircles).map( { _ in 0 } )
                os = (0..<numCircles).map( { _ in 1 } )
                rs = (0..<numCircles).map( { _ in 0 } )
            }
            
        }
    }
}
