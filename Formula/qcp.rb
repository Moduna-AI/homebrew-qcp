# typed: false
# frozen_string_literal: true

# To tap from the main repo:
#   brew tap Moduna-AI/qcp https://github.com/Moduna-AI/qcp
#   brew install qcp
#
# For HEAD builds (local development / pre-release):
#   brew install --HEAD Moduna-AI/qcp/qcp

class Qcp < Formula
  desc "AI-powered CLI for querying PostgreSQL in natural language"
  homepage "https://github.com/Moduna-AI/qcp"
  license "MIT"
  version "0.3.3"

  head "https://github.com/Moduna-AI/qcp.git", branch: "main"

  # ── Stable binaries (updated automatically by release workflow) ──────────────
  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-macos-arm64"
      sha256 "022221c9d684e9516ef591d59b044c7293ed5dd19d133535ccd59b2b093d9ffb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-x64"
      sha256 "e5b359d71c7b11415e4762e9910b4be5d97ee1061e4673af96cddecf9f70f520"
    end

    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-arm64"
      sha256 "875a47839e7fa24789a8afa8301964e4715f7dabd12fd36e5e162d9bc0da5365"
    end
  end

  # ── HEAD (build from source) requires Bun ────────────────────────────────────
  head do
    depends_on "oven-sh/bun/bun"
  end

  def install
    if build.head?
      # Build from source using Bun
      system "bun", "install", "--frozen-lockfile"
      system "bun", "build", "./src/cli/index.ts",
             "--compile",
             "--outfile=qcp"
      bin.install "qcp"
    else
      # Install pre-built binary from GitHub Release
      arch  = Hardware::CPU.arm? ? "arm64" : "x64"
      os    = OS.mac? ? "macos" : "linux"
      bin_name = "qcp-#{os}-#{arch}"

      # The downloaded file has the URL filename; rename to "qcp"
      if File.exist?(bin_name)
        mv bin_name, "qcp"
      end

      chmod "+x", "qcp"
      bin.install "qcp"
    end
  end

  def caveats
    <<~EOS
      Get started with qcp:

        qcp init
        qcp connect postgres://user:pass@host/db
        qcp schema scan
        qcp ask "What are our top customers?"

      Set your Gemini API key (default provider):
        qcp config set-key gemini YOUR_API_KEY

      Or switch to a different provider:
        qcp model set openai     # requires OPENAI_API_KEY
        qcp model set anthropic  # requires ANTHROPIC_API_KEY
        qcp model set ollama     # local, no API key needed

      Documentation: https://github.com/Moduna-AI/qcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
    assert_match "Query Companion", shell_output("#{bin}/qcp --help")
  end
end
