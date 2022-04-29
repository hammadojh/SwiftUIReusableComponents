//
//  RingSpinner.swift
//  Spinners
//
//  Created by Omar on 29/04/2022.
//

import SwiftUI


/// Just another progress view / loading indicator / .. etc
struct RingSpinner: View {
    
    /// The speed of the spinner (in seconds). default is 1
    var duration:Double = 1
    
    /// The color of the spinner. default is Color.red
    var color:Color = .red
    
    /// the size of the spinner in pixels. default is 16.
    var size:Double = 16
    
    
    @State private var cutpoint = 0.0
    
    var body: some View {
        VStack{
            Ring(cutpoint: cutpoint)
                .stroke(color, lineWidth: size)
                .frame(width: size, height: size)
                .onAppear {
                    withAnimation(.easeOut(duration: duration).repeatForever(autoreverses:false)) {
                        cutpoint = 1.0
                    }
                }
        }
        
    }
}

private struct Ring: Shape {
    
    var cutpoint: Double
    
    var animatableData: Double {
        get { return cutpoint }
        set { cutpoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var start:Double = 0
        let end:Double = 360 * cutpoint
        
        if cutpoint > 0.5 {
            start = (2 * cutpoint) * 360
        }
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width/2, y: rect.height/2), radius: rect.width/2, startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        return path
    }
    
    
}

struct RingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        RingSpinner()
    }
}
