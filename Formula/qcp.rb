class Qcp < Formula
  include Language::Python::Virtualenv

  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12.alpha.3/qcp_cli-0.1.12.alpha.3.tar.gz"
  sha256 "b96c2679d7b2637e37f8f92886db29318a8e4fc5b3434de4caf99587da94dc34"
  license "MIT"

  depends_on "python@3.14"

  def install
    system "python3.14", "-m", "venv", libexec
    system libexec/"bin/python", "-m", "pip", "install", "--upgrade", "pip"
    system libexec/"bin/python", "-m", "pip", "install", buildpath

    bin.install_symlink libexec/"bin/qcp"
  end

  test do
    system "#{bin}/qcp", "--version"
  end
end
