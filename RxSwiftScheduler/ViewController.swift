import RxSwift
import UIKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just("Hello, RxSwift")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
        
        Observable.from([1, 2, 3, 4, 5])
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { $0 * 2 }
            .subscribe(onNext: { value in
                print("Background processing:", value)
            })
            .disposed(by: disposeBag)
        
        Observable.of("Task 1", "Task 2", "Task 3")
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { task in
                print("Executing:", task)
            })
            .disposed(by: disposeBag)
        
        let operationQueue = OperationQueue()
        
        Observable.of("Operation 1", "Operation 2", "Operation 3")
            .observe(on: OperationQueueScheduler(operationQueue: operationQueue))
            .subscribe(onNext: { operation in
                print("Executing on OperationQueue:", operation)
            })
            .disposed(by: disposeBag)
    }

    

}

