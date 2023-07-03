//
//  URLQueryParams.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(
                format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            )
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension String {
    func appendingQueryParameters(_ parametersDictionary: [String: String]) -> String {
        let URLString = String(format: "%@?%@", self, parametersDictionary.queryParameters)
        return URLString
    }
}
