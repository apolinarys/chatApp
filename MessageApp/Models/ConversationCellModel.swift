//
//  ConversationCellModel.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import Foundation

protocol ConversationCellConfiguration {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

struct ConversationCell: ConversationCellConfiguration {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
}

struct ConversationCellModel {
    
    func createCells() -> [ConversationCell]{
        let cells: [ConversationCell] = [
            //Online
            ConversationCell(name: "Name1", message: "Message1", date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: true),
            ConversationCell(name: "Name2", message: nil, date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: true),
            ConversationCell(name: "Name3", message: "Message3", date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: false),
            ConversationCell(name: "Name4", message: nil, date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: false),
            ConversationCell(name: "Name5", message: "Message5", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            ConversationCell(name: "Name6", message: nil, date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            ConversationCell(name: "Name7", message: "Message7", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: false),
            ConversationCell(name: "Name8", message: nil, date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: false),
            ConversationCell(name: "Name9", message: "Message9", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            ConversationCell(name: "Name10", message: "Message10", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            
            //History
            ConversationCell(name: "Name11", message: "Message11", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: true),
            ConversationCell(name: "Name12", message: "Message12", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: true),
            ConversationCell(name: "Name13", message: "Message13", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: false),
            ConversationCell(name: "Name14", message: "Message14", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: false),
            ConversationCell(name: "Name15", message: "Message15", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            ConversationCell(name: "Name16", message: "Message15", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            ConversationCell(name: "Name17", message: "Message17", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: false),
            ConversationCell(name: "Name18", message: "Message18", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: false),
            ConversationCell(name: "Name19", message: "Message19", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            ConversationCell(name: "Name20", message: "Message20", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
        ]
        return cells
    }
    
    private func getDate(string: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let string = string {
            let date = dateFormatter.date(from: string)!
            return date
        }
        return nil
    }
    
}
