class Yabai < Formula
  desc "Tiling window manager for macOS based on binary space partitioning"
  homepage "https://github.com/daugvinasr/yabai"
  head "https://github.com/daugvinasr/yabai.git", branch: "master"

  depends_on :macos => :big_sur

  def install
    man.mkpath
    system "make", "-j1", "install"
    system "codesign", "--force", "-s", "-", "bin/yabai"
    bin.install "bin/yabai"
    (pkgshare/"examples").install "examples/yabairc", "examples/skhdrc"
    man1.install "doc/yabai.1"
  end

  def caveats
    <<~EOS
      Copy the example configuration into your home directory:
        cp #{opt_pkgshare}/examples/yabairc ~/.yabairc
        cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

      If you want yabai to be managed by launchd (start automatically upon login):
        yabai --start-service

      When running as a launchd service logs will be found in:
        /tmp/yabai_<user>.[out|err].log

      If you are using the scripting-addition; remember to update your sudoers file:
        sudo visudo -f /private/etc/sudoers.d/yabai

      Build the configuration row by running:
        echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(\\which yabai) | cut -d " " -f 1) $(\\which yabai) --load-sa"

      The binary hash changes on every rebuild, so redo the sudoers row after each upgrade.
    EOS
  end

  test do
    assert_match "yabai-v", shell_output("#{bin}/yabai --version")
  end
end
