# Homebrew formula for qcp.
# Intended to live in a tap repo, e.g. Moduna-AI/homebrew-qcp/Formula/qcp.rb

class Qcp < Formula
  include Language::Python::Virtualenv

  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com"
  url "https://files.pythonhosted.org/packages/d9/67/5dc013917808f74048c438fef55a4f0479987d4c182deef22fa3ab153373/qcp_cli-0.1.10.tar.gz"
  sha256 "0a6758a4127bf44f1cd77169aecdac43c40afa8deb93cbb723523987bc75b432"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
