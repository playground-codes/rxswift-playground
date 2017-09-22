import RxSwift

//example() {
//  let firstName = "Quang"
//  let lastName = "Nguyen"
//  
//
//  
//
//}

let disposeBag = DisposeBag()
Observable.of("🐶", "🐱", "🐭", "🐹")
  .startWith("1️⃣")
  .startWith("2️⃣")
  .startWith("3️⃣", "🅰️", "🅱️")
  .subscribe(onNext: { print($0) })
  .disposed(by: disposeBag)