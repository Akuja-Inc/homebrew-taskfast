class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.19.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.1/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "75b0b2e1ea2774cff27fa216cd84ec95cf1b82b3e622b79d7673982fe1fd4eed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.1/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f64d0f9ea484667686fc142e2dec0165eb6cf1d3a02af92a80af1b0ede132984"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.1/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4d8c6551f4d0ed5e33fffca6cc84103225a12d235689900131639f12ee6adefa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.1/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3e247570323af8da0c7b148480d15136626535bdc12675401ddbd91110310f3f"
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
