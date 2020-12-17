//
//  JavascriptRuntime.swift
//  tixy
//
//  Created by khoi on 12/17/20.
//

import Foundation
import JavaScriptCore

final class JavaScriptRuntime {
    let context: JSContext!
    
    var transform: ((_ t: Double, _ i: Double, _ x: Double, _ y: Double) -> Double)
    
    init() {
        self.context = JSContext()
        context.exceptionHandler = { context, exception in
            fatalError(exception!.toString())
        }
        transform = { _, _, _ ,_ in
            0
        }
    }
    
    func jsFunctionString(s: String) -> String {
        """
        var transform = new Function('t', 'i', 'x', 'y', `
            try {
                return \(s);
            } catch(err) {
                return 0;
            }
        `)
        """
    }
    
    func updateScript(_ s: String) {
        context.evaluateScript(jsFunctionString(s: s))
        let transformFunc = context.objectForKeyedSubscript("transform")
        self.transform = { (t, i, x, y) in
           return transformFunc?.call(withArguments: [t,i,x,y])?.toDouble() ?? 0
        }
    }
}
