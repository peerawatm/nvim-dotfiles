use std::path::{Path, PathBuf};
use tokio::{process::Command, task::JoinSet};

#[tokio::main]
async fn main() {
    let base_dir = Path::new(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .expect("crate has no parent dir")
        .join("pack/manual/start");

    let plugins: Vec<PathBuf> = std::fs::read_dir(base_dir)
        .expect("pack/manual/start not found")
        .flatten()
        .map(|e| e.path())
        .filter(|p| p.is_dir() && p.join(".git").exists())
        .collect();

    if plugins.is_empty() {
        println!("No git plugin repositories found in pack/manual/start.");
        return;
    }

    let mut set = JoinSet::new();
    for path in plugins {
        set.spawn(update_plugin(path));
    }
    while set.join_next().await.is_some() {}
}

async fn update_plugin(path: PathBuf) {
    let name = path.file_name().unwrap().to_string_lossy().into_owned();
    match do_update(&path).await {
        Ok((branch, old, new)) => {
            if old != new {
                println!("\u{2713} {} ({}) {} -> {}", name, branch, old, new);
            } else {
                println!("- {} ({}) {} already up to date", name, branch, old);
            }
        }
        Err(e) => println!("\u{2717} {} failed: {}", name, e),
    }
}

async fn git(dir: &Path, args: &[&str]) -> Result<String, String> {
    let out = Command::new("git")
        .current_dir(dir)
        .args(args)
        .output()
        .await
        .map_err(|e| e.to_string())?;

    if out.status.success() {
        Ok(String::from_utf8_lossy(&out.stdout).trim().to_string())
    } else {
        Err(String::from_utf8_lossy(&out.stderr).trim().to_string())
    }
}

async fn do_update(path: &Path) -> Result<(String, String, String), String> {
    // Returns (branch, old_hash, new_hash)
    let head = git(path, &["rev-parse", "--abbrev-ref", "HEAD"]).await?;

    let branch = if head == "HEAD" {
        let remote_head = git(path, &["rev-parse", "--abbrev-ref", "origin/HEAD"])
            .await
            .unwrap_or_default()
            .replace("origin/", "");

        let def = if remote_head.is_empty() || remote_head == "HEAD" {
            match git(path, &["show-ref", "--verify", "--quiet", "refs/heads/main"]).await {
                Ok(_) => "main".to_string(),
                Err(_) => "master".to_string(),
            }
        } else {
            remote_head
        };

        git(path, &["checkout", "-q", &def]).await?;
        def
    } else {
        head
    };

    let old_hash = git(path, &["rev-parse", "--short", "HEAD"]).await?;

    let _ = git(
        path,
        &[
            "-c",
            "gc.auto=0",
            "pull",
            "-q",
            "--depth=1",
            "--no-tags",
            "--recurse-submodules=no",
            "origin",
            &branch,
        ],
    )
    .await?;

    let new_hash = git(path, &["rev-parse", "--short", "HEAD"]).await?;

    Ok((branch, old_hash, new_hash))
}
