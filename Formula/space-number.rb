class SpaceNumber < Formula
  desc "Menu bar space indicator for yabai"
  homepage "https://github.com/daugvinasr/space-number"
  head "https://github.com/daugvinasr/space-number.git", branch: "main"

  depends_on :macos

  def install
    commit = Utils.git_head(cached_download, length: 7)
    system "make", "VERSION=HEAD", "COMMIT=#{commit}"
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
    assert_match "space-number HEAD (", shell_output("#{bin}/space-number --version")
  end
end
