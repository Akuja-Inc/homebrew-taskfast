class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.1/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ca7b474a379ce1caba3cef0268d662cad2acf1a8c60f2d1a149dc63aa0704a6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.1/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7004ca20c2f92c5343d4b532aaf85219f17d813b58ad5d4d20a6ada5fa2a1d0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.1/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e0cd054dabb1172ad84cea64a2842850c7ce123a994075b7aa162d17b45be05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.1/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "668cc5d3f7e3cba0959fbb05c5660ff2d0318e957911de0e6167c8d5a43ab7c6"
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
    bin.install "taskfast" if OS.mac? && Hardware::CPU.arm?
    bin.install "taskfast" if OS.mac? && Hardware::CPU.intel?
    bin.install "taskfast" if OS.linux? && Hardware::CPU.arm?
    bin.install "taskfast" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
