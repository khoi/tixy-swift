//
//  ContentView.swift
//  Shared
//
//  Created by khoi on 12/17/20.
//

import SwiftUI

// 16 * 16
// f(t, i, x, y) -> Double
// color: value < 0 ? red : white
// size: -1...1


typealias TransformFunc = (_ t: Double, _ i: Double, _ x: Double, _ y: Double) -> Double

func color(v: Double) -> Color {
    v < 0 ? .red : .white
}

func scale(v: Double) -> CGFloat {
    CGFloat(max(min(v, 1), -1))
}

struct ContentView: View {
    let size: Int
    
    let jsRuntime = JavaScriptRuntime()
    
    @State var t: TimeInterval = 0
    let started = Date()
    
    private let timer = Timer.publish(every: 1 / 60.0, on: .main, in: .common).autoconnect()

    
    var body: some View {
        GeometryReader { reader in
            VStack {
                ForEach(0..<size, id: \.self) { y in
                    HStack {
                        ForEach(0..<size, id: \.self) { x in
                            let v = jsRuntime.transform(t, Double(y * size + x), Double(x), Double(y))
                            Circle()
                                .fill()
                                .foregroundColor(color(v: v))
                                .scaleEffect(scale(v: v))
                        }
                    }
                }
            }
            .frame(width: min(reader.size.width, reader.size.height), height: min(reader.size.width, reader.size.height))
        }
        .background(Color.black)
        .onReceive(timer, perform: { _ in
            t = Date().timeIntervalSince(started)
        })
        .onAppear(perform: {
            jsRuntime.updateScript("Math.sin(t-Math.sqrt((x-7.5)**2+(y-6)**2))")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            size: 16
        )
        .previewLayout(.fixed(width: 320, height: 320))
    }
}
