//
//  TaskItem.swift
//  Lesson12HW
//

//

import Foundation

enum TaskItemType: Int {
    case showLsit
    case playlistDeleteItem
    case playlistMoveDeleteItem
    case playlistByGenre
    case playlistWithModes
}

struct TaskItem {
    
    let title: String
    let type: TaskItemType
}
