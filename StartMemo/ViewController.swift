//
//  ViewController.swift
//  StartMemo
//
//  Created by Hyeyoung on 2017. 7. 24..
//  Copyright © 2017년 Kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoText: UITextView!
    
    let memoDirectory = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    @IBAction func saveMemo(_ sender: UIButton) {
        let fileName = memoTitle.text!
        let fileText = memoText.text!
        
        let path = memoDirectory!.appendingPathComponent(fileName)
            
        do{
            try fileText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            showAlert(alertTitle: "Memo", alertText: "Saved memo")
            memoText.text = "Insert text.."
            memoTitle.text = ""
        }
        catch{
            showAlert(alertTitle: "Memo", alertText: "Save error")
            print("error")
        }
    }
    
    @IBAction func deleteMemo(_ sender: UIButton) {
        let fileName = memoTitle.text!
        
        let path = memoDirectory!.appendingPathComponent(fileName)
        
        do{
            try FileManager.default.removeItem(at: path)
            
            showAlert(alertTitle: "Memo", alertText: "Deleted memo")
            
            memoText.text = "Insert text.."
            memoTitle.text = ""
        }
        catch{
            
            print("error")
        }

    }
    
    @IBAction func loadMemo(_ sender: UIButton) {
        let fileName = memoTitle.text!
        
        let path = memoDirectory!.appendingPathComponent(fileName)
        
        do{
            let savedText = try String(contentsOf: path, encoding: String.Encoding.utf8)
            memoText.text = savedText
        }
        catch{
            showAlert(alertTitle: "Memo", alertText: "Not exist memo")
            
            memoText.text = "Insert text.."
            print("error")
        }
    }
    
    func showAlert(alertTitle : String, alertText : String) {
        let dialog = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)

    }
    
    @IBAction func clearMemo(_ sender: UIButton) {
        memoText.text = "Insert text.."
        memoTitle.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

