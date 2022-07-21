//
//  Extension + RxSwift.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    var isFirstResponder: Observable<Bool> {
        return Observable
            .merge(
                methodInvoked(#selector(UIView.becomeFirstResponder)),
                methodInvoked(#selector(UIView.resignFirstResponder))
            )
            .map{ [weak view = self.base] _ in
                view?.isFirstResponder ?? false
            }
            .startWith(base.isFirstResponder)
            .distinctUntilChanged()
            .share(replay: 1)
    }
    
    // 개발중 아직 작동 안 합니다.
    var observeIsHidden: Observable<Bool> {
        return Observable
            .just(methodInvoked(#selector(setter: UIView.isHidden)))
            .map{ [weak view = self.base] _ in
                view?.isHidden ?? true
            }
            .startWith(base.isHidden)
            .distinctUntilChanged()
            .share()
    }
}

extension ObservableType {
    func asDriverOnErrorEmpty() -> Driver<Element> {
        return asDriver { (error) in
            return .empty()
        }
    }
}

extension Reactive where Base: UIDevice {
    
    public var orientation: Observable<UIDeviceOrientation> {
        return NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification).map { _ in
            UIDevice.current.orientation
        }.distinctUntilChanged()
    }
    
    public var isPortrait: Observable<Bool> {
        return orientation.map {
            $0.isPortrait
        }.distinctUntilChanged()
    }
    
    public var isLandscape: Observable<Bool> {
        return orientation.map {
            $0.isLandscape
        }.distinctUntilChanged()
    }
    
    public var isFlat: Observable<Bool> {
        return orientation.map {
            $0.isFlat
        }.distinctUntilChanged()
    }
    
    public var isValidInterfaceOrientation: Observable<Bool> {
        return orientation.map {
            $0.isValidInterfaceOrientation
        }.distinctUntilChanged()
    }
}
