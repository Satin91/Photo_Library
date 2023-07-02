//
//  SubscriberError.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import Combine

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
