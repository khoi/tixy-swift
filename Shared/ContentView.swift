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


typealias TransformFunc = (_ t: Double, _ i: Int, _ x: Int, _ y: Int) -> CGFloat

func color(v: CGFloat) -> Color {
    v < 0 ? .red : .white
}

func scale(v: CGFloat) -> CGFloat {
    max(min(v, 1), -1)
}

struct ContentView: View {
    let size: Int
    
    let transform: TransformFunc
    
    var body: some View {
        VStack {
            ForEach(0..<size, id: \.self) { y in
                HStack {
                    ForEach(0..<size, id: \.self) { x in
                        let v = transform(0, y * size + x, x, y)
                        Circle()
                            .fill()
                            .foregroundColor(color(v: v))
                            .scaleEffect(scale(v: v))
                    }
                }
            }
        }
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            size: 16,
            transform: { (_, _, _, y) in
                CGFloat(y) - 7.5
            }
        
        )
        .previewLayout(.fixed(width: 320, height: 320))
    }
}
