//
//  SubcriberViewModel.swift
//  SubcriberBootcamp
//
//  Created by Weerawut Chaiyasomboon on 14/03/2568.
//

import Foundation
import Combine

class SubcriberViewModel: ObservableObject {
    @Published var count = 0
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false

    var cancellable: Set<AnyCancellable> = []
    
    init() {
        setupTimer()
        addTextFieldSubcriber()
        addButtonSubcriber()
    }
    
    func setupTimer() {
        Timer.publish(every: 1, on: RunLoop.main, in: .common).autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
            }
            .store(in: &cancellable)
    }
    
    func addTextFieldSubcriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text in
                if text.count > 3 {
                    return true
                } else {
                    return false
                }
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { isValid in
                self.textIsValid = isValid
            })
            .store(in: &cancellable)
    }
    
    func addButtonSubcriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                if isValid && count > 10 {
                    self?.showButton = true
                } else {
                    self?.showButton = false
                }
            }
            .store(in: &cancellable)
    }
}
