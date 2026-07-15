class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.16.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.16.1/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f9de15aad28d7976c500ff8c9f18bc93f94ae33154f8a3a87f306b5c6c598104"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.16.1/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4a1873f351adeadf56c1ed5aca477db63a514edc610762ea4c3898afb1df862f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.16.1/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "61df15565df6d55c57cc7b89b227187f954d9af1ff7130b36dde38d604a6c511"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.16.1/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a2dc8cb1eeda204e486d6cece9a2cf89655192900ff725c207b67ccc0ed05279"
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
