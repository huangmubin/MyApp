//
//  LogEditTimeCard.swift
//  Days
//
//  Created by Myron on 2018/5/18.
//  Copyright © 2018年 Myron. All rights reserved.
//

import UIKit

class LogEditTimeCard: CardView, KeyboardTimeInputDelegate {

    override func reload() {
        start_button.setTitle(
            "\(number(log.value.date_s.hour)):\(number(log.value.date_s.minute))",
            for: .normal
        )
        
        let end_title = "\(number(log.value.date_e.hour)):\(number(log.value.date_e.minute))"
        if end_title == "00:00" {
            end_button.setTitle(
                "24:00",
                for: .normal
            )
        } else {
            end_button.setTitle(
                end_title,
                for: .normal
            )
        }
        
        length.text = log.length_text
    }
    
    // MARK: - Time Formatter
    
    func number(_ v: Int) -> String {
        if v < 10 {
            return "0\(v)"
        } else {
            return "\(v)"
        }
    }
    
    // MARK: - Length
    
    @IBOutlet weak var length: UILabel!
    
    // MARK: - Start
    
    @IBOutlet weak var start_button: Button!
    
    @IBAction func start_action(_ sender: Any) {
        if let view = KeyboardTimeInput.load(nib: nil) {
            view.time_delegate = self
            view.hour_view.text = number(log.value.date_s.hour)
            view.minute_view.text = number(log.value.date_s.minute)
            view.hour_view.old = view.hour_view.text
            view.minute_view.old = view.minute_view.text
            view.id = "start"
            view.push()
        }
    }
    
    // MARK: - End
    
    @IBOutlet weak var end_button: Button!
    
    @IBAction func end_action(_ sender: Any) {
        if let view = KeyboardTimeInput.load(nib: nil) {
            view.time_delegate = self
            view.hour_view.text = number(log.value.date_e.hour)
            view.minute_view.text = number(log.value.date_e.minute)
            view.hour_view.old = view.hour_view.text
            view.minute_view.old = view.minute_view.text
            view.id = "end"
            view.push()
        }
    }
    
    // MARK: - Keyboard
    
    func keyboard_time(_ view: KeyboardTimeInput, hour: Int, minute: Int) {
        let zero = log.value.date_s.first(.day).time1970
        var start = log.value.date_s.time1970 - zero
        var end = log.value.date_e.time1970 - zero
        if view.id == "start" {
            start = hour * 3600 + minute * 60
            if start == 86400 {
                start = 86400 - log.habit.value.length
                end = 86400
            } else if start >= end {
                end = min(start + log.habit.value.length, 86400)
            }
        } else {
            end = hour * 3600 + minute * 60
            if end == 0 {
                start = 0
                end = log.habit.value.length
            } else if start >= end {
                start = max(0, end - log.habit.value.length)
            }
        }
        log.value.start = zero + start
        log.value.length = end - start
        normal_button_reset()
        
        // print("--- new date ---")
        // let form = DateFormatter("yyyy - MM - dd HH:mm:ss")
        // print(form.string(from: log.value.date_s))
        // print(form.string(from: log.value.date_e))
        
        reload()
    }
    
    // MARK: - Normal
    
    @IBOutlet var normal_buttons: [Button]!
    
    @IBAction func normal_actions(_ sender: Button) {
        log.value.length = sender.tag
        reload()
        normal_button_reset()
        sender.normal_color = log.habit.color()
        sender.setTitleColor(Color.white, for: .normal)
    }
    
    func normal_button_reset() {
        normal_buttons.forEach({
            $0.normal_color = Color.gray_light
            $0.setTitleColor(Color.dark, for: .normal)
        })
    }
    
}
