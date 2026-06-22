class Qcp < Formula
  desc "Query Companion: query Postgres databases in natural language"
  homepage "https://github.com/Moduna-AI/qcp-cli"
  version "0.1.11"

  on_macos do
    on_arm do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.11/qcp-arm64"
      sha256 "50e7d37959c9aa0e6658d71093143d79fa40d70b6a2919f93413b16f5ab4f2b4"
    end
    on_intel do
      url "https://github.com/Moduna-AI/qcp-cli/releases/download/v0.1.11/qcp-x86_64"
      sha256 "1e1ea607139cd10f553fb65b36b9d8697af742721273db5341bc437583fb5cbe"
    end
  end

  def install
    bin.install Dir["qcp*"].first => "qcp"
  end

  test do
    assert_match version.to_s, shell_output("\#<built-in function bin>/qcp --version")
  end
end
