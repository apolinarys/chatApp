//
//  MessageCellModel.swift
//  MessageApp
//
//  Created by Macbook on 27.09.2022.
//

import Foundation

protocol MessageCellConfiguration {
    var text: String? {get set}
    var messageFromMe: Bool {get set}
}

struct MessageCell: MessageCellConfiguration {
    var text: String?
    var messageFromMe: Bool
}

struct MessageCellModel {
    func createCells() -> [MessageCell] {
        let cells = [
            MessageCell(text: "Text1 from sender", messageFromMe: false),
            MessageCell(text: "Text1 from receiver", messageFromMe: true)
        ]
        return cells
    }
}
