class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.0/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c2804d15229650b8845c4aae9187e9e2666fd0ce2dd8d8c0d4998947739c366e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.0/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4cbb38e94d30c2319e8198daabc5c0f4fc4852eef1c1ea7507c1e714a9ac1ecd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.0/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "621eb258ea65a009d971e2cedf448eed2ca62894c0d22bad1589453923419cbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.4.0/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a7309a8b17d89f709e5d094aed305c50e2ba81e3737bd6c00de6f8c4f3fc65ba"
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
