import UIKit

public class FileNotebook{
    //private var notes : [String: Note]
    private var notes: [Note]
    private let path : URL
    /*public func get_notes() -> [String: Note]{
        return self.notes
    }*/
    public func get_notes() -> [Note]{
        return self.notes
    }
    public func get_at(at: Int) -> Note{
        return self.notes[at]
    }
    public func add( note: Note){
        //notes[note.uid] = note
        notes.append(note)
    }
    /*public func remove(uid: String){
        notes[uid] = nil
    }*/
    public func remove(index: Int){
        notes.remove(at: index)
    }
    public func saveToFile(){
        let fileURL = path.appendingPathComponent("FB").appendingPathExtension("json")
        var dataNotes = [[String: Any]]()
        for i in notes{
            //dataNotes.append(i.value.json)
            dataNotes.append(i.json)
        }
        do {
            let data : Data = try JSONSerialization.data(withJSONObject: dataNotes, options: [])
            FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: [:])
        } catch {
            print(error)
        }
        
    }
    public func loadFromFile(){
        //notes = [String: Note]()
        notes = [Note]()
        let fileURL = path.appendingPathComponent("FB").appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: fileURL.path){
            do {
                let data = FileManager.default.contents(atPath: fileURL.path)
                let js = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                for i in js{
                    add(note: Note.parse(json: i)!)
                }
            } catch {
                print(error)
            }
        }
    }
    init() {
        //notes = [String: Note]()
        notes = [Note]()
        path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
    }
}
