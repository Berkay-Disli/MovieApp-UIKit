//
//  Extensions.swift
//  MovieApp-UIKit
//
//  Created by Berkay Disli on 17.03.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
