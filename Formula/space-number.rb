class SpaceNumber < Formula
  desc "Menu bar space indicator for yabai"
  homepage "https://github.com/daugvinasr/space-number"
  url "https://github.com/daugvinasr/space-number/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f263deff8db065fac014ed10d374bf078087dcbfd9c3decfd51a70673b2eb419"
  head "https://github.com/daugvinasr/space-number.git", branch: "main"

  depends_on :macos

  def install
    system "swiftc", "-O", "SpaceNumber.swift", "-o", "space-number"
    system "codesign", "--force", "-s", "-", "space-number"
    bin.install "space-number"
  end

  service do
    run opt_bin/"space-number"
    keep_alive true
    process_type :interactive
    log_path var/"log/space-number.log"
    error_log_path var/"log/space-number.log"
  end

  test do
    assert_predicate bin/"space-number", :executable?
  end
end
