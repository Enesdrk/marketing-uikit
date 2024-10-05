//
//  Extensions.swift
//  project-akakce
//
//  Created by Enes on 3.10.2024.
//
extension String {
    func capitalizedFirstLetter() -> String {
        return self.lowercased().split(separator: " ").map { $0.capitalized }.joined(separator: " ")
    }
}
