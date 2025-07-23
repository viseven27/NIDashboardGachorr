import CocoaMQTT
import Foundation

class MQTTManager: CocoaMQTTDelegate, ObservableObject {
    var mqtt: CocoaMQTT!
    
    @Published var latestMessage: String = "Waiting for data..."
    @Published var totalAxle: Int = 0
    @Published var totalLastTire: Int = 0
    
    init () {
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "5.196.78.28", port: 1883)
        mqtt.delegate = self
        mqtt.username = ""
        mqtt.password = ""
        self.mqtt.keepAlive = 30
        self.mqtt.cleanSession = true
        mqtt.willMessage = CocoaMQTTMessage(topic: "forceSensor/data", string: "dieout")
        connect()
    }
    
    func connect() {
        mqtt.connect()
    }
    
    func disconnect() {
        mqtt.disconnect()
    }
    
    func reconnect() {
        print("Attempting to reconnect...")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.connect()
        }
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == .accept {
            print("Connected Succesfully")
            mqtt.subscribe("forceSensor/data", qos: CocoaMQTTQoS.qos0)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("publish topic: \(message.topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        if message.topic == "forceSensor/data" {
            print("message: \(message.string)")
            
            if let string = message.string {
                (totalAxle, totalLastTire) = analyzeForceData(string)
            }
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("Subscribed success: \(success)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: (any Error)?) {
        
    }
    
    /// manually validate ssl/tls server certificate
    /// this method will be called if enable "allowUntrustCertificate"
    @objc func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    @objc func mqttUrlSession(_ mqtt: CocoaMQTT, didReceiveTrust trust: SecTrust, didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    @objc func mqtt(_ mqtt: CocoaMQTT, didPublishComplete id: UInt16) {
        
    }
    
    @objc func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        
    }
    
    func analyzeForceData(_ input: String) -> (Int, Int) {
        // Filter out non-zero characters
        let nonZeroDigits = input.filter { $0 != "0" }

        // Count of non-zero digits
        let length = nonZeroDigits.count

        // Get last non-zero digit (as Int) and multiply by 2
        let lastNonZero = nonZeroDigits.last.flatMap { Int(String($0)) } ?? 0
        let result = lastNonZero * 2

        return (length, result)
    }

}
