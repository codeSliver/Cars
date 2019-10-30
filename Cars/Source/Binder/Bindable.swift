//
//  Binder.swift
//  Cars
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

class Bindable<T>{
    typealias Listener = (T)->()
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ val: T) {
        value = val
    }
    
    func bind(_ listener: Listener?){
        self.listener = listener
    }
    
    
}
