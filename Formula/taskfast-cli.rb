class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.17.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.17.1/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1aaa6fa0088b4c0fd0cca094cf02a6fb445bfd08eb2e831d777a498ea60c1c18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.17.1/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c8046a8818a1dc1b9747c15cc3db069cf63883a092669217018fb4814c903c42"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.17.1/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "08fe0c4a9eedb1d2e3328419eabe28b2e0e5ae9e9773706c8b0c62dd803db9d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.17.1/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21b9b069dd3253827dabc2609b003fc482fa29749ddba3117040c26b14a8128e"
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
