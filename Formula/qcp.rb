class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.12.alpha.0"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12.alpha.0/qcp-arm64"
      sha256 "5d19b947f7cd66543e33dcf989670f99d860072207468f719db7906b7c201b68"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12.alpha.0/qcp-x86_64"
      sha256 ""
    end
  end

  def install
    bin.install Dir["qcp*"].first => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("\#<built-in function bin>/qcp --version")
  end
end
