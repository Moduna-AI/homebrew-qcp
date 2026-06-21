# Homebrew formula for qcp.
# Intended to live in a tap repo, e.g. Moduna-AI/homebrew-qcp/Formula/qcp.rb

class Qcp < Formula
  include Language::Python::Virtualenv

  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com"
  url "https://files.pythonhosted.org/packages/0d/b0/0f6f21d8f5601d2ce4d9f7f77f4bb515ea5d7a83b6a513a170490035f85c/qcp_cli-0.1.7.tar.gz"
  sha256 "97c5aadf0abca0815bbf0cc07fabb43b1203fa5fc17f5d1e4bdacd9b7fed1be9"
  license "MIT"

  depends_on "python@3.14"
  
  def install
    # 1. Create a native Homebrew virtual environment inside libexec
    venv = virtualenv_create(libexec, "python3.14")
    
    # 2. Tell the internal pip to pull your app and its dependencies from PyPI
    # Using --no-binary ensures it compiles neatly for the user's system architecture
    venv.pip_install "qcp-cli==#{version}"
    
    # 3. Create a global symlink into Homebrew's binary directory
    bin.install_symlink libexec/"bin/qcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
