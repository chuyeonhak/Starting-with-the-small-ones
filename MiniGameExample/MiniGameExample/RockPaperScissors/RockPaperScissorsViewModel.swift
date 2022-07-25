//
//  RockPaperScissorsViewModel.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class RockPaperScissorsViewModel: ViewModel {
    enum GameState {
        case isPlaying
        case ready
    }
    var model = Model()
    var input: Input?
    var output: Output?
    var disposeBag = DisposeBag()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var deinitPrinter = DeinitPrinter()
    
    struct Model {
        let toastMessage = PublishSubject<String>()
        let gameState = BehaviorRelay<GameState>(value: .ready)
        let greatestWinningStreak = UserDefaults.standard.rx.observe(Int.self, UserDefaultKeys.greatestWinningStreak.rawValue)
        let currentWinningStreak = UserDefaults.standard.rx.observe(Int.self, UserDefaultKeys.currentWinningStreak.rawValue)
    }
    
    struct Input {
        let startButtonTapped: Observable<Void>
        let userTapped: Observable<(Int?, Int?)>
    }
    
    struct Output {
        let gameState: Driver<GameState>
        let greatestWinningStreak: Driver<Int>
        let currentWinningStreak: Driver<Int>
    }
    
    required init(input: Input) {
        input.startButtonTapped
            .filter{ [unowned self] in isPlaying(isStartButtonTap: true) }
            .bind { [weak self] in self?.model.gameState.accept(.isPlaying) }
            .disposed(by: disposeBag)
        
        input.userTapped
            .filter{ [unowned self] _ in !isPlaying() }
            .bind { [weak self] in self?.pickWinner(computer: $0.0, user: $0.1) }
            .disposed(by: disposeBag)
        
        output = Output(gameState: model.gameState.asDriverOnErrorEmpty(),
                        greatestWinningStreak: model.greatestWinningStreak.map { $0 ?? 0 }.asDriverOnErrorEmpty(),
                        currentWinningStreak: model.currentWinningStreak.map { $0 ?? 0 }.asDriverOnErrorEmpty())
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CareerRecord", in: persistentContainer.viewContext) else { return }
        let careerRecord = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        
        guard let losses = careerRecord.value(forKey: "losses") as? Int else { return }
        careerRecord.setValue(losses + 3, forKey: "losses")
        careerRecord.setValue(1, forKey: "draws")
        careerRecord.setValue(2, forKey: "wins")
        saveContext()
        
        print(careerRecord)
    }
    
    private func isPlaying(isStartButtonTap: Bool = false) -> Bool {
        switch model.gameState.value {
        case .isPlaying where isStartButtonTap: model.toastMessage.onNext("현재 게임중 입니다."); return false
        case .ready where !isStartButtonTap: model.toastMessage.onNext("startButton을 눌러주세요!"); return true
        default: return isStartButtonTap
        }
    }
    
    private func pickWinner(computer: Int?, user: Int?) {
        guard let computer = computer, let user = user else { return }
        model.gameState.accept(.ready)
        let computerNum = computer % 10,
            userNum = user % 10,
            currentWinningStreak = UserDefaultsManager.shared.currentWinningStreak
        
        switch (computerNum, userNum) {
        case (let com, let user) where com == user: print("draw")
        case (3, 5), (5, 7), (7, 3): print("user Win")
            UserDefaultsManager.shared.currentWinningStreak = currentWinningStreak + 1
            if UserDefaultsManager.shared.currentWinningStreak > UserDefaultsManager.shared.greatestWinningStreak {
                UserDefaultsManager.shared.greatestWinningStreak = UserDefaultsManager.shared.currentWinningStreak
            }
        case (5, 3), (7, 5), (3, 7) : print("computer Win"); UserDefaultsManager.shared.currentWinningStreak = 0
        default: break
        }
    }
}
