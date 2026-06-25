# typed: false
# frozen_string_literal: true

# To tap from the main repo:
#   brew tap Moduna-AI/qcp https://github.com/Moduna-AI/qcp
#   brew install qcp
#
# For HEAD builds (local development / pre-release):
#   brew install --HEAD Moduna-AI/qcp/qcp

HOMEBREW_VERSION = $(jq -r '.version' package.json)

class Qcp < Formula
  desc "AI-powered CLI for querying PostgreSQL in natural language"
  homepage "https://github.com/Moduna-AI/qcp"
  license "MIT"
  version HOMEBREW_VERSION

  head "https://github.com/Moduna-AI/qcp.git", branch: "main"

  # ── Stable binaries (updated automatically by release workflow) ──────────────
  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-macos-arm64"
      sha256 "65d78547099b14e2878f47611d6cdf4e6f911bbcd03174d28ca8081009ed719e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-x64"
      sha256 "6eb9170c7293c9fc424a1d3b079f5ac494f37ba3a7a7241a97b62dd535e049d9"
    end

    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-arm64"
      sha256 "1e659677f2e6a284b32eef39242beff627633eb4ca6b3240f72cc8f5e87e5356"
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
