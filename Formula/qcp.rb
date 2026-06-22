class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.10"

  on_macos do
    on_arm do
      url "file:///Users/ashwin/Documents/github/qcp-cli/dist/qcp-arm64"
      sha256 "a4c59a833a2cf4af26ca1a2b9e996b6fe15e0aed856670d9beb7bb322cd87641"
    end
    on_intel do
      url "file:///Users/ashwin/Documents/github/qcp-cli/v0.1.10/qcp-x86_64"
      sha256 "a4c59a833a2cf4af26ca1a2b9e996b6fe15e0aed856670d9beb7bb322cd87641"
    end
  end

  def install
    bin.install bin.install "qcp-arm64" => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qcp --version")
  end
end
