//
//  ContentView.swift
//  Spinners
//
//  Created by Omar on 29/04/2022.
//

import SwiftUI

struct ContentView : View {
    
    @State var step = 0
    
    var body : some View {
        ListSpinner(
            loadingStrings: ["جاري تحميل معلومات المستخدم..","جاري معالجة البيانات","جاري اعداد الصفحة الرئيسية"],
            step: $step, direction: .trailing)
            .task {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                    step += 1
                }
            }
    }
}

struct ListSpinner: View {
    
    var loadingStrings:[String]
    @Binding var step:Int
    var direction:HorizontalAlignment = .leading
    
    @State private var texts:[String] = []
    
    var body: some View {
        VStack(alignment: direction){
            ForEach(Array(texts.enumerated()), id:\.offset){ i,t in
                HStack{
                    
                    if direction == .leading {
                        Text(t).opacity(step == i ? 1 : 0.5)
                    }
                    
                    if step == i {
                        RingView(duration: 0.75, color:.black, size:8).padding(.horizontal,4)
                    }else{
                        Image(systemName: "checkmark").foregroundColor(.blue)
                    }
                    
                    if direction == .trailing {
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

struct StackedLoading : View {
    var body : some View {
        VStack{
            Text("Previous step").opacity(0.1)
            HStack{
                Text("Currently doing")
                RingView(color:.black, size:8).padding(4)
            }
            Text("Might do next").opacity(0.1)
        }
    }
}

struct RingView: View {
    
    var duration:Double = 1
    var color:Color = .red
    var size:Double = 16
    @State var cutpoint = 0.0
    
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

struct Ring: Shape {
    
    var cutpoint: Double
    
    var animatableData: Double {
        get { return cutpoint }
        set { cutpoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var start:Double = 0
        var end:Double = 360 * cutpoint
        
        if cutpoint > 0.5 {
            start = (2 * cutpoint) * 360
        }
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width/2, y: rect.height/2), radius: rect.width/2, startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        return path
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
            RingView()
        }
    }
}
