//
//  ViewModel.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import RxSwift

protocol ViewModel: AnyObject {
    associatedtype InputType
    associatedtype OutputType
    associatedtype ModelType
    
    var model: ModelType { get set }
    var input: InputType? { get set }
    var output: OutputType? { get set }
    var disposeBag: DisposeBag { get set }
    var deinitPrinter: DeinitPrinter { get set }
    
    init(input: InputType)
}
