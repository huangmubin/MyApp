//
//  HabitShowDiaryCard.swift
//  Days
//
//  Created by Myron on 2018/5/17.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class HabitShowDiaryCard: DaysCardView, KeyboardInputDelegate {

    // MARK: - Format
    
    static let format: DateFormatter = DateFormatter("yyyy 年 M 月 d 日")
    var format: DateFormatter { return HabitShowDiaryCard.format }
    
    // MARK: - Data
    
    var diary: Diary!
    
    // MARK: - Reload
    
    override func reload() {
        diary = habit.diary_find(date: date.date)
        text_label.text = diary.value.note
        update_frame()
    }
    
    func update_frame() {
        let height = max(text_label.sizeThatFits(CGSize(width: bounds.width - 60, height: 1000)).height, 50) + 120
        if self.frame.height != height {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.size.height = height
                self.layoutIfNeeded()
                self.table.update_content_size()
            })
        }
    }
    
    // MARK: - Views
    
    @IBOutlet weak var text_label: UILabel!
    
    @IBAction func edit_action(_ sender: Button) {
        if let view = KeyboardInput.load(nib: nil) {
            view.delegate = self
            view.input.font = text_label.font
            view.update_input(text: diary.value.note)
            view.update_title(title: format.string(from: Date(diary.value.date)))
            view.push()
        }
    }
    
    func keyboard_input(input: KeyboardInput, save value: String) {
        diary.value.note = value
        diary.value.update()
        text_label.text = value
        update_frame()
    }
    
}
