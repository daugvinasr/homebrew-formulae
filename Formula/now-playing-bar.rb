class NowPlayingBar < Formula
  desc "Menu bar item showing the currently playing track on macOS"
  homepage "https://github.com/daugvinasr/now-playing-bar"
  head "https://github.com/daugvinasr/now-playing-bar.git", branch: "main"

  depends_on "cmake" => :build
  depends_on xcode: :build
  depends_on :macos

  # Helper framework + Perl script that read now-playing info via MediaRemote.
  # Loaded by /usr/bin/perl at runtime; must be bundled, not linked against.
  resource "mediaremote-adapter" do
    url "https://github.com/ungive/mediaremote-adapter/archive/refs/tags/v0.7.7.tar.gz"
    sha256 "2d9c10177dfff499fe396fe0137b9d1c501c8a3f4799cb747c0016f8b55db5b0"
  end

  def install
    resource("mediaremote-adapter").stage do
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build", "--target", "MediaRemoteAdapter"
      libexec.install "bin/mediaremote-adapter.pl", "build/MediaRemoteAdapter.framework"
    end

    system "make", "SWIFTC=swiftc"
    bin.install "now-playing-bar"
  end

  service do
    run [opt_bin/"now-playing-bar"]
    keep_alive true
    log_path var/"log/now-playing-bar.log"
    error_log_path var/"log/now-playing-bar.log"
  end

  def caveats
    <<~EOS
      To start now-playing-bar at login and keep it running:
        brew services start now-playing-bar

      Preferences (restart the app after changing):
        defaults write now-playing-bar hideArtistName -bool true
        defaults write now-playing-bar cleanupTitle -bool true
        defaults write now-playing-bar maxTextLength -int 60
        defaults write now-playing-bar iconType -string icon
    EOS
  end

  test do
    assert_path_exists libexec/"MediaRemoteAdapter.framework/MediaRemoteAdapter"
    # The script blocks when invoked without a command, so only syntax-check it here.
    assert_match "syntax OK", shell_output("/usr/bin/perl -c #{libexec}/mediaremote-adapter.pl 2>&1")
  end
end
