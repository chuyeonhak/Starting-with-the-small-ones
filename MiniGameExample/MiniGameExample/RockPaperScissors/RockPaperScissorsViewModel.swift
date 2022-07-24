//
//  RockPaperScissorsViewModel.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import RxSwift
import RxCocoa

class RockPaperScissorsViewModel: ViewModel {
    var model = Model()
    var input: Input?
    var output: Output?
    var disposeBag = DisposeBag()
    
    var deinitPrinter = DeinitPrinter()
    
    struct Model {
        
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    required init(input: Input) {
        
    }
}
