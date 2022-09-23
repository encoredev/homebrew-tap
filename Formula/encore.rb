class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.7.2"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.2-darwin_amd64.tar.gz"
    sha256 "140ce620908420c91a7fede5d9e16e86c86340882ffa12a1df58489f091d660e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.2-darwin_arm64.tar.gz"
    sha256 "da19aab4bf072970b21a8dbf8c9073e3fdc7306ff0116681596506be0ac87d7f"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.2-linux_amd64.tar.gz"
    sha256 "f9ffcfa4970f1a0355101417435e3a1e6af0a1f5df80eb92a22357a126de804e"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.2-linux_arm64.tar.gz"
    sha256 "c71d97967674d761244754b882ba0b416d716ee17f7b5c47fce91acf009471bb"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]

    # Install bash completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
    (bash_completion/"encore").write output

    # Install zsh completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
    (zsh_completion/"_encore").write output

    # Install fish completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
    (fish_completion/"encore.fish").write output
  end

  test do
    system "#{bin}/encore", "check"
  end
end
