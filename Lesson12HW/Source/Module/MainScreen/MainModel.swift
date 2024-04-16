//
//  MainModel.swift
//  Lesson12HW
//

//

import Foundation

protocol MainModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class MainModel {
    
    weak var delegate: MainModelDelegate?
    
    var items: [TaskItem] = []
    
    func loadData() {
        
        self.items = [
            TaskItem(
                title: "Завдання 1:\nПоказати список з повною інформацією про музику однією секцією",
                type: .showLsit
            ),
            TaskItem(
                title: "Завдання 2:\nПоказати список з можливістю видалення (Swipe to delete) елементу зі списку однією секцією", 
                type: .playlistDeleteItem
            ),
            TaskItem(
                title: "Завдання 3:\nПоказати список з можливістю увімкнення/вимкнення редагування таблиці (Delete і Move) однією секцією",
                type: .playlistMoveDeleteItem
            ),
            TaskItem(
                title: "Завдання 4:\nПоказати список, розбитий по секціям Genre, де Section Header title - це назва жанру",
                type: .playlistByGenre
            ),
            TaskItem(
                title: "Завдання 5:\nПоказати екран з Segment Control над таблицею, який перемикає режим перегляду списку і показує All/Genre/Author, де\nAll - режим перегляду всіх даних однією секцією\nGenre - режим перегляду всіх даних сгрупованих за жанром\nAuthor - режим перегляду всіх даних сгрупованих за автором",
                type: .playlistWithModes
            )
        ]
        
        delegate?.dataDidLoad()
    }
}
