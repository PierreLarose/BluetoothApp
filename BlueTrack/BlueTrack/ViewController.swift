//
//  ViewController.swift
//  BlueTrack
//
//  Created by Pierre Larose on 1/28/15.
//  Copyright (c) 2015 Pierre Larose. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    var peripherals : [CBPeripheral] = []
    var RSSIs : [NSNumber] = []
    var myCenteralManager : CBCentralManager? = nil
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refreshTapped() {
        startScan()
        
    }
    
    
    
    
    func startScan() {
        self.peripherals = []
        self.RSSIs = []
        self.tableView.reloadData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scaning", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        self.myCenteralManager!.scanForPeripheralsWithServices(nil, options: nil)
        _ = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(ViewController.stopScan), userInfo: nil, repeats: false)
    }
    
    func stopScan() {
       self.myCenteralManager?.stopScan()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(ViewController.refreshTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(ViewController.refreshTapped))
        self.myCenteralManager = CBCentralManager(delegate: self, queue: nil)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("uuidCell") as! PeripheralTableViewCell
        let peripheral = self.peripherals[indexPath.row]
        let RSSI = self.RSSIs[indexPath.row]
        cell.uuidLabel.text = peripheral.identifier.UUIDString
        cell.percentageLabel.text = "Signal Strength: \(RSSI)"
        return cell
    }

    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("HELLO THERE")
        startScan()
    }

    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("We found one!")
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        self.tableView.reloadData()
        print(RSSI)
    }
}

