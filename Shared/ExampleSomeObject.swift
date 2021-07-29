//
//  ExampleSomeObject.swift
//  HelloCombine
//
//  Created by Wataru Suzuki on 2021/07/28.
//

import Foundation
import Combine
import SwiftUI

public extension URLSession.DataTaskPublisher {
    typealias SomeCustomOutput = (data: Data, response: URLResponse, isCompleted: Bool)

    func someCustomOperation() -> Publishers.TryMap<Self, SomeCustomOutput> {
        tryMap { output in
            return (output.data, output.response, true)
        }
    }
}
