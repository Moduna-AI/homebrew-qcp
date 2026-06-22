class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.12.alpha.0"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12.alpha.0/qcp-arm64"
      sha256 "289db0c3588ae8a7f039fccbbaa566a82392d1b64f9f5df85a3d63717fe66d86"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.12.alpha.0/qcp-x86_64"
      sha256 "4409b963c353913a22bf0e8b981f3f7f79da0b3f5325196854725ff2ec0a75d1"
    end
  end

  def install
    bin.install Dir["qcp*"].first => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("\#<built-in function bin>/qcp --version")
  end
end
