//
//  MessageCellModel.swift
//  MessageApp
//
//  Created by Macbook on 27.09.2022.
//

import Foundation

protocol MessageCellConfiguration {
    var text: String? {get set}
    var isIncoming: Bool {get set}
}

struct MessageCell: MessageCellConfiguration {
    var text: String?
    var isIncoming: Bool
}

struct MessageCellModel {
    func createCells() -> [MessageCell] {
        let cells = [
            MessageCell(text: "Text1 from sender", isIncoming: false),
            MessageCell(text: "Text1 from receiver", isIncoming: true)
        ]
        return cells
    }
}
