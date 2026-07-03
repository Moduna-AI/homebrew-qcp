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
  version "0.2.5"

  head "https://github.com/Moduna-AI/qcp.git", branch: "main"

  # ── Stable binaries (updated automatically by release workflow) ──────────────
  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-macos-arm64"
      sha256 "14af9b06a8d421df1173df31a480a4caf1dcbce94d97ccf4f07f3a43f1c33d1f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-x64"
      sha256 "c470d249ea448a4abdbee6c4d537b1a9cc3c10cdf550e14fff5fc8e6bf350610"
    end

    on_arm do
      url "https://github.com/Moduna-AI/qcp/releases/download/v#{version}/qcp-linux-arm64"
      sha256 "32fbc0a1e835c69eaf566714e3418b49a6621ccac1aa66feafd3c3efd5032d3d"
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
