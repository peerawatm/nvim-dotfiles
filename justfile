default:update
update:
    @if [ ! -f updater/target/release/updater ] || \
        [ updater/src/main.rs -nt updater/target/release/updater ] || \
        [ updater/Cargo.toml -nt updater/target/release/updater ]; then \
        cargo build --manifest-path updater/Cargo.toml --release --quiet; \
    fi
    @./updater/target/release/updater
