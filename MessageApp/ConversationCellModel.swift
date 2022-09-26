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

struct Cell: ConversationCellConfiguration {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
}

struct ConversationCellModel {
    
    func createCells() -> [Cell]{
        let cells: [Cell] = [
            //Online
            Cell(name: "Name1", message: "Message1", date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: true),
            Cell(name: "Name2", message: nil, date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: true),
            Cell(name: "Name3", message: "Message3", date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: false),
            Cell(name: "Name4", message: nil, date: getDate(string: "2022-02-12T12:33:05Z"), online: true, hasUnreadMessages: false),
            Cell(name: "Name5", message: "Message5", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            Cell(name: "Name6", message: nil, date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            Cell(name: "Name7", message: "Message7", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: false),
            Cell(name: "Name8", message: nil, date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: false),
            Cell(name: "Name9", message: "Message9", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            Cell(name: "Name10", message: "Message10", date: getDate(string: "2022-09-26T12:33:05Z"), online: true, hasUnreadMessages: true),
            
            //History
            Cell(name: "Name11", message: "Message11", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: true),
            Cell(name: "Name12", message: "Message12", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: true),
            Cell(name: "Name13", message: "Message13", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: false),
            Cell(name: "Name14", message: "Message14", date: getDate(string: "2022-02-12T12:33:05Z"), online: false, hasUnreadMessages: false),
            Cell(name: "Name15", message: "Message15", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            Cell(name: "Name16", message: "Message15", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            Cell(name: "Name17", message: "Message17", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: false),
            Cell(name: "Name18", message: "Message18", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: false),
            Cell(name: "Name19", message: "Message19", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
            Cell(name: "Name20", message: "Message20", date: getDate(string: "2022-09-26T12:33:05Z"), online: false, hasUnreadMessages: true),
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
