class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.49.1"
    checksums = {
        "darwin_arm64" => "fd02f10739005f1fb7f77fb1b5f5f3eb0717fd7c4bf96791fc3eaba580ea63ee",
        "darwin_amd64" => "4e91c9f158a3b318b36a4cfa24bf7f81771124f8ffdc454de74a91c7192c2fab",
        "linux_arm64"  => "42ba9bcbe0660968e6933e9023b6c43712f7c8f3a13d53e259bffee74f1f23cc",
        "linux_amd64"  => "0d22e3370417bfbd4b267a4fb4548e693f1c9b279a73cc67a9e8063423848237",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

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
