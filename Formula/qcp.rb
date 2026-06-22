class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.10"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.10/qcp-arm64"
      sha256 "PLACEHOLDER"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.10/qcp-x86_64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install Dir["qcp*"].first => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
