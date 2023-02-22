
// ------------------- Helden ------------------- //

var achilis : [String: Any] = ["Name" : "Achilis", "HP" : 100, "Damage" : 5]

var volcon : [String: Any] = ["Name" : "Volcon", "HP" : 100, "Damage" : 5]

var heldenList : [[String:Any]] = [achilis,volcon]

// ------------------- Gegner ------------------- //

var asmodan : [String: Any] = ["Name" : "Asmodan", "HP" : 100, "Damage" : 5]
                                      
var bizznar : [String: Any] = ["Name" : "Bizznar", "HP" : 100, "Damage" : 5]

var gegnerList : [[String:Any]] = [asmodan,bizznar]


func attack(angreifer:[String: Any], opfer: inout [String: Any]) { // "inout" macht das let veränderbar
    
    guard let angreiferName = angreifer["Name"] as? String,
    let angreiferHP = angreifer["HP"] as? Int,
    let angreiferDamage = angreifer["Damage"] as? Int,
    let opferName = opfer["Name"] as? String,
    var opferHP = opfer["HP"] as? Int,
    let opferDamage = opfer["Damage"] as? Int else {
        
        print("Ungültige Eingabe")
        return
    }
    
    print("Angreifer \(angreiferName) greift \(opferName) an und macht \(angreiferDamage) Schaden!")
    opferHP -= angreiferDamage
   
    opfer["HP"] = opferHP
    print("Angreifer \(opferName) hat \(opferHP) HP Points ")
        
    
}



func round() {
    
    
    var rounds = 1
    
    var allHeroesDead = false
    
    var enemyAreDead = false
    
    while !allHeroesDead && !enemyAreDead {
        
        print("\nRunde \(rounds)")
        
        for i in heldenList + gegnerList {
            
            if heldenList.contains(where: {
                return $0["Name"] as? String == i["Name"] as? String
            })  {
                
                print("\nRunde der Helden\n")
                var randomIndex = (0...gegnerList.count-1).randomElement()!
                attack(angreifer: i, opfer: &gegnerList[randomIndex] )
                
                
            } else {
                
                print("\nRunde der Gegner\n")
                var randomIndex2 = (0...heldenList.count-1).randomElement()!
                attack(angreifer: i, opfer: &heldenList[randomIndex2])
            }
        }
        
        // Mit () klammer muss zuerst ausgewertet werden damit der compiler es registriert. Punkt vor Strich!
        allHeroesDead = (heldenList[0]["HP"] as! Int) <= 0 && (heldenList[1]["HP"] as! Int) <= 0
        
        enemyAreDead = (gegnerList[0]["HP"] as! Int) <= 0 && (gegnerList[1]["HP"] as! Int) <= 0
        
        if allHeroesDead && enemyAreDead { // Fälle wie Unentschieden immer noch Oben setzten um alle Fälle abzudecken! Da die Bedingung in eiiner falschen Konstellation sonst nicht erreicht werden könnte.
            print("\nUnentschieden!\n")
        } else if allHeroesDead {
            print("\nGame is over: Gegner gewinnt!\n")
        } else if enemyAreDead {
            print("\nGame is over: Die Helden haben gewonnen\n")
        }
        
        rounds += 1
    }
}

round()
