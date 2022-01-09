//
//  Observable.swift
//  2021LastProject
//
//  Created by Yundong Lee on 2021/12/31.
//

import Foundation

class Observalble<T> {
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet{
            listner?(value)
        }
    }
    
    private var listner: ( (T)-> Void )?
    
    func bind(_ closure: @escaping (T) -> Void ) {
        closure(value)
        listner = closure
    }
    
}
