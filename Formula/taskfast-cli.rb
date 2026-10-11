class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.19.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.2/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "62640b0755f7866921234dbbd8979238db1f65d2117de9b37b896085009e1ce4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.2/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9b963666fbe08547f2f596f84a64934e8d79d61ab04a88e17c73b4487fe37b91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.2/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e01c5c6bcda4caf542f19902cc526b6fc3d60c9c3da8abb918f2404473ac4434"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.2/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "76bb7bab31ceebce319e4f20991e823e9b3b6204f63d24f511607008fdcb9559"
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
