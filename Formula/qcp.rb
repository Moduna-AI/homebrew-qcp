# Homebrew formula for qcp.
# Intended to live in a tap repo, e.g. Moduna-AI/homebrew-qcp/Formula/qcp.rb

class Qcp < Formula
  include Language::Python::Virtualenv

  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com"
  url "https://files.pythonhosted.org/packages/0d/b0/0f6f21d8f5601d2ce4d9f7f77f4bb515ea5d7a83b6a513a170490035f85c/qcp_cli-0.1.7.tar.gz"
  sha256 "97c5aadf0abca0815bbf0cc07fabb43b1203fa5fc17f5d1e4bdacd9b7fed1be9"
  license "MIT"

  depends_on "uv"

  def install
    # Use uv to cleanly build, resolve dependencies, and isolate the binary into Homebrew
    system "uv", "tool", "install", "--root", prefix, "qcp-cli==#{version}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
