class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.10-rc3"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.10-rc3/qcp-arm64"
      sha256 "510e8905dcfd0eb9d57e8931716ce44fd374cc452f3d47785a65cf6f35bd6d63"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.10-rc3/qcp-x86_64"
      sha256 "3701c52b3ec991679f76eb610199a7a8f1d0e0e867987511102b5ff937f94ef2"
    end
  end

  def install
    bin.install Dir["qcp*"].first => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("\#<built-in function bin>/qcp --version")
  end
end
