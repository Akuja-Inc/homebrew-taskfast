class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.19.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.6/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c8fc9fe04f8714717e09497c64593f98dd479bb9ac96474a7f5eddacd637b716"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.6/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "54f5370a6d89ad745d21d1cb000864a07cb469957c50af61c91caa7bb93b63b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.6/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2f3a17c016d00bdd98c7f75a73876d11e8a9ae8eee11c564b0d1111faea48589"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.19.6/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d7edbc076e0b5c54838aa01b7ac21e80366194e26f27842533f551939c119a6"
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
