use clap::{Parser, Subcommand};
use serde_json::Value;
use tracing::{error, info};

#[derive(Parser)]
#[command(name = "security-os", about = "Reservatior Security OS CLI")]
pub struct Cli {
    #[command(subcommand)]
    pub command: Commands,
}

#[derive(Subcommand)]
pub enum Commands {
    Status {
        #[arg(short, long, default_value = "http://localhost:8080")]
        api_url: String,
    },
    Events {
        #[arg(short, long, default_value = "http://localhost:8080")]
        api_url: String,
        #[arg(short, long, default_value_t = 20)]
        limit: u32,
        #[arg(short, long)]
        category: Option<String>,
    },
    Stream {
        #[arg(short, long, default_value = "http://localhost:8080")]
        api_url: String,
    },
    Stats {
        #[arg(short, long, default_value = "http://localhost:8080")]
        api_url: String,
    },
    Health {
        #[arg(short, long, default_value = "http://localhost:8080")]
        api_url: String,
    },
}

pub async fn check_health(api_url: &str) -> security_os_core::Result<()> {
    let url = format!("{}/health", api_url);
    info!("Checking health at {}", url);

    let client = reqwest::Client::new();
    match client.get(&url).send().await {
        Ok(resp) => {
            let status = resp.status();
            if status.is_success() {
                match resp.json::<Value>().await {
                    Ok(body) => {
                        println!("Health: OK");
                        if let Some(version) = body.get("version") {
                            println!("  Version: {}", version);
                        }
                        if let Some(status_val) = body.get("status") {
                            println!("  Status:  {}", status_val);
                        }
                        if let Some(uptime) = body.get("uptime_secs") {
                            println!("  Uptime:  {}s", uptime);
                        }
                    }
                    Err(e) => {
                        println!("Health: OK (status {})", status);
                        error!("Failed to parse health response: {}", e);
                    }
                }
            } else {
                println!("Health: UNHEALTHY (status {})", status);
            }
        }
        Err(e) => {
            error!("Failed to connect to {}: {}", api_url, e);
            println!("Health: FAILED - {}", e);
            println!("  Is the security-os API running at {}?", api_url);
        }
    }
    Ok(())
}

pub async fn list_events(
    api_url: &str,
    limit: u32,
    category: Option<&str>,
) -> security_os_core::Result<()> {
    let mut url = format!("{}/api/v1/events?limit={}", api_url, limit);
    if let Some(cat) = category {
        url.push_str(&format!("&category={}", cat));
    }
    info!("Fetching events from {}", url);

    let client = reqwest::Client::new();
    let resp = client
        .get(&url)
        .send()
        .await
        .map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;

    if !resp.status().is_success() {
        return Err(security_os_core::SecurityOsError::Api(format!(
            "HTTP {}",
            resp.status()
        )));
    }

    let body: Value = resp
        .json()
        .await
        .map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;

    let events = body
        .as_array()
        .or_else(|| body.get("events").and_then(|v| v.as_array()))
        .cloned()
        .unwrap_or_default();

    if events.is_empty() {
        println!("No events found.");
        return Ok(());
    }

    println!(
        "{:<38} {:<20} {:<12} {:<10} {:<40}",
        "ID", "TIMESTAMP", "SEVERITY", "CATEGORY", "TITLE"
    );
    println!("{}", "-".repeat(120));

    for event in &events {
        let id = event.get("id").and_then(|v| v.as_str()).unwrap_or("?");
        let timestamp = event
            .get("timestamp")
            .and_then(|v| v.as_str())
            .unwrap_or("?");
        let severity = event
            .get("severity")
            .and_then(|v| v.as_str())
            .unwrap_or("?");
        let category = event
            .get("category")
            .and_then(|v| v.as_str())
            .unwrap_or("?");
        let title = event.get("title").and_then(|v| v.as_str()).unwrap_or("?");
        println!(
            "{:<38} {:<20} {:<12} {:<10} {:<40}",
            id, timestamp, severity, category, title
        );
    }

    println!("\nShowing {} event(s)", events.len());
    Ok(())
}

pub async fn stream_events(api_url: &str) -> security_os_core::Result<()> {
    let url = format!("{}/api/v1/events/stream", api_url);
    info!("Connecting to SSE stream at {}", url);

    let client = reqwest::Client::new();
    let resp = client
        .get(&url)
        .header("Accept", "text/event-stream")
        .send()
        .await
        .map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;

    if !resp.status().is_success() {
        return Err(security_os_core::SecurityOsError::Api(format!(
            "SSE stream failed with status {}",
            resp.status()
        )));
    }

    println!("Connected to event stream. Listening for events...\n");

    let mut stream = resp.bytes_stream();
    use futures::StreamExt;

    let mut buffer = String::new();
    while let Some(chunk) = stream.next().await {
        let chunk = chunk.map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;
        let text = String::from_utf8_lossy(&chunk);
        buffer.push_str(&text);

        while let Some(line_end) = buffer.find('\n') {
            let line = buffer[..line_end].trim().to_string();
            buffer = buffer[line_end + 1..].to_string();

            if line.starts_with("data: ") {
                let data = &line[6..];
                if data.trim() == "[DONE]" {
                    println!("\nStream ended.");
                    return Ok(());
                }
                match serde_json::from_str::<Value>(data) {
                    Ok(event) => {
                        let timestamp = chrono::Utc::now().format("%H:%M:%S");
                        let severity = event
                            .get("severity")
                            .and_then(|v| v.as_str())
                            .unwrap_or("?");
                        let title = event
                            .get("title")
                            .and_then(|v| v.as_str())
                            .unwrap_or("?");
                        let category = event
                            .get("category")
                            .and_then(|v| v.as_str())
                            .unwrap_or("?");
                        println!(
                            "[{}] {:<12} {:<15} {}",
                            timestamp, severity, category, title
                        );
                    }
                    Err(_) => {
                        println!("  Raw: {}", data);
                    }
                }
            }
        }
    }

    Ok(())
}

pub async fn show_stats(api_url: &str) -> security_os_core::Result<()> {
    let url = format!("{}/api/v1/stats", api_url);
    info!("Fetching stats from {}", url);

    let client = reqwest::Client::new();
    let resp = client
        .get(&url)
        .send()
        .await
        .map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;

    if !resp.status().is_success() {
        return Err(security_os_core::SecurityOsError::Api(format!(
            "HTTP {}",
            resp.status()
        )));
    }

    let body: Value = resp
        .json()
        .await
        .map_err(|e| security_os_core::SecurityOsError::Network(e.to_string()))?;

    println!("Security OS Statistics");
    println!("{}", "=".repeat(40));

    if let Some(total) = body.get("total_events") {
        println!("Total Events:    {}", total);
    }
    if let Some(by_severity) = body.get("by_severity") {
        println!("\nBy Severity:");
        if let Some(obj) = by_severity.as_object() {
            for (sev, count) in obj {
                println!("  {:<15} {}", sev, count);
            }
        }
    }
    if let Some(by_category) = body.get("by_category") {
        println!("\nBy Category:");
        if let Some(obj) = by_category.as_object() {
            for (cat, count) in obj {
                println!("  {:<25} {}", cat, count);
            }
        }
    }
    if let Some(active_hosts) = body.get("active_hosts") {
        println!("\nActive Hosts:    {}", active_hosts);
    }
    if let Some(uptime) = body.get("uptime_secs") {
        println!("Uptime:          {}s", uptime);
    }
    if let Some(avg_risk) = body.get("avg_risk_score") {
        println!("Avg Risk Score:  {}", avg_risk);
    }

    Ok(())
}

pub async fn run(cli: Cli) -> security_os_core::Result<()> {
    match cli.command {
        Commands::Status { api_url } => check_health(&api_url).await,
        Commands::Events {
            api_url,
            limit,
            category,
        } => list_events(&api_url, limit, category.as_deref()).await,
        Commands::Stream { api_url } => stream_events(&api_url).await,
        Commands::Stats { api_url } => show_stats(&api_url).await,
        Commands::Health { api_url } => check_health(&api_url).await,
    }
}
