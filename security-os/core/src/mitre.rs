use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MitreMapping {
    pub tactic: String,
    pub technique: String,
    pub sub_technique: Option<String>,
    pub id: String,
    pub description: String,
}

impl MitreMapping {
    pub fn new(tactic: &str, technique: &str, id: &str) -> Self {
        Self {
            tactic: tactic.into(),
            technique: technique.into(),
            sub_technique: None,
            id: id.into(),
            description: String::new(),
        }
    }

    pub fn with_sub_technique(mut self, sub: &str) -> Self {
        self.sub_technique = Some(sub.into());
        self
    }

    pub fn with_description(mut self, desc: &str) -> Self {
        self.description = desc.into();
        self
    }
}

pub struct MitreRegistry {
    mappings: HashMap<String, MitreMapping>,
}

impl MitreRegistry {
    pub fn new() -> Self {
        let mut mappings = HashMap::new();
        Self::register_all(&mut mappings);
        Self { mappings }
    }

    pub fn get_mapping(&self, event_name: &str) -> Option<&MitreMapping> {
        self.mappings.get(event_name)
    }

    pub fn get_all(&self) -> &HashMap<String, MitreMapping> {
        &self.mappings
    }

    fn register_all(m: &mut HashMap<String, MitreMapping>) {
        // ── Initial Access ──
        m.insert("ExploitPublicFacingApp".into(), MitreMapping::new("Initial Access", "Exploit Public-Facing Application", "T1190"));
        m.insert("DriveByCompromise".into(), MitreMapping::new("Initial Access", "Drive-By Compromise", "T1189"));
        m.insert("Phishing".into(), MitreMapping::new("Initial Access", "Phishing", "T1566"));
        m.insert("ValidAccounts".into(), MitreMapping::new("Initial Access", "Valid Accounts", "T1078"));

        // ── Execution ──
        m.insert("ProcessCreated".into(), MitreMapping::new("Execution", "Process Creation", "T1059"));
        m.insert("CommandAndScripting".into(), MitreMapping::new("Execution", "Command and Scripting Interpreter", "T1059"));
        m.insert("PowerShell".into(), MitreMapping::new("Execution", "PowerShell", "T1059.001"));
        m.insert("PythonExecution".into(), MitreMapping::new("Execution", "Python", "T1059.006"));
        m.insert("ScheduledTask".into(), MitreMapping::new("Execution", "Scheduled Task/Job", "T1053"));
        m.insert("SystemdService".into(), MitreMapping::new("Execution", "Systemd Service", "T1543.002"));

        // ── Persistence ──
        m.insert("FileModified".into(), MitreMapping::new("Persistence", "File Modification", "T1565.001"));
        m.insert("WebShell".into(), MitreMapping::new("Persistence", "Server Software Component", "T1505.003"));
        m.insert("BootAutostart".into(), MitreMapping::new("Persistence", "Boot or Logon Autostart", "T1547"));
        m.insert("CronJob".into(), MitreMapping::new("Persistence", "Scheduled Task/Job: Cron", "T1053.003"));
        m.insert("SSHKeys".into(), MitreMapping::new("Persistence", "SSH Authorized Keys", "T1098.004"));

        // ── Privilege Escalation ──
        m.insert("PrivilegeEscalation".into(), MitreMapping::new("Privilege Escalation", "Exploitation for Privilege Escalation", "T1068"));
        m.insert("SudoAbuse".into(), MitreMapping::new("Privilege Escalation", "Abuse Elevation Control: Sudo", "T1548.003"));
        m.insert("ContainerEscape".into(), MitreMapping::new("Privilege Escalation", "Escape to Host", "T1611"));
        m.insert("CapabilityAbuse".into(), MitreMapping::new("Privilege Escalation", "Abuse Elevation Control: Linux Capabilities", "T1548.001"));

        // ── Defense Evasion ──
        m.insert("LogTampering".into(), MitreMapping::new("Defense Evasion", "Indicator Removal: Log Tampering", "T1070"));
        m.insert("BinaryPadding".into(), MitreMapping::new("Defense Evasion", "Obfuscated Files: Binary Padding", "T1027.001"));
        m.insert("ProcessHollowing".into(), MitreMapping::new("Defense Evasion", "Process Injection: Process Hollowing", "T1055.012"));
        m.insert("SignedBinaryProxyExec".into(), MitreMapping::new("Defense Evasion", "Signed Binary Proxy Execution", "T1218"));
        m.insert("AppArmorBypass".into(), MitreMapping::new("Defense Evasion", "Impair Defenses: Disable or Modify System Firewall", "T1562.004"));
        m.insert("SELinuxBypass".into(), MitreMapping::new("Defense Evasion", "Impair Defenses", "T1562"));

        // ── Credential Access ──
        m.insert("BruteForce".into(), MitreMapping::new("Credential Access", "Brute Force", "T1110"));
        m.insert("CredentialDumping".into(), MitreMapping::new("Credential Access", "OS Credential Dumping", "T1003"));
        m.insert("Keylogging".into(), MitreMapping::new("Credential Access", "Input Capture: Keylogging", "T1056.001"));
        m.insert("JWTTheft".into(), MitreMapping::new("Credential Access", "Steal Web Session Cookie", "T1539"));

        // ── Lateral Movement ──
        m.insert("LateralMovement".into(), MitreMapping::new("Lateral Movement", "Remote Services", "T1021"));
        m.insert("SSHBruteForce".into(), MitreMapping::new("Lateral Movement", "Remote Services: SSH", "T1021.004"));
        m.insert("KubernetesLateral".into(), MitreMapping::new("Lateral Movement", "Container Administration Command", "T1610"));

        // ── Collection ──
        m.insert("DataStaging".into(), MitreMapping::new("Collection", "Data Staged", "T1074"));
        m.insert("ScreenCapture".into(), MitreMapping::new("Collection", "Screen Capture", "T1113"));
        m.insert("AudioCapture".into(), MitreMapping::new("Collection", "Audio Capture", "T1123"));

        // ── Command and Control ──
        m.insert("NetworkConnection".into(), MitreMapping::new("Command and Control", "Application Layer Protocol", "T1071"));
        m.insert("DNSOverHTTPS".into(), MitreMapping::new("Command and Control", "Application Layer Protocol: DNS", "T1071.004"));
        m.insert("EncryptedChannel".into(), MitreMapping::new("Command and Control", "Encrypted Channel", "T1573"));
        m.insert("DataEncoding".into(), MitreMapping::new("Command and Control", "Data Encoding", "T1132"));

        // ── Exfiltration ──
        m.insert("DataExfiltration".into(), MitreMapping::new("Exfiltration", "Exfiltration Over C2 Channel", "T1041"));
        m.insert("ExfiltrationOverDNS".into(), MitreMapping::new("Exfiltration", "Exfiltration Over Web Service", "T1567"));
        m.insert("DataTransferSize".into(), MitreMapping::new("Exfiltration", "Exfiltration Over Alternative Protocol", "T1048"));

        // ── Impact ──
        m.insert("CryptoMining".into(), MitreMapping::new("Impact", "Resource Hijacking", "T1496"));
        m.insert("Ransomware".into(), MitreMapping::new("Impact", "Data Encrypted for Impact", "T1486"));
        m.insert("ServiceStop".into(), MitreMapping::new("Impact", "Service Stop", "T1489"));
        m.insert("DiskWipe".into(), MitreMapping::new("Impact", "Disk Wipe", "T1561"));

        // ── Discovery ──
        m.insert("SystemDiscovery".into(), MitreMapping::new("Discovery", "System Information Discovery", "T1082"));
        m.insert("NetworkDiscovery".into(), MitreMapping::new("Discovery", "Network Service Scanning", "T1046"));
        m.insert("ContainerDiscovery".into(), MitreMapping::new("Discovery", "Container and Resource Discovery", "T1613"));
        m.insert("CloudDiscovery".into(), MitreMapping::new("Discovery", "Cloud Infrastructure Discovery", "T1580"));

        // ── Resource Development / Supply Chain ──
        m.insert("SupplyChainCompromise".into(), MitreMapping::new("Resource Development", "Supply Chain Compromise", "T1195"));
        m.insert("CompromiseSoftware".into(), MitreMapping::new("Resource Development", "Compromise Software Dependencies", "T1195.002"));
    }
}

impl Default for MitreRegistry {
    fn default() -> Self {
        Self::new()
    }
}
