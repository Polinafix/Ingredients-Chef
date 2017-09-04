//
//  GCDBlackBox.swift
//  Ingredients Chef
//
//  Created by Polina Fiksson on 03/09/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//


import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
