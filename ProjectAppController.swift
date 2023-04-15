//
//  ProjectAppController.swift
//  ProjectApp
//
//  Created by Emilio Viscal on 4/13/23.
//

import Foundation
import UIKit

class ProjectAppController : UITableViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        GetJSONData()
        //initializeData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destController = segue.destination as! ViewController
        let index = tableView.indexPathForSelectedRow
        let selectedRowST = objectsArray[index!.row]
        destController.SplitViewST = selectedRowST
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCellID")
        let cellIndex = indexPath.row;
        let ST = objectsArray[cellIndex]
        myCell!.textLabel!.text = ST.SoundName;
        myCell!.detailTextLabel!.text = "Tap for Sound"
        
        let img:UIImage = convertToimage(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Shaqi_jrvej.jpg/1200px-Shaqi_jrvej.jpg")
        myCell?.imageView?.image = img
        myCell!.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        myCell!.textLabel!.textColor = UIColor.red
        return myCell!;
    }
    
    func convertToimage(urlString: String) -> UIImage {
        let imgURL = URL(string: urlString)!
        let imgData = try? Data(contentsOf: imgURL)
        print(imgData ?? "Error! Image doesn't exist at URL \(imgURL)")
        let img = UIImage(data: imgData!)
        return img!
    }
    
    var natureObjectArray = [Sounds1]()
    var beatsObjectArray = [Sounds2]()
    
    var objectsArray = [Sounds3]()
    
    func GetJSONData() {
        
        // Use the String address and convert it to a URL type
        let endPointString  = "https://raw.githubusercontent.com/JemilioJ/Soundscapes-App/main/AppJSON.json"
        let endPointURL = URL(string: endPointString)
        
        // Pass it to the Data function
        
        let dataBytes = try? Data(contentsOf:endPointURL!)
        // Receive the bytes
        print(dataBytes) // just for developers to see what is received. this will help in debugging
        
        
        if (dataBytes != nil) {
            // get the JSON Objects and convert it to a Dictionary
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: dataBytes!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print("Dictionary --:  \(dictionary) ---- \n") // for debugging purposes
            
            // Split the Dictionary into two parts. Keep the Sounds3 Part and discard the other
            let stDictionary = dictionary["Sounds3"]! as! [[String:AnyObject]]
            
            
            for index in 0...stDictionary.count - 1  {
                let singleST = stDictionary[index]
                let st = Sounds3()
                st.SoundName = singleST["SoundName"] as! String
                print("Sound Name: - \(st.SoundName)")
                st.webAddress = singleST["webAddress"] as! String
                st.SoundImage = singleST["SoundImage"] as! String
                objectsArray.append(st)
            }
            
            
        }
    }
    
    func initializeData() {
        let s1 = Sounds1() // Creating an object of the class sounds1
        s1.SoundName = "Waterfall"
        s1.SoundImage = "waterfall.jpg"
        natureObjectArray.append(s1)
        let s01 = Sounds3() // Creating an object of the class sounds3
        s01.SoundName = "Waterfall"
        s01.SoundImage = "waterfall.jpg"
        objectsArray.append(s01)
        
        let s2 = Sounds1() // Creating an object of the class sounds
        s2.SoundName = "Rain"
        s2.SoundImage = "rain.jpg"
        natureObjectArray.append(s2)
        let s02 = Sounds3() // Creating an object of the class sounds
        s02.SoundName = "Rain"
        s02.SoundImage = "rain.jpg"
        objectsArray.append(s02)
        
        let s5 = Sounds1()
        s5.SoundName = "Forest"
        s5.SoundImage = "forest.jpg"
        natureObjectArray.append(s5)
        let s05 = Sounds3()
        s05.SoundName = "Forest"
        s05.SoundImage = "forest.jpg"
        objectsArray.append(s05)
        
        let s3 = Sounds2() // Creating an object of the class sounds
        s3.SoundName = "Beat01"
        s3.SoundImage = "beats01.jpg"
        let s03 = Sounds3()
        s03.SoundName = "Beat01"
        s03.SoundImage = "beats01.jpg"
        beatsObjectArray.append(s3)
        objectsArray.append(s03)
        
        let s4 = Sounds2() // Creating an object of the class sounds
        s4.SoundName = "Beat02"
        s4.SoundImage = "beats02.jpg"
        let s04 = Sounds3() // Creating an object of the class sounds
        s04.SoundName = "Beat02"
        s04.SoundImage = "beats02.jpg"
        beatsObjectArray.append(s4)
        objectsArray.append(s04)
        
        let s6 = Sounds2() // Creating an object of the class sounds
        s6.SoundName = "Shepard Tone"
        s6.SoundImage = "shepard tone.jpg"
        s6.webAddress = "https://en.wikipedia.org/wiki/Shepard_tone"
        let s06 = Sounds3() // Creating an object of the class sounds
        s06.SoundName = "Shepard Tone"
        s06.SoundImage = "shepard tone.jpg"
        s06.webAddress = "https://en.wikipedia.org/wiki/Shepard_tone"
        beatsObjectArray.append(s6)
        objectsArray.append(s06)
        
        
        let s7 = Sounds1() // Creating an object of the class sounds
        s7.SoundName = "Jungle"
        s7.SoundImage = "jungle.jpg"
        s7.webAddress = "https://en.wikipedia.org/wiki/Peninsular_Malaysian_rain_forests"
        natureObjectArray.append(s7)
        let s07 = Sounds3() // Creating an object of the class sounds
        s07.SoundName = "Jungle"
        s07.SoundImage = "jungle.jpg"
        s07.webAddress = "https://en.wikipedia.org/wiki/Peninsular_Malaysian_rain_forests"
        objectsArray.append(s07)
    }
}
