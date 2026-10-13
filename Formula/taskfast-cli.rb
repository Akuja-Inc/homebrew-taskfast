class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.19.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.7/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4814fdc1a2f8fd1945487007ee8b3e6280860d0029590e1daa1a3f064dc48b0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.7/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0acd22287dbee3f790dfffcce58f18c945e3f8214a9c6374ffac9d0f6c1a2229"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.7/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5dc39b1c9e262d4c27c25213733b019337ab1b2e4029762ccbf1f61ac426339c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.7/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf125c8669d6b53dc8078304a00659e713832607726d4676051391a92002543a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "taskfast"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "taskfast"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "taskfast"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "taskfast"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
