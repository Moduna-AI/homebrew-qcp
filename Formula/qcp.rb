# Homebrew formula for qcp.
# Intended to live in a tap repo, e.g. Moduna-AI/homebrew-qcp/Formula/qcp.rb

class Qcp < Formula
  include Language::Python::Virtualenv

  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com"
  url "https://files.pythonhosted.org/packages/66/83/2ef75c2710e795f54abc288dcee616a72982006205e23f7f782820a8ff35/qcp_cli-0.1.8.tar.gz"
  sha256 "4885fdcc9a05cc9aefb5ad26a8b86267b3c88f70c3afcf43ee82a737c72b1d78"
  license "MIT"

  depends_on "python@3.14"
  
  def install
    # 1. Create a native Homebrew virtual environment inside libexec
    venv = virtualenv_create(libexec, "python3.14")
    
    # 2. Tell the internal pip to pull your app and its dependencies from PyPI
    # Using --no-binary ensures it compiles neatly for the user's system architecture
    venv.pip_install ["qcp-cli==#{version}", "--uploaded-prior-to=2030-01-01T00:00:00Z"]
    
    # 3. Create a global symlink into Homebrew's binary directory
    bin.install_symlink libexec/"bin/qcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
