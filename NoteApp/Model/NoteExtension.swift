import UIKit

extension UIColor {
    
    var redValue: CGFloat{
        return cgColor.components! [0]
    }
    
    var greenValue: CGFloat{
        return cgColor.components! [1]
    }
    
    var blueValue: CGFloat{
        return cgColor.components! [2]
    }
    
    var alphaValue: CGFloat{
        return cgColor.components! [3]
    }
}
extension Note{
    
    static func parse(json: [String: Any]) -> Note?{
        var dict: [String: Any] = [:]
        
        if let uid = json["uid"]{
            dict.updateValue(uid, forKey: "uid")
        }
        else {
            return nil
        }
        if let title = json["title"]{
            dict.updateValue(title, forKey: "title")
        }
        else {
            return nil
        }
        if let content = json["content"]{
            dict.updateValue(content, forKey: "content")
        }
        else {
            return nil
        }
        if let colorStr = json["color"] as? [Float]{
            var colorStrCG = [CGFloat]()
            colorStrCG.insert(CGFloat(colorStr[0]), at: 0)
            colorStrCG.insert(CGFloat(colorStr[1]), at: 1)
            colorStrCG.insert(CGFloat(colorStr[2]), at: 2)
            colorStrCG.insert(CGFloat(colorStr[3]), at: 3)
            
            let color = UIColor(red: colorStrCG[0], green: colorStrCG[1], blue: colorStrCG[2], alpha: colorStrCG[3])
            dict.updateValue(color, forKey: "color")
        }
        else {
            dict.updateValue(UIColor.white, forKey: "color")
        }
        if let importanceStr = json["importance"] as? String{
            var importance: Note.Importance
            switch importanceStr {
            case "low":
                importance = Note.Importance.low
            case "high":
                importance = Note.Importance.high
            default:
                return nil
            }
            dict.updateValue(importance, forKey: "importance")
        }
        else {
            dict.updateValue(Note.Importance.usual, forKey: "importance")
        }
        if let selfDestructionDateStr = json["selfDestructionDate"] as? TimeInterval{
            let selfDestructionDate = Date(timeIntervalSince1970: selfDestructionDateStr)
            dict.updateValue(selfDestructionDate, forKey: "selfDestructionDate")
            return Note(uid: dict["uid"] as! String, title: dict["title"] as! String, content: dict["content"] as! String, color: dict["color"] as! UIColor, importance: dict["importance"] as! Note.Importance, selfDestructionDate: dict["selfDestructionDate"] as! Date)
        }
        else {
            return Note(uid: dict["uid"] as! String, title: dict["title"] as! String, content: dict["content"] as! String, color: dict["color"] as! UIColor, importance: dict["importance"] as! Note.Importance)
        }
    }
    var json: [String: Any]{
        get{
            var dict = [String: Any]()
            dict["uid"] = self.uid
            dict["title"] = self.title
            dict["content"] = self.content
            if self.color != UIColor.white {
                let red = Float(self.color.redValue)
                let green = Float(self.color.greenValue)
                let blue = Float(self.color.blueValue)
                let alpha = Float(self.color.alphaValue)
                var colorStr = [Float]()
                colorStr.append(red)
                colorStr.append(green)
                colorStr.append(blue)
                colorStr.append(alpha)
                dict["color"] = colorStr
            }
            if self.importance != Note.Importance.usual{
                var str = String()
                if self.importance == Note.Importance.low{
                    str = "low"
                }
                if self.importance == Note.Importance.high{
                    str = "high"
                }
                dict["importance"] = str
            }
            if self.selfDestructionDate != nil {
                let time = self.selfDestructionDate!.timeIntervalSince1970
                dict["selfDestructionDate"] = time
            }
            return dict
        }
    }
}
