class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.4"
    checksums = {
        "darwin_arm64" => "e58b5b44b4b48b1dfb9990fc4930ff190fb4ee41c9ce45d0750288bb7a5648fa",
        "darwin_amd64" => "c92f88ba8ac0514e1a8d28cb9a1f04b245d9ad8d4ee60bafa8933130fc7efb44",
        "linux_arm64"  => "f7325ea9e40edf1e335d4f419287f2196a8c8e80168068290a7b87c902dbe1e7",
        "linux_amd64"  => "92d965f6d82af813c9208de22b70fcc39fbcc348d1532032d064e90f1fc527a4",
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
