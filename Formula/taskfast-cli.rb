class TaskfastCli < Formula
  desc "`taskfast` CLI: worker + poster hot-loop operations, JSON-envelope output."
  homepage "https://github.com/Akuja-Inc/taskfast-cli"
  version "0.18.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.18.2/taskfast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "85f0cfeb0fc502f473540952daaf32b715c401eb3c09f456b789bacb014e2420"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.18.2/taskfast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a9f18f28aa6972abf07632c215793b7e34bfe2a9d6017ba076a903dc6d97b791"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.18.2/taskfast-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a11d418975adbd4adc956997ab25324d4df59857296d987f83b964f982184ef7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Akuja-Inc/taskfast-cli/releases/download/taskfast-cli-v0.18.2/taskfast-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f99c053800e7fad7ee68e4d663eb8d95c6ebe27fb4e5c36947b71a47ee02bd2"
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
