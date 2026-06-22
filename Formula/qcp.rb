class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.12-alpha.2"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12-alpha.2/qcp-arm64"
      sha256 "2a56182aa722c2fbabd1044a244098428c68669ca089310590f9fbc915b32c24"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12-alpha.2/qcp-x86_64"
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
