class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.15.0/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "56a0a6d3028723450ff1418d3fae3b1d918f4a54e439af84025ecc78e54d0660"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.15.0/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7a17a84ca941e02302fc3458cc80bc790d6a6079edeadb01ac3438cfd30e5c6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.15.0/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3f04d842c8bd317ba31c42a4fe442442b789f05214e77637118bab88d7706606"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.15.0/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e2dd0bb120bd8742ca1cf58aba8799fd10e9e5e2b659a8f95ed210a7e776fe8f"
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
