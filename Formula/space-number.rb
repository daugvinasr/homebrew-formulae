class SpaceNumber < Formula
  desc "Menu bar space indicator for yabai"
  homepage "https://github.com/daugvinasr/space-number"
  url "https://github.com/daugvinasr/space-number.git",
      tag:      "v0.2.0",
      revision: "bcf760667e53066a77e7257aad9c849f8ecfd99b"
  head "https://github.com/daugvinasr/space-number.git", branch: "main"

  depends_on :macos

  def install
    commit = build.head? ? Utils.git_head(cached_download, length: 7) : stable.specs[:revision][0, 7]
    system "make", "VERSION=#{version}", "COMMIT=#{commit}"
    system "codesign", "--force", "-s", "-", "build/space-number"
    bin.install "build/space-number"
  end

  service do
    run opt_bin/"space-number"
    keep_alive true
    process_type :interactive
    log_path var/"log/space-number.log"
    error_log_path var/"log/space-number.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/space-number --version")
  end
end
